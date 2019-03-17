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
    input               LVBL,
    // cabinet I/O
    input   [4:0]       joystick1,
    input   [4:0]       joystick2,
    input   [1:0]       start_button,
    input               coin_input,
    input               service,
    // DMA
    input               INITEO,
    input               DMCS,
    output reg          MEMWRO, // latched
    output [15:0]       AD,
    output [ 7:0]       DD,
    // video access
    output reg          CSVl,   // latched
    // DIP switches
    input   [7:0]       dip_sw2,
    input   [3:0]       dip_sw1,
    // ROM access
    output              main_cs,
    output [14:0]       rom_addr,
    input  [ 7:0]       rom_data,
    //
    output              RV_n,   // flip
    // Sound output
    output reg [ 9:0]   snd
);

wire [15:0] Ascrambled;
wire iorq_n;
wire wr_n, rd_n, mreq_n;
wire iowr = ~wr_n & ~iorq_n;
wire iord = ~rd_n & ~iorq_n;

reg  [7:0] cabinet_input, ay_dout;
wire [7:0] ram_data, sec_data, cpu_dout;
assign DD = cpu_dout;
reg sec_cs, CSB, CSB_l, CSV, ram_cs, rom_cs, in_cs;
wire CSBW_n = ~(CSB | CSB_l);

assign main_cs = rom_cs;

always @(posedge clk) begin
    CSVl   <= CSV; // latched outputs, do not cen!
    MEMWRO <= ~wr_n & ~mreq_n;
end

////////////////////////////
// device selection
always @(*) begin
    sec_cs = 1'b0;
    CSB    = 1'b0;
    CSV    = 1'b0;  // TXT CS
    ram_cs = 1'b0;
    rom_cs = 1'b0;
    in_cs  = !iorq_n;

    // I do not use mreq_n because it reduces time for SDRAM reads
    if( iorq_n ) begin 
        case ( AD[15:13] )
            3'b1_00: ram_cs = (!mreq_n | DMCS) && !AD[11];
            3'b1_01: CSV = !mreq_n;
            3'b1_10: CSB = !mreq_n;
            3'b1_11: sec_cs = 1'b1;
            default: rom_cs = 1'b1;
        endcase
    end
end

always @(posedge clk) if(cpu_cen) begin
    CSB_l <= CSB;
end

// Address obfuscation
assign AD[2:0]   = ~Ascrambled[2:0]; // 6E
assign AD[ 3]    = ~Ascrambled[4];
assign AD[ 4]    = ~Ascrambled[5];
assign AD[ 5]    = ~Ascrambled[9];
assign AD[ 6]    = Ascrambled[3];  // 6F
assign AD[ 7]    = Ascrambled[6];
assign AD[ 8]    = Ascrambled[7];
assign AD[ 9]    = Ascrambled[8];
assign AD[15:10] = Ascrambled[15:10]; // 6H

///////////////////////////
// Game ROM

assign rom_addr = AD[14:0];

///////////////////////////
// Game RAM

wire RAM_we = ram_cs && !wr_n;

jtgng_ram #(.aw(11)) u_ram(
    .clk    ( clk        ),
    .cen    ( cpu_cen    ),
    .data   ( cpu_dout   ),
    .addr   ( AD[10:0]   ),
    .we     ( RAM_we     ),
    .q      ( ram_data   )
);

///////////////////////////
// Security

wire sec_wr_n = !sec_cs || wr_n;

jtpopeye_security u_security(
    .clk    ( clk      ),
    .cen    ( cpu_cen  ),
    .din    ( cpu_dout ),
    .dout   ( sec_data ),
    .rd_n   ( rd_n     ),
    .wr_n   ( sec_wr_n ),
    .A0     ( AD[0]    )
);

///////////////////////////
// cabinet input
reg ay_cs;

