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

// Video schematic sheet 2/3

`timescale 1ns/1ps

module jtpopeye_timing(
    input               rst_n,
    input               clk,
    input               pxl2_cen,   // OBJ pixel runs at twice the speed
    input               pxl_cen,

    input               RV_n,     // Flip

    output  reg [7:0]   V,
    output  reg [7:0]   H,
    output  reg         H2O,
    // blankings
    output reg          HB,
    output reg          HBD_n, // HB - DMA
    output reg          VB,
    output reg          INITEO_n,   // Even/odd frame. 
    output reg          SY_n,       // composite sync
    // HS and VS were not present in the original board
    output reg          HS,
    output reg          VS,
    // Interlacing
    output              ROHVS,
    output              ROHVCK,
    input               DM10,
    input               busak,
    output              MR_n,
    // PROM programming
    input   [7:0]       prog_addr,
    input               prom_7j_we,
    input   [3:0]       prom_din
);


wire RV = ~RV_n;
wire [3:0] prom_data;

// H counter
reg [7:0] Hcnt;
reg [9:0] Vcnt;
wire [8:0] Hnext = {1'b0, Hcnt} + 9'd1;

`ifdef SIMULATION
initial begin
    VB   = 'd0;
end
`endif

always @(*) begin
    H[2:0] = Hcnt[2:0];
    H[7:3] = Hcnt[7:3] ^ RV;
    H2O    = Hcnt[2] ^ RV;
end

reg HBlatch;

//////////////////////////////////////////////////////////
// H counter: This uses an asynchronous reset
// causing a glitch at count transition FE to FF on real
// hardware:
// If The output of EXOR 8C at capacitor C3 is very fast:
// FD, FE, FF/0F, 10, 11, 12...
// If that output is a nice spot:
// count: FD, FE, FF/0F, 00, 01, 02...
// HB:     0   0      0   1   1   1
// If the output is slower
// count: FD, FE, FF/0F, 00, 01, 02...
// HB:     0   0      0   0   1   1
// If the output is even slower, HB will not trip
// Probably the design was targeted for the nice sport
// but I bet some boards out there got HB off by one clock cycle
// This produces a horizontal line interval of 63.488us = 15.75 kHz

always @(posedge clk or negedge rst_n)
    if(!rst_n) begin
        Hcnt <= 'd0;        
        HB   <= 1'b0;
    end else
    if(pxl_cen) begin   // 20.16/4 MHz
        Hcnt[3:0] <= Hcnt[3:0]+4'd1;
        if( &Hcnt[3:0] ) begin
            if( Hcnt[7:4]==4'b1111 ) begin
                Hcnt[5:4] <= 2'd0;
                Hcnt[7:6] <= HB ? 2'b0 : 2'b11;
                HB <= ~HB;
            end else  begin
                Hcnt[7:4] <= Hcnt[7:4]+4'd1;
            end
        end
    end

reg VBl;

always @(posedge clk or negedge rst_n)
    if( !rst_n ) begin
        HBlatch <= 1'b0;
        VBl     <= 1'b0;
        INITEO_n <= 1'b0;
    end else begin
        VBl <= VB;
        if( VB && !VBl ) begin
            HBlatch <= HB;
            INITEO_n <= HB ^ RV;
        end
    end

//////////////////////////////////////////////////////////
// /HBD generation, 7474, 7400, (5C, 5B, video sheet 2/3)
always @(posedge clk or negedge rst_n) begin :HBDn_generator
    reg Hcnt3l;
    if( !rst_n ) begin
        HBD_n  <= 1'b1;
        Hcnt3l <= 1'b0;
    end else begin
        Hcnt3l <= Hcnt[3];
        if( Hcnt[3] && !Hcnt3l) HBD_n <= ~(HBlatch & HB);
    end
end

// V counter
wire Vup = prom_data[1];
reg  Vupl;
wire Vup_edge = Vup && !Vupl;

// The vertical counter is translated directly from the
// 7474 and 74161 gates. It needs to be accurate in order to latch
// HB correctly on INIT_EO signal, which marks the even and odd frames

always @(posedge clk or negedge rst_n) 
    if( !rst_n ) begin
        Vcnt <= 10'd0;
    end else begin
        Vupl <= Vup;
        if( Vup_edge ) begin
            Vcnt[0]   <= ~Vcnt[9] & ~Vcnt[0];   // 8E (first FF)
            Vcnt[8:1] <= Vcnt[9] ? 8'd0 : Vcnt[8:1] + {7'd0,Vcnt[0]}; // 7F, 8F
            Vcnt[9]   <= &Vcnt[8:0];    // 8E (second FF)
            if( &Vcnt[4:0] ) VB <= &Vcnt[8:6]; // Vertical blank
        end
    end

always @(*) begin
    V[7:0] = Vcnt[8:1] ^ RV;    // 6J and 6H
end
// Interleaving

jtpopeye_roh u_roh(
    .clk    ( clk    ),
    .VB_n   ( ~VB    ),
    .AI_n   ( ~H[0]  ),
    .BI_n   ( ~H[1]  ),
    .DM10   ( DM10   ),
    .busak  ( busak  ),
    .HBD_n  ( HBD_n  ),
    .ROHVS  ( ROHVS  ),
    .ROHVCK ( ROHVCK ),
    .MR_n   ( MR_n   )
);
/*
`ifdef SIMULATION
jtpopeye_roh_model u_roh_model(
    .VB_n   ( ~VB    ),
    .AI_n   ( ~H[0]  ),
    .BI_n   ( ~H[1]  ),
    .DM10   ( DM10   ),
    .busak  ( busak  ),
    .HBD_n  ( HBD_n  ),
    .ROHVS  (        ),
    .ROHVCK (        ),
    .MR_n   (        )
);
`endif
*/

// Composite sync
reg pre_SY_n;
reg VB_sampled; // output of FF 6B#9

always @(*) begin : csync
    reg nand_7b_6, nand_5b_11, nand_7b_8, nand_5b_8;
    nand_7b_6  = ~( ~Vcnt[3] & Vcnt[4] & Vcnt[5] & VB );
    nand_5b_11 = ~( ~nand_7b_6 & prom_data[0] );
    nand_7b_8  = ~( nand_7b_6 & VB_sampled & prom_data[1] );
    nand_5b_8  = ~( ~VB_sampled & prom_data[2] );
    pre_SY_n = ~(~nand_5b_11 | ~nand_7b_8 | ~nand_5b_8);
end

always @(posedge clk) begin : latching
    reg last_vcnt3;
    SY_n <= pre_SY_n;
    last_vcnt3 <= Vcnt[3];
    if ( Vcnt[3] && ! last_vcnt3 ) VB_sampled <= VB & (&Vcnt[8:6]);
    if( VB ) begin
        if( Vcnt[5:4]==2'b11 ) VS <= ~Vcnt[3];
    end else VS <= 1'b0;
    if( HB ) begin
        if( Hcnt[5:0]==6'b010_110 ) HS <= 1'b1;
        if( Hcnt[5:0]==6'b100_110 ) HS <= 1'b0;
    end else HS <= 1'b0;
end


// Timing PROM
wire [7:0] prom_addr = { HB, Hcnt[7:1] };

jtgng_prom #(.aw(8),.dw(4),.simfile("../../rom/tpp2-v.7j")) u_prom_7j(
    .clk    ( clk               ),
    .cen    ( 1'b1              ),
    .data   ( prom_din          ),
    .rd_addr( prom_addr         ),
    .wr_addr( prog_addr         ),
    .we     ( prom_7j_we        ),
    .q      ( prom_data         )
);

endmodule // jtpopeye_dma