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
    input               pxl_cen /* synthesis direct_enable=1 */,

    input               VB,
    input      [1:0]    H,
    input               HBD_n,
    input      [7:0]    DD_DMA,
    input               busak_n,

    output              ROHVS,
    output              ROHVCK,

    output reg [9:0]    AD_DMA,
    output              dma_cs, // tell main memory to get data out for DMA
    output              busrq_n,
    output     [28:0]   DO
);

wire [10:0] DM;
`ifdef SIMULATION
wire [7:0] ROH  = DO[7:0];
wire [7:0] ROVI = DO[15:8];
`endif

// wire H0_negedge = !H[0] && Hl[0];

// reg VBl;
// wire VB_posedge = VB && !VBl;

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

// reg DMclr;
// reg last_DMclr;
// wire DMclr_posedge = DMclr && !last_DMclr;
// reg DMclr_nl;

// always @(posedge clk or negedge rst_n) 
//     if(!rst_n) begin
//         DM = 11'd0;
//     end else begin
//         if( H==2'b01 )
//             dma_cs <= ~busak_n;
// 
//         if(!dma_cs && !busrq_n)
//             DMclr <= 1'b0;
//         else if( H==2'b11 ) DMclr <= ~HBD_n | dma_cs;
//         if(H[0]) last_DMclr <= DMclr;
//         // DM counts from H blank to H blank to read all the RAMs
//         // It gets reset when there is a DMA event, i.e. a V blank
//         // The DMA copies 1024 bytes of data during VB
//         DMclr_nl <= ~DMclr_posedge;
//         if (DMclr_posedge) // trip on positive edge. 7400, sheet 1/3 device 1D
//             DM <= 11'd0;
//         else if( !H[0] && (H[1] || busak_n) ) DM <= DM+11'd1;
//         // 7474, 1C
//         if( !H[0] ) begin
//             ROHVS  <= DMclr_posedge | ~DMclr_nl;
//             ROHVCK <= ~(H[1] & ~DMclr_nl);
//         end
//     end


// always @(posedge clk or negedge rst_n)
//     if(!rst_n) begin
//         busrq_n <= 1'b1;
//     end else begin
//         VBl <= VB;
//         if( DM[10] ) busrq_n <= 1'b1; // DMA done
//         else if( VB_posedge ) busrq_n <= 1'b0;
//     end

reg [3:0] DMCS;

reg DMwr;
always @(*) begin
    DMwr = dma_cs && H[1:0] == 2'b01 && !DM[10];
    DMCS[3:0] = 4'd0;
    case( DM[9:8] )
        2'd0: DMCS[0] = DMwr;
        2'd1: DMCS[1] = DMwr;
        2'd2: DMCS[2] = DMwr;
        2'd3: DMCS[3] = DMwr;
    endcase // DM[9:8]
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

//`ifdef SIMULATION
jtpopeye_roh_model uut(
    .VB_n   ( ~VB       ),
    .AI_n   ( ~H[0]     ),
    .BI_n   ( ~H[1]     ),
    .HBD_n  ( HBD_n     ),
    .busak  ( ~busak_n  ),
    .busrq_n( busrq_n   ),
    .ROHVS  ( ROHVS     ),
    .ROHVCK ( ROHVCK    ),
    .DM     ( DM        )
);
//`endif

endmodule // jtpopeye_dma