always @(*) begin
    cabinet_input = 8'hff;
    ay_cs = 'b0;
    if( !iorq_n && !rd_n )
        case(AD[1:0])
            2'd0: begin
                ay_cs = 'b1;
                cabinet_input = ay_dout;
            end
            2'd1: begin
                cabinet_input[7]   = coin_input;
                cabinet_input[6]   = service;
                cabinet_input[5]   = INITEO;   // HB ^ RV
                cabinet_input[3:2] = start_button;
            end
            2'd2: begin // 2P input
                cabinet_input[1:0] = joystick2[1:0]; // 2P left, right
                cabinet_input[2]   = joystick2[3]; // 2P up
                cabinet_input[3]   = joystick2[2]; // 2P down
                cabinet_input[4]   = joystick2[4]; // 2P punch
            end
            2'd3: begin // 1P input
                cabinet_input[1:0] = joystick1[1:0]; // 1P left, right
                cabinet_input[2]   = joystick1[3]; // 1P up
                cabinet_input[3]   = joystick1[2]; // 1P down
                cabinet_input[4]   = joystick1[4]; // 1P punch
            end
        endcase
end

///////////////////////////
// CPU data input
reg  [7:0] cpu_din;
wire [7:0] rom_good = {
    rom_data[3], // MSB
    rom_data[4],
    rom_data[2],
    rom_data[5],
    rom_data[1],
    rom_data[6],
    rom_data[0],
    rom_data[7]  // LSB
};

always @(*) begin
    cpu_din = 8'h0;
    case( {rom_cs, ram_cs, in_cs, sec_cs } )
        4'b10_00: cpu_din = rom_good;
        4'b01_00: cpu_din = ram_data;
        4'b00_10: cpu_din = cabinet_input;
        4'b00_01: cpu_din = sec_data;
    endcase
end

`ifndef SIMULATION
T80s u_cpu(
    .RESET_n    ( rst_n       ),
    .CLK        ( clk         ),
    .CEN        ( cpu_cen     ),
    .WAIT_n     ( 1'b1        ),
    .INT_n      ( 1'b1        ),
    .RD_n       ( rd_n        ),
    .WR_n       ( wr_n        ),
    .A          ( Ascrambled  ),
    .DI         ( cpu_din     ),
    .DO         ( cpu_dout    ),
    .IORQ_n     ( iorq_n      ),
    .M1_n       ( m1_n        ),
    .MREQ_n     ( mreq_n      ),
    .NMI_n      ( 1'b1        ),
    .BUSRQ_n    ( ~bus_req    ),
    .BUSAK_n    ( busak_n     ),
    .RFSH_n     ( rfsh_n      ),
    .out0       ( 1'b0        )
);
`else
// This CPU is used for simulation
tv80s #(.Mode(0)) u_cpu (
    .reset_n( rst_n      ),
    .clk    ( clk        ),
    .cen    ( cpu_cen    ),
    .wait_n ( 1'b1       ),
    .int_n  ( 1'b1       ),
    .nmi_n  ( 1'b1       ),
    .rd_n   ( rd_n       ),
    .wr_n   ( wr_n       ),
    .A      ( Ascrambled ),
    .di     ( cpu_din    ),
    .dout   ( cpu_dout   ),
    .iorq_n ( iorq_n     ),
    .m1_n   ( m1_n       ),
    .mreq_n ( mreq_n     ),
    .busrq_n( ~bus_req   ),
    .rfsh_n ( rfsh_n     ),
    .busak_n( busak_n    ),
    // unused
    .halt_n ()
);
`endif

// Dip switches and AY I/O ports
reg  [7:0] dip_data;
wire [7:0] IOA;
wire [2:0] dip_mux = IOA[3:1];
assign RV_n = ~IOA[0];

always @( * ) begin
    dip_data[3:0] = dip_sw1;
    dip_data[6:5] = 3'b000;
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
    .IOA_out( IOA       ),
    .IOB_in ( dip_data  ),
    // unused outputs
    .IOB_out(),
    .A(), .B(), .C()
);

endmodule // jtpopeye_main