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

module jtpopeye_dma(
    input               rst_n,
    input               clk,
    input               cen,

    input               VB,
    input      [1:0]    H,
    input               HBD_n,
    input      [7:0]    DD_DMA,
    input               busak_n,
    output              DM10,
    input               MR_n,

    output reg [9:0]    AD_DMA,
    output reg          dma_cs, // tell main memory to get data out for DMA
    output reg          busrq_n,
    output     [28:0]   DO
);

reg [10:0] DM;

reg [1:0] Hl;
wire H0_negedge = !H[0] && Hl[0];

reg VBl;
wire VB_posedge = VB && !VBl;

assign DM10 = DM[10];
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

always @(posedge clk or negedge rst_n) 
    if(!rst_n) begin
        DM = 'd0;
    end else if(cen) begin
        Hl <= H;
        VBl <= VB;
        if( VB_posedge ) 
            DM <= 11'd0;
        else if( H[1:0]==2'b10 || busak_n ) DM <= DM+11'd1;
    end


always @(posedge clk or negedge rst_n)
    if(!rst_n) begin
        busrq_n <= 1'b1;
    end else if(cen) begin
        if( VB_posedge ) busrq_n <= 1'b0;
        if( DM[10]     ) busrq_n <= 1'b1; // DMA done
    end

reg [3:0] DMCS;

always @(*) begin
    dma_cs <= ~DM[10] & ~busak_n & ~H[1];
    DMCS[0] = dma_cs && H[0] && DM[9:8]==2'd0;
    DMCS[1] = dma_cs && H[0] && DM[9:8]==2'd1;
    DMCS[2] = dma_cs && H[0] && DM[9:8]==2'd2;
    DMCS[3] = dma_cs && H[0] && DM[9:8]==2'd3;
end

jtgng_ram #(.aw(8), .dw(8)) u_ram0(
    .clk    ( clk            ),
    .cen    ( cen            ),
    .data   ( DD_DMA         ),
    .addr   ( DM[7:0]        ),
    .we     ( DMCS[0]        ),
    .q      ( DO[7:0]        )
);

jtgng_ram #(.aw(8), .dw(8)) u_ram1(
    .clk    ( clk            ),
    .cen    ( cen            ),
    .data   ( DD_DMA         ),
    .addr   ( DM[7:0]        ),
    .we     ( DMCS[1]        ),
    .q      ( DO[15:8]       )
);

jtgng_ram #(.aw(8), .dw(8)) u_ram2(
    .clk    ( clk            ),
    .cen    ( cen            ),
    .data   ( DD_DMA         ),
    .addr   ( DM[7:0]        ),
    .we     ( DMCS[2]        ),
    .q      ( DO[23:16]      )
);


jtgng_ram #(.aw(8), .dw(5)) u_ram3(
    .clk    ( clk            ),
    .cen    ( cen            ),
    .data   ( DD_DMA[4:0]    ),
    .addr   ( DM[7:0]        ),
    .we     ( DMCS[3]        ),
    .q      ( DO[28:24]      )
);

endmodule // jtpopeye_dma