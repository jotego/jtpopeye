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

    output reg          ROHVS,
    output reg          ROHVCK,

    output reg [9:0]    AD_DMA,
    output              dma_cs, // tell main memory to get data out for DMA
    output reg          busrq_n,
    output     [28:0]   DO
);

reg [10:0] DM;
`ifdef SIMULATION
wire [7:0] ROH  = DO[7:0];
wire [7:0] ROVI = DO[15:8];
`endif

//wire H0_negedge = !H[0] && Hl[0];

reg VBl;
wire VB_posedge = VB && !VBl;

// Address bus is obfuscated
always @(*) begin
    AD_DMA[2] = DM[0];
    AD_DMA[6] = DM[1];
    AD_DMA[3] = DM[2];
    AD_DMA[4] = DM[3];
    AD_DMA[7] = DM[4];
    AD_DMA[8] = DM[5];
    AD_DMA[9] = DM[6];
    AD_DMA[5] = DM[7];
    AD_DMA[0] = DM[8];
    AD_DMA[1] = DM[9];
end

reg [ 2:0] st;
reg [ 3:0] DMCS;

assign dma_cs = st[1];

always @(posedge clk or negedge rst_n)
    if(!rst_n) begin
        DMCS <= 4'b0;
    end else if(pxl_cen) begin
        DMCS <= 4'b0;
        DMCS[ DM[9:8] ] <= H==2'b10;
    end


always @(posedge clk or negedge rst_n)
    if(!rst_n) begin
        DM <= 11'd0;
    end else if(pxl_cen) begin
        case( st )
            3'b001: begin // video buffer readout
                if( H[0] ) DM <= DM+11'd1;
                if( H==2'b0 ) ROHVS <= 1'b0;
                if(H==2'b11) ROHVCK <= 1'b1;
            end
            3'b010: begin // buffer transfer
                if( H == 2'b01 ) DM <= DM+11'd1;
                ROHVS <= 1'b0;
                ROHVCK <= 1'b1;
            end
            3'b100: begin // DM clear
                DM <= 11'd0;
                ROHVS <= ~pre_HBDn;
                ROHVCK<= !(H==2'b01 || H==2'b10);
            end
        endcase
    end
    
reg HBDnl;
wire HBDn_negedge = !pre_HBDn && HBDnl;
    
always @(posedge clk or negedge rst_n)
    if(!rst_n) begin
        VBl <= 1'b0;
        busrq_n <= 1'b1;
        st <= 3'b001;
    end else begin
        VBl <= VB;        
        HBDnl <= pre_HBDn;
        if( H==2'b10 ) st <= busrq_n ? 3'b001 : 3'b010;
        // busrq_n:
        if( DM[10] ) begin
            busrq_n <= 1'b1;
            st <= 3'b100;
        end
        else if( VB_posedge ) busrq_n <= 1'b0;
        // HBDn
        if( HBDn_negedge && busak_n )
            st <= 3'b100;

    end

jtgng_ram #(.aw(8), .dw(8)) u_ram0(
    .clk    ( clk            ),
    .cen    ( pxl_cen        ),
    .data   ( DD_DMA         ),
    .addr   ( DM[7:0]        ),
    .we     ( DMCS[0]        ),
    .q      ( DO[7:0]        )
);

jtgng_ram #(.aw(8), .dw(8)) u_ram1(
    .clk    ( clk            ),
    .cen    ( pxl_cen        ),
    .data   ( DD_DMA         ),
    .addr   ( DM[7:0]        ),
    .we     ( DMCS[1]        ),
    .q      ( DO[15:8]       )
);

jtgng_ram #(.aw(8), .dw(8)) u_ram2(
    .clk    ( clk            ),
    .cen    ( pxl_cen        ),
    .data   ( DD_DMA         ),
    .addr   ( DM[7:0]        ),
    .we     ( DMCS[2]        ),
    .q      ( DO[23:16]      )
);


// Bits 7-5 are not used for the last RAM as the DO bus has only 29 bits
jtgng_ram #(.aw(8), .dw(5)) u_ram3(
    .clk    ( clk            ),
    .cen    ( pxl_cen        ),
    .data   ( DD_DMA[4:0]    ),
    .addr   ( DM[7:0]        ),
    .we     ( DMCS[3]        ),
    .q      ( DO[28:24]      )
);

endmodule // jtpopeye_dma
