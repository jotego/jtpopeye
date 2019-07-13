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

// DM count is not encrypted
// DM counter is always counting up but is cleared when
//  * HBDn low (async) sets clear signal
//  * BUSRQ high (async) sets clear signal
//  * clear signal is restored at H[1:0]==2'b11
//  * Counter may stay at 0 for several H cycles
//
// DM count rythm
//  * During readout: count advances at H[1:0]==2'b10 and 
//    H[1:0]==2'b00
//  * Only counts up to 9E in one line because of time limit
//  * During data transfer: count advances at H[1:0]==2'b10
//    so it advances at half the speed
//  * The ryhtm is determined by BUSAK signal latched at
//    H[1:0]==2'b00. Even if DMA count is over, the rythm
//    is not restored until BUSAK signal is sampled again
// DMCS signal is high during data transfer
// DMCSn[3:0] bus advances as expected during data transfer
// 3FF is the last count during transfers, there is no clear
// signal at the end of the count
//
// AD bus is shuffled, from MSB to LSB
// AD: 1, 0, 5, 9, 8, 7, 4, 3, 6, 2 
// DM: 9, 8, 7, 6, 5, 4, 3, 2, 1, 0
//
// ROHVS, ROHVCK
//
// * During transfers ROHVS=0, ROHVCK=1
// * ROHVS goes high at H=00, and low at H=01
// * ROHVCK = ~H[1] | ~ROHVS = ~(H[1]&ROHVS)
// * Boths signals only trip one time after HBDn goes low
//
// Notes grabbed from MAME source code, to compare DMA hardware to emulation
// DMA source mapped to CPU 0x8C00 - 0x8E7F, ram is 0x8800-0x8FFF in real hardware
// DMA transfer is 0x8c00 to 0x8FFF in real hardware but there is not time
// to read the full buffer. Only these ranges are read:
// Unencrypted          Encrypted
// 0x8C00 - 0x8C9E
// 0x8D00 - 0x8D9E
// 0x8E00 - 0x8E9E
// 0x8F00 - 0x8F9E

// DO[15:8] - object's Y
// DO[ 7:0] - object's X, DO[7:3] used to address the object buffer

// DJ[0] - object's Y LSB (interlaced)
// DJ[3:1] - object's Y (mod 8)
// { DJ[17], DJ[10:4] } - object ID
// DJ[16:14] - object's palette
// DJ[11] - hflip
// DJ[13:12] - count start


module jtpopeye_dma(
    input               rst_n,
    input               clk,
    input               pxl_cen /* synthesis direct_enable=1 */,

    input               VB,
    input      [1:0]    H,
    input               HBD_n,
    input               pre_HBDn,
    input      [7:0]    DD_DMA,
    input               busak_n,

    output              ROHVS,
    output reg          ROHVCK,

    output reg [9:0]    AD_DMA,
    output reg          dma_cs, // tell main memory to get data out for DMA
    output reg          busrq_n,
    output     [28:0]   DO /* synthesis keep */
);

reg [10:0] DM;
`ifdef SIMULATION
wire [7:0] ROH  = DO[7:0];
wire [7:0] ROVI_in = DO[15:8];
wire [7:0] DMlow= DM[7:0];
`endif

//wire H0_negedge = !H[0] && Hl[0];

reg VBl;
wire VB_posedge = VB && !VBl;

// Address bus is obfuscated
always @(*) begin
    AD_DMA[6] = DM[1];
    AD_DMA[7] = DM[4];
    AD_DMA[8] = DM[5];
    AD_DMA[9] = DM[6];

    AD_DMA[0] = ~DM[8];
    AD_DMA[1] = ~DM[9];
    AD_DMA[2] = ~DM[0];
    AD_DMA[3] = ~DM[2];
    AD_DMA[4] = ~DM[3];
    AD_DMA[5] = ~DM[7];
end

reg [ 3:0] DMCS;

reg HBDnl;
wire HBDn_negedge = !pre_HBDn && HBDnl;
//wire DMclr = ( VB_posedge || HBDn_negedge) && !dma_cs;
reg DMclr;
wire wait_cpu = !busrq_n && !dma_cs;

reg [1:0] ROHVsr;
assign ROHVS = ROHVsr[1];
    
always @(posedge clk or negedge rst_n)
    if(!rst_n) begin
        VBl <= 1'b0;
        busrq_n <= 1'b1;
        dma_cs  <= 1'b0;
        DM      <= 11'd0;
    end else if(pxl_cen) begin
        case(H)
            2'b00: begin
                VBl <= VB;        
                HBDnl <= pre_HBDn;
                
                if( VB_posedge ) begin
                    busrq_n <= 1'b0;
                    DM <= 11'd0;
                    DMclr <= 1'b1;
                end
                dma_cs <= ~busak_n;
                DMCS <= 4'd0;
                if( dma_cs && !DM[10] ) DMCS[DM[9:8]] <= 1'b1;
                ROHVsr<={ ROHVsr[0], 1'b0 };
            end
            2'b01: begin
                if(!DMclr && !wait_cpu) DM <= DM+11'd1;
                DMCS <= 4'd0;
                ROHVCK <= ~ROHVS;
            end
            2'b10: if( DM[10] ) busrq_n <= 1'b1;
            2'b11: begin                
                if( (VB_posedge || HBDn_negedge || !busrq_n) && !dma_cs ) begin
                    DM <= 11'd0;
                    DMclr <= 1'b1;
                    ROHVsr<=2'b11;
                end
                else begin
                    if( !dma_cs ) DM <= DM+11'd1;   // during DMA transfer only increments at step 01
                    DMclr <= 1'b0;
                end
                ROHVCK <= 1'b1;
            end
        endcase
    end

jtgng_ram #(.aw(8), .dw(8),.synfile("dma_ram0.hex")) u_ram0(
    .clk    ( clk            ),
    .cen    ( pxl_cen        ),
    .data   ( DD_DMA         ),
    .addr   ( DM[7:0]        ),
    .we     ( DMCS[0]        ),
    .q      ( DO[7:0]        )
);

jtgng_ram #(.aw(8), .dw(8),.synfile("dma_ram1.hex")) u_ram1(
    .clk    ( clk            ),
    .cen    ( pxl_cen        ),
    .data   ( DD_DMA         ),
    .addr   ( DM[7:0]        ),
    .we     ( DMCS[1]        ),
    .q      ( DO[15:8]       )
);

jtgng_ram #(.aw(8), .dw(8),.synfile("dma_ram2.hex")) u_ram2(
    .clk    ( clk            ),
    .cen    ( pxl_cen        ),
    .data   ( DD_DMA         ),
    .addr   ( DM[7:0]        ),
    .we     ( DMCS[2]        ),
    .q      ( DO[23:16]      )
);


// Bits 7-5 are not used for the last RAM as the DO bus has only 29 bits
jtgng_ram #(.aw(8), .dw(5),.synfile("dma_ram3.hex")) u_ram3(
    .clk    ( clk            ),
    .cen    ( pxl_cen        ),
    .data   ( DD_DMA[4:0]    ),
    .addr   ( DM[7:0]        ),
    .we     ( DMCS[3]        ),
    .q      ( DO[28:24]      )
);

endmodule // jtpopeye_dma
