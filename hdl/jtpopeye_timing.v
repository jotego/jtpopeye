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
    output              INITEO_n,
    // PROM programming
    input   [7:0]       prog_addr,
    input               prom_7j_we,
    input   [3:0]       prom_din
);


wire RV = ~RV_n;
wire [3:0] prom_data;

// H counter
reg [8:0] Hcnt;
wire [7:0] Hnext = Hcnt[7:0] + 8'd1;
reg preHB=1'b0;

always @(*) begin
    H[2:0] = Hcnt[2:0];
    H[7:3] = Hcnt[7:3] ^ RV;
    H2O    = Hcnt[2] ^ RV;
end

reg HBlatch;

always @(posedge clk )
    if(pxl2_cen) begin
        if( !Hnext[7] ) begin
            Hcnt[7:0] <= Hnext;
        end else begin
            preHB <= ~preHB;
            Hcnt[7:0] <= { preHB, preHB, 6'd0 };
            HB <= preHB;
        end
        if( &Hcnt[2:0] ) HBlatch <= HB;
        HBD_n <= ~(HBlatch & HB);
    end

// V counter
wire Vup = prom_data[1];
reg  Vupl;
wire Vup_edge = Vup && !Vupl;

reg [8:0] Vcnt;

always @(*) begin
    V[7:0] = Vcnt[8:1] ^ RV;
end

always @(posedge clk)
    if( pxl2_cen ) begin
        Vupl <= Vup;
        if( Vup_edge ) begin
            Vcnt <= Vcnt+9'd1;
            if( &Vcnt[4:0] ) VB <= &Vcnt[8:6]; // Vertical blank
        end
    end

// V blanking

wire [7:0] prom_addr = { HB, Hcnt[7:1] };

jtgng_prom #(.aw(8),.dw(4),.simfile("../../../rom/tpp2-v.7j")) u_prom_7j(
    .clk    ( clk               ),
    .cen    ( 1'b1              ),
    .data   ( prom_din          ),
    .rd_addr( prom_addr         ),
    .wr_addr( prog_addr[4:0]    ),
    .we     ( prom_7j_we        ),
    .q      ( prom_data          )
);

endmodule // jtpopeye_dma