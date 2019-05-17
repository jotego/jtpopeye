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

module jtpopeye_video(
    input               rst_n,
    input               clk,
    input               H0_cen,
    input               cpu_cen,
    input               pxl_cen,  // TXT pixel clock
    input               pxl2_cen, // OBJ pixel clock

    input      [ 7:0]   DD,
    // CPU interface
    input      [12:0]   AD,
    input               CSBW_n,
    input               CSV,
    input               DWRBK,
    input               MEMWRO,
    input               RV_n,
    // DMA
    input      [ 7:0]   DD_DMA,
    output              INITEO,
    output     [9:0]    AD_DMA,
    output              dma_cs, // tell main memory to get data out for DMA
    output              busrq_n,
    output              busak_n,
    // SDRAM interface
    output     [12:0]   obj_addr,
    input      [31:0]   objrom_data,    
    // PROM
    input      [10:0]   prog_addr,
    input      [ 7:0]   prom_din,    
    input               prom_5n_we,
    input               prom_7j_we,     // timing
    input               prom_4a_we,
    input               prom_5b_we,
    input               prom_5a_we,
    input               prom_3a_we,   
    // output video
    output              HB,         // horizontal blanking
    output              HBD_n,      // HB - DMA
    output              VB,         // vertical blanking

    output      [2:0]   red,
    output      [2:0]   green,
    output      [2:0]   blue        // LSB is always zero
);

// DMA
wire          ROHVS;
wire          ROHVCK;

wire [3:0] TXTC;
wire [4:0] BAKC;
wire       TXTV;
wire [5:0] OBJC;
wire [1:0] OBJV;

wire [ 7:0] H, V;
wire [ 8:0] ROVI;
wire [17:0] DJ;
wire [28:0] DO;
wire        RV = ~RV_n;
wire        H2O;
wire        INITEO_n;
wire        DM10;
wire        MR_n;

assign INITEO = ~INITEO_n;

jtpopeye_timing u_timing(
    .rst_n              ( rst_n         ),
    .clk                ( clk           ),
    .pxl_cen            ( pxl_cen       ),
    .pxl2_cen           ( pxl2_cen      ),

    .RV_n               ( RV_n          ),     // Flip
    // Counters
    .H                  ( H             ),
    .V                  ( V             ),
    .H2O                ( H2O           ),
    .INITEO_n           ( INITEO_n      ),
    // blankings
    .HB                 ( HB            ),
    .HBD_n              ( HBD_n         ), // HB - DMA
    .VB                 ( VB            ),
    // Interleaving
    .ROHVS              ( ROHVS         ),
    .ROHVCK             ( ROHVCK        ),
    .busak              ( ~busak_n      ),
    .DM10               ( DM10          ),
    .MR_n               ( MR_n          ),
    // PROM programming
    .prog_addr          ( prog_addr[7:0]),
    .prom_7j_we         ( prom_7j_we    ),
    .prom_din           ( prom_din[3:0] )
);

jtpopeye_dma u_dma(
    .rst_n              ( rst_n         ),
    .clk                ( clk           ),
    .cen                ( pxl2_cen      ),

    .VB                 ( VB            ),
    .H                  ( H[1:0]        ),
    .HBD_n              ( HBD_n         ), // HB - DMA
    .DD_DMA             ( DD_DMA        ),
    .DM10               ( DM10          ),
    .MR_n               ( MR_n          ),

    .AD_DMA             ( AD_DMA        ),
    .dma_cs             ( dma_cs        ),
    .busrq_n            ( busrq_n       ),
    .busak_n            ( busak_n       ),
    .DO                 ( DO            )
);

jtpopeye_txt u_txt(
    .rst_n              ( rst_n         ),
    .clk                ( clk           ),
    .pxl_cen            ( pxl_cen       ),
    .cpu_cen            ( cpu_cen       ),

    .AD                 ( AD            ),
    .DD                 ( DD            ),
    .H                  ( H             ),
    .V                  ( V             ),
    .RV                 ( RV            ), // flip
    .CSV                ( CSV           ),
    .MEMWRO             ( MEMWRO        ),

    // PROM
    .prog_addr          ( prog_addr     ),
    .prom_5n_we         ( prom_5n_we    ),
    .prom_din           ( prom_din      ),

    .TXTC               ( TXTC          ),
    .TXTV               ( TXTV          )
);

jtpopeye_buf u_buf(
    .rst_n              ( rst_n         ),
    .clk                ( clk           ),
    .H0_cen             ( H0_cen        ),

    .ROHVS              ( ROHVS         ),
    .ROHVCK             ( ROHVCK        ),
    .RV_n               ( RV_n          ),     // Flip

    .H                  ( H             ),
    .V                  ( V             ),
    .HB                 ( HB            ),
    .H2O                ( H2O           ),
    .DO                 ( DO            ), // gfx buffer

    .ROVI               ( ROVI          ),
    .DJ                 ( DJ            )
);

jtpopeye_bck u_bak(
    .rst_n              ( rst_n         ),
    .clk                ( clk           ),
    .cpu_cen            ( cpu_cen       ),
    .pxl_cen            ( pxl_cen       ),

    .CSBW_n             ( CSBW_n        ),
    .DWRBK              ( DWRBK         ),
    .AD                 ( AD            ),
    .DD                 ( DD            ),
    .ROVI               ( ROVI          ),
    .DO                 ( DO            ), // gfx buffer
    .BAKC               ( BAKC          )
);

jtpopeye_obj u_obj(
    .rst_n              ( rst_n         ),
    .clk                ( clk           ),
    .pxl2_cen           ( pxl2_cen      ),

    .ROHVS              ( ROHVS         ),
    .ROHVCK             ( ROHVCK        ),
    .RV_n               ( RV_n          ),     // Flip
    .INITEO_n           ( INITEO_n      ),

    .H                  ( H             ),
    .DJ                 ( DJ            ),
    .DO                 ( DO            ),
    // SDRAM interface
    .obj_addr           ( obj_addr      ),
    .objrom_data        ( objrom_data   ),
    // pixel data
    .OBJC               ( OBJC          ),
    .OBJV               ( OBJV          )
);

jtpopeye_colmix u_colmix(
    .rst_n              ( rst_n         ),
    .clk                ( clk           ),
    .pxl2_cen           ( pxl2_cen      ),
    // PROM programming
    .prog_addr          ( prog_addr[7:0]),
    .prom_4a_we         ( prom_4a_we    ),
    .prom_5b_we         ( prom_5b_we    ),
    .prom_5a_we         ( prom_5a_we    ),
    .prom_3a_we         ( prom_3a_we    ),
    .prom_din           ( prom_din      ),
    // mixing
    .HBD_n              ( HBD_n         ), // HB - DMA
    .VB_n               ( ~VB           ),
    // video data
    .bakc               ( BAKC          ),
    .objc               ( OBJC          ),
    .objv               ( OBJV          ),
    .txtc               ( TXTC          ),
    .txtv               ( TXTV          ),
    // output video
    .red                ( red           ),
    .green              ( green         ),
    .blue               ( blue          )   // LSB is always zero
);

endmodule // jtpopeye_video