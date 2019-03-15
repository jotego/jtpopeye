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

module jtpopeye_game(
    input           rst,
    input           clk,        // > 10 MHz
    input           clk_rom,    // SDRAM clock
    output          cen10,      // 10   MHz
    output          cen5,       //  5   MHz
    output          cen8,       //  8   MHz
    output          cen4,       //  4   MHz
    output          cen2,       //  2   MHz
    output   [2:0]  red,
    output   [2:0]  green,
    output   [2:0]  blue,
    output          LHBL,
    output          LVBL,
    output          HS,
    output          VS,
    // cabinet I/O
    input   [ 1:0]  start_button,
    input           coin_input,
    input   [ 4:0]  joystick1,
    input   [ 4:0]  joystick2,

    // SDRAM interface
    input           downloading,
    input           loop_rst,
    output          sdram_re,
    output  [21:0]  sdram_addr,
    input   [31:0]  data_read,

    // ROM LOAD
    input   [21:0]  ioctl_addr,
    input   [ 7:0]  ioctl_data,
    input           ioctl_wr,
    output  [21:0]  prog_addr,
    output  [ 7:0]  prog_data,
    output  [ 1:0]  prog_mask,
    output          prog_we,

    // DIP Switch A
    // input           dip_test,
    // input           dip_pause,
    // input           dip_upright,
    // input           dip_credits2p,
    // input   [3:0]   dip_level, // difficulty level
    // DIP Switch B
    // input           dip_demosnd,
    // input           dip_continue,
    // input   [2:0]   dip_price2,
    // input   [2:0]   dip_price1,
    // input           dip_flip,
    // Sound output
    output  [8:0]   snd,
    output          sample,
    // Debug
    input   [2:0]   gfx_en
);

wire          rst_n;
wire          clk;
wire          cen;
wire          cpu_cen;
wire          pxl_cen;  // TXT pixel clock
wire          pxl2_cen; // OBJ pixel clock

wire [ 7:0]   DD;
    // CPU interface
wire [12:0]   AD;
wire          CSBW_n;
wire          CSV;
wire          DWRBK_n;
wire          MEMWRO;
wire          RV_n;
// DMA
wire          ROHVS;
wire          ROHVCK;
// SDRAM interface
wire [12:0]   obj_addr;
wire [31:0]   objrom_data;
// PROM
wire [10:0]   prog_addr;
wire [ 7:0]   prom_din;    
wire          prom_5n_we;
wire          prom_7j_we;     // timing
wire          prom_4a_we;
wire          prom_5b_we;
wire          prom_5a_we;
wire          prom_3a_we;   
    // output video
wire          HB;         // horizontal blanking
wire          HBD_n;      // HB - DMA
wire          VB;         // vertical blanking

assign HS = HB;
assign VS = VB;
// CPU interface
wire [ 7:0]   DD;
wire [12:0]   AD;
wire          CSBW_n;
wire          CSV;
wire          DWRBK_n;
wire          MEMWRO, DMCS;
wire          RV_n;
// ROM access
wire          main_cs;
wire   [14:0] rom_addr;
wire   [ 7:0] rom_data;
// DIP switches
wire   [7:0]  dip_sw2;
wire   [3:0]  dip_sw1;

jtpopeye_main u_main(
    .rst_n          ( rst_n         ),
    .clk            ( clk           ),
    .cen4           ( cen4          ),
    .cen2           ( cen2          ),
    .LVBL           ( LVBL          ),
    // cabinet I/O
    .joystick1      ( joystick1     ),
    .joystick2      ( joystick2     ),
    .start_button   ( start_button  ),
    .coin_input     ( coin_input    ),
    .service        ( service       ),
    // DMA
    .DMCS           ( DMCS          ),
    .MEMWRO         ( MEMWRO        ),
    // DIP switches
    .dip_sw2        ( dip_sw2       ),
    .dip_sw1        ( dip_sw1       ),
    // ROM access
    .main_cs        ( main_cs       ),
    .rom_addr       ( rom_addr      ),
    .rom_data       ( rom_data      ),

    //
    .RV_n           ( RV_n          ),   // flip
    .cpu_cen        ( cpu_cen       ),
    // Sound output
    .snd            ( snd           )
);

jtpopeye_video u_video(
    .rst_n      ( rst_n         ),
    .clk        ( clk           ),
    .cpu_cen    ( cpu_cen       ),
    .pxl_cen    ( pxl_cen       ),  // TXT pixel clock
    .pxl2_cen   ( pxl2_cen      ),  // OBJ pixel clock

    // CPU interface
    .DD         ( DD            ),
    .AD         ( AD            ),
    .CSBW_n     ( CSBW_n        ),
    .CSV        ( CSV           ),
    .DWRBK_n    ( DWRBK_n       ),
    .MEMWRO     ( MEMWRO        ),
    .RV_n       ( RV_n          ),
    // DMA
    .ROHVS      ( ROHVS         ),
    .ROHVCK     ( ROHVCK        ),
    // SDRAM interface
    .obj_addr   ( obj_addr      ),
    .objrom_data( objrom_data   ),    
    // PROM
    .prog_addr  ( prog_addr     ),
    .prom_din   ( prom_din      ),    
    .prom_5n_we ( prom_5n_we    ),
    .prom_7j_we ( prom_7j_we    ),     // timing
    .prom_4a_we ( prom_4a_we    ),
    .prom_5b_we ( prom_5b_we    ),
    .prom_5a_we ( prom_5a_we    ),
    .prom_3a_we ( prom_3a_we    ),   
    // output video
    .HB         ( HB            ),     // horizontal blanking
    .HBD_n      ( HBD_n         ),     // HB - DMA
    .VB         ( VB            ),     // vertical blanking

    .red        ( red           ),
    .green      ( green         ),
    .blue       ( blue          )      // LSB is always zero
);

endmodule // jtpopeye_game