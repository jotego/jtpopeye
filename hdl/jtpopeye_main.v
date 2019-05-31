/*  This file is part of JTPOPEYE.
    JTPOPEYE program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    JTPOPEYE program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR AD PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with JTPOPEYE.  If not, see <http://www.gnu.org/licenses/>.

    Author: Jose Tejada Gomez. Twitter: @topapate
    Version: 1.0
    Date: 12-3-2019 */

`timescale 1ns/1ps

module jtpopeye_main(
    input               rst_n,
    input               clk,
    input               cpu_cen,
    input               ay_cen,
    input               encrypted,
    // cabinet I/O
    input   [4:0]       joystick1,
    input   [4:0]       joystick2,
    input   [1:0]       start_button,
    input               coin_input,
    input               service,
    // DMA
    input               INITEO,
    output reg          MEMWRO, // latched
    output reg [15:0]   AD,
    output     [ 7:0]   DD,
    output     [ 7:0]   DD_DMA,
    input      [ 9:0]   AD_DMA,
    input               dma_cs, // tell main memory to get data out for DMA
    input               busrq_n,
    output              busak_n,
    // serial wires
    input               uart_rx,
    output              uart_tx, // serial signal to transmit. High when idle
    // video access
    output reg          CSBW_n,
    output reg          CSVl,   // latched
    output reg          DWRBK,
    input               VB,
    // DIP switches
    input   [7:0]       dip_sw2,
    input   [3:0]       dip_sw1,
    // ROM access
    output reg          rom_cs,
    output reg [14:0]   rom_addr,
    input  [ 7:0]       rom_data,
    input               rom_ok,
    //
    output              RV_n,   // flip
    // Sound output
    output     [ 9:0]   snd
);

wire [15:0] Ascrambled;
wire iorq_n;
wire wr_n, rd_n, mreq_n;
wire iowr = ~wr_n & ~iorq_n;
// wire iord = ~rd_n & ~iorq_n;

reg  [7:0] cabinet_input;
wire [7:0] ram_data, sec_data, cpu_dout, ay_dout;
assign DD     = cpu_dout;
assign DD_DMA = ram_data;
reg sec_cs, CSB, CSB_l, CSV, ram_cs;
wire uart_cs = !iorq_n && AD[7:4]==4'hf;

// UART
wire [7:0] uart_rx_data;
wire       uart_rx_done, uart_rx_error;
wire       uart_tx_done, uart_tx_busy;

reg        uart_tx_wr;
reg [7:0]  uart_tx_data;

always @(posedge clk) begin
    CSVl   <= CSV; // latched outputs, do not cen!
    MEMWRO <= ~wr_n & ~mreq_n;
    DWRBK  <= CSB & ~wr_n;
    CSBW_n <= ~(CSB | CSB_l);
end

////////////////////////////
// device selection
always @(*) begin
    sec_cs = 1'b0;
    CSB    = 1'b0;
    CSV    = 1'b0;  // TXT CS
    ram_cs = 1'b0;
    rom_cs = 1'b0;

    if( !mreq_n ) begin
        case ( AD[15:13] )
            3'b1_00: ram_cs = AD[11];   // RAM: from 0x8800 to 0x8FFF
            3'b1_01: CSV = 1'b1;        // TXT. 0xA???
            3'b1_10: CSB = 1'b1;        // Background. 0xC000-0xCFFF lower nibbles
                                        // 0xD000-0xDFFF upper nibbles
            3'b1_11: sec_cs = 1'b1;     // Security at E000/1
            default: rom_cs = 1'b1;
        endcase
    end
end

always @(posedge clk) if(cpu_cen) begin
    CSB_l <= CSB;
end

///////////////////////////
// Game ROM
reg [7:0] rom_good;

always @(*) if(encrypted) begin
    // Address obfuscation
    AD[2:0]   = ~Ascrambled[2:0]; // 6E
    AD[ 3]    = ~Ascrambled[4];
    AD[ 4]    = ~Ascrambled[5];
    AD[ 5]    = ~Ascrambled[9];
    AD[ 6]    =  Ascrambled[3];  // 6F
    AD[ 7]    =  Ascrambled[6];
    AD[ 8]    =  Ascrambled[7];
    AD[ 9]    =  Ascrambled[8];
    AD[15:10] =  Ascrambled[15:10]; // 6H
    // Original ROM contents are scrambled, fix it:
    rom_addr = AD[14:0];
    rom_good = {
        rom_data[3], // MSB
        rom_data[4],
        rom_data[2],
        rom_data[5],
        rom_data[1],
        rom_data[6],
        rom_data[0],
        rom_data[7]  // LSB
    };
end else begin
    AD       = Ascrambled;
    rom_addr = Ascrambled[14:0];
    rom_good = rom_data;
end



///////////////////////////
// Game RAM

reg [ 7:0] ram_din;
reg [10:0] ram_addr;
reg ram_we;

always @(posedge clk) begin
    if( dma_cs )
        ram_addr <= {1'b1, AD_DMA};
    else begin
        if(ram_cs) ram_addr <= AD[10:0];
    end
    if( ram_cs && !wr_n ) begin
        ram_we  <= 1'b1;
        ram_din <= cpu_dout;
    end
    else ram_we <= 1'b0;
end

jtgng_ram #(.aw(11)) u_ram(
    .clk    ( clk        ),
    .cen    ( cpu_cen    ),
    .data   ( ram_din    ),
    .addr   ( ram_addr   ),
    .we     ( ram_we     ),
    .q      ( ram_data   )
);

///////////////////////////
// Security

jtpopeye_security u_security(
    .clk    ( clk      ),
    .cen    ( cpu_cen  ),
    .rst_n  ( rst_n    ),
    .din    ( cpu_dout ),
    .dout   ( sec_data ),
    .rd_n   ( rd_n     ),
    .wr_n   ( wr_n     ),
    .cs     ( sec_cs   ),
    .A0     ( AD[0]    )
);

///////////////////////////
// cabinet input
reg ay_cs;

always @(*) begin
    ay_cs = 1'b0;
    case(AD[1:0])
        2'd0: begin
            ay_cs = !iorq_n && !rd_n;
            cabinet_input = ay_dout;
        end
        2'd1: begin
            cabinet_input[7]   = coin_input;
            cabinet_input[6]   = service;
            cabinet_input[5]   = INITEO;   // HB ^ RV
            cabinet_input[4]   = 1'b1;
            cabinet_input[3:2] = start_button;
            cabinet_input[1:0] = 2'b11;
        end
        2'd2: begin // 2P input
            cabinet_input[7:5] = ~3'b0;
            cabinet_input[4:0] = joystick2[4:0]; // 2P
        end
        2'd3: begin // 1P input
            cabinet_input[7:5] = ~3'b0;
            cabinet_input[4:0] = joystick1[4:0]; // 2P
        end
    endcase
end

///////////////////////////
// CPU data input
reg  [7:0] cpu_din;
reg        clr_uart;
reg        uart_rx_new; // signals that a new byte is ready to be read

always @(*) begin
    cpu_din  = 8'h0;
    clr_uart = 1'b0;
    case( {mreq_n, iorq_n} )
        2'b01:  // Memory request
            case( { rom_cs, ram_cs, sec_cs } )
                3'b10_0: cpu_din = rom_good;
                3'b01_0: cpu_din = ram_data;
                3'b00_1: cpu_din = sec_data;
                default:;
            endcase
        2'b10: // I/O request
            if( uart_cs ) begin
                casez( AD[1:0] )
                    2'b00: cpu_din = { 7'd0, uart_rx_new  }; // Rx status
                    2'b01: cpu_din = { 7'd0, uart_tx_busy }; // Tx status
                    2'b1?: begin
                        cpu_din = uart_rx_data;
                        clr_uart = !rd_n;
                    end
                    default:;
                endcase
            end
            else cpu_din = cabinet_input;
        default:;
    endcase
end

always @(posedge clk or negedge rst_n)
    if( !rst_n ) begin
        uart_rx_new <= 1'b0;
    end else begin
        if( uart_rx_done ) uart_rx_new <= 1'b1;
        if( clr_uart     ) uart_rx_new <= 1'b0;
    end

////////////////////////////////
// NMI generation
reg nmi_n, VBl;

always @(posedge clk or negedge rst_n)
    if(!rst_n) begin
        nmi_n <= 1'b1;
    end else if(cpu_cen) begin
        VBl <= VB;
        if( !AD[9] )
            nmi_n <= 1'b1; // clear NMI
        else if( VB && !VBl ) nmi_n <= 1'b0; // set NMI
    end

/////////////////////////////////
// wait_n signal. This is used to avoid issues when
// waiting for data from SDRAM. Real hardware had wait_n stuck at 1
// SDRAM access is fast and wait_n should rarely go low but it
// is there for robustness

reg  wait_n;
reg  last_rom_cs;
wire rom_cs_posedge = !last_rom_cs && rom_cs;

always @(posedge clk or negedge rst_n)
    if( !rst_n ) begin
        wait_n   <= 1'b1;
    end else begin
        last_rom_cs <= rom_cs;
        if( rom_cs_posedge ) begin
            wait_n <= 1'b0;
        end
        else begin
            if(rom_ok) wait_n <= 1'b1;
        end
    end

jtframe_z80 u_cpu(
    .rst_n      ( rst_n       ),
    .clk        ( clk         ),
    .cen        ( cpu_cen     ),
    .wait_n     ( wait_n      ),
    .int_n      ( 1'b1        ),
    .nmi_n      ( nmi_n       ),
    .busrq_n    ( busrq_n     ),
    .m1_n       (             ),
    .mreq_n     ( mreq_n      ),
    .iorq_n     ( iorq_n      ),
    .rd_n       ( rd_n        ),
    .wr_n       ( wr_n        ),
    .rfsh_n     (             ),
    .halt_n     (             ),
    .busak_n    ( busak_n     ),
    .A          ( Ascrambled  ),
    .din        ( cpu_din     ),
    .dout       ( cpu_dout    )
);

// Dip switches and AY I/O ports
reg  [7:0] dip_data;
wire [7:0] IOB;
wire [2:0] dip_mux = IOB[3:1];
assign RV_n = ~IOB[0];

always @( * ) begin
    dip_data[3:0] = dip_sw1;
    dip_data[6:5] = 2'b00;
    dip_data[7] = dip_sw2[dip_mux];
end

wire bc = (iowr & AD[0]) | ay_cs;

// Each audio output has a different filter on it!
// To do: proper filter stage

jt49_bus u_ay( // note that input ports are not multiplexed
    .rst_n  ( rst_n     ),
    .clk    ( clk       ),
    .clk_en ( ay_cen    ),
    .bdir   ( iowr      ),
    .bc1    ( bc        ),
    .din    ( cpu_dout  ),
    .sel    ( 1'b0      ),
    .dout   ( ay_dout   ),
    .sound  ( snd       ),
    .IOA_in ( dip_data  ),
    .IOB_out( IOB       ),
    // unused outputs
    .IOB_in ( 8'h0      ),  // IOB used as output
    .IOA_out(),             // IOA used as input
    .A(), .B(), .C()
);

//////////////////////////////////////////////
// UART
// This was not present on the original arcade
// this is used for having fun with TinyBASIC

always @(posedge clk or negedge rst_n )
    if( !rst_n ) begin
        uart_tx_data = 8'd0;
        uart_tx_wr   = 1'b0;
    end else if(cpu_cen) begin
        if( uart_cs  && !wr_n) begin
            uart_tx_data <= cpu_dout;
            uart_tx_wr   <= 1'b1;
        end else begin
            uart_tx_wr   <= 1'b0;
        end
    end

jtframe_uart #(.CLK_DIVIDER(5'd3),.UART_DIVIDER(5'd23)) // 57600 bps
u_uart(
    .rst_n      ( rst_n         ),
    .clk        ( clk           ),
    .cen        ( cpu_cen       ),
    // serial wires
    .uart_rx    ( uart_rx       ),
    .uart_tx    ( uart_tx       ), // serial signal to transmit. High when idle
    // Rx interface
    .rx_data    ( uart_rx_data  ),
    .rx_done    ( uart_rx_done  ),
    .rx_error   ( uart_rx_error ),
    // Tx interface
    .tx_done    ( uart_tx_done  ),
    .tx_data    ( uart_tx_data  ),
    .tx_busy    ( uart_tx_busy  ),
    .tx_wr      ( uart_tx_wr    )  // write strobe
);

///////////////////////////////////
// Dump ROM access to a file
`ifdef SIMULATION
integer file_rom;
initial begin
    file_rom=$fopen("rom_access.txt");
end

always @(posedge rom_cs) begin
    $fdisplay(file_rom,"%4X (%4X)", Ascrambled[14:0], rom_addr );
end
`endif

endmodule // jtpopeye_main