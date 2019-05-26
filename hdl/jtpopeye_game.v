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
    input           rst_n,
    input           clk,        // 20 MHz
    output          pxl_cen,    //  5.04MHz  TXT pixel clock
    output          pxl2_cen,   // 10.08MHz  OBJ pixel clock

    output   [2:0]  red,
    output   [2:0]  green,
    output   [1:0]  blue,
    output          HB,         // horizontal blanking
    output          VB,         // vertical blanking
    output          HS,
    output          VS,
    output          SY_n,      // original composite sync signal
    // cabinet I/O
    input   [ 1:0]  start_button,
    input           coin_input,
    input   [ 4:0]  joystick1,
    input   [ 4:0]  joystick2,
    input           service,

    // UART
    input           uart_rx,
    output          uart_tx,

    // SDRAM interface
    input           downloading,
    input           loop_rst,
    output          sdram_req,
    output  [21:0]  sdram_addr,
    input   [31:0]  data_read,
    input           data_rdy,
    input           sdram_ack,
    output          refresh_en,

    // ROM LOAD
    input   [21:0]  ioctl_addr,
    input   [ 7:0]  ioctl_data,
    input           ioctl_wr,
    output  [21:0]  prog_addr,
    output  [ 7:0]  prog_data,
    output  [ 1:0]  prog_mask,
    output          prog_we,

    // DIP Switches
    input           dip_pause,  // not a DIP on real hardware
    input           dip_upright,
    input   [1:0]   dip_level, // difficulty level
    input   [1:0]   dip_bonus, 
    input           dip_demosnd,
    input   [3:0]   dip_price,
    input   [1:0]   dip_lives,
    // Sound output
    output  [9:0]   snd,
    output          sample,
    // Debug
    input   [3:0]   gfx_en
);

wire          H0_cen;   //  2.52 MHz
wire          cpu_cen, ay_cen;
// SDRAM interface
wire [12:0]   obj_addr;
wire [31:0]   obj_data;
// PROM
wire [ 5:0]   prom_we;  
wire          prom_7j_we = prom_we[0];     // timing
wire          prom_5b_we = prom_we[1];
wire          prom_5a_we = prom_we[2];
wire          prom_4a_we = prom_we[3];
wire          prom_3a_we = prom_we[4];   
wire          prom_5n_we = prom_we[5];      // TXT
    // output video
wire          HBD_n;      // HB - DMA
wire [9:0]    AD_DMA;
wire          dma_cs;     // tell main memory to get data out for DMA
wire          busrq_n, busak_n;


// CPU interface
wire [ 7:0]   DD, DD_DMA;
wire [15:0]   AD;
wire          CSBW_n;
wire          CSV;
wire          DWRBK;
wire          MEMWRO;
wire          RV_n, INITEO;
// ROM access
wire          main_cs, ready;
wire   [14:0] main_addr;
wire   [ 7:0] main_data;
// DIP switches
wire   [7:0]  dip_sw2 = { dip_upright, dip_demosnd, dip_bonus, 
                            dip_level, dip_lives };
wire   [3:0]  dip_sw1 = dip_price;
wire          encrypted;    // is this an encrypted ROM?
wire          main_ok;

jtpopeye_cen u_cen(
    .clk        ( clk           ),  // 20 MHz
    .H0_cen     ( H0_cen        ),
    .cpu_cen    ( cpu_cen       ),
    .ay_cen     ( ay_cen        ),
    .pxl_cen    ( pxl_cen       ),  // TXT pixel clock
    .pxl2_cen   ( pxl2_cen      )   // OBJ pixel clock
);

assign sample = ay_cen;

jtpopeye_prom_we u_prom_we(
    .clk_rom        ( clk           ),
    .clk_rgb        ( clk           ),
    .downloading    ( downloading   ),
    .ioctl_addr     ( ioctl_addr    ),
    .ioctl_data     ( ioctl_data    ),
    .ioctl_wr       ( ioctl_wr      ),
    .prog_addr      ( prog_addr     ),
    .prog_data      ( prog_data     ),
    .prog_mask      ( prog_mask     ), // active low
    .prog_we        ( prog_we       ),
    .prom_we        ( prom_we       ),
    .encrypted      ( encrypted     )
);

jtpopeye_rom u_rom(
    .rst_n       ( rst_n         ),
    .clk         ( clk           ),

    .main_addr   ( main_addr     ), // 32 kB, addressed as 8-bit words
    .obj_addr    ( obj_addr      ), // 32 kB

    .main_dout   ( main_data     ),
    .main_cs     ( main_cs       ),
    .main_ok     ( main_ok       ),
    .obj_dout    ( obj_data      ),
    .ready       ( ready         ),
    // SDRAM interface
    .downloading ( downloading   ),
    .data_rdy    ( data_rdy      ),
    .sdram_req   ( sdram_req     ),
    .sdram_ack   ( sdram_ack     ),
    .loop_rst    ( loop_rst      ),
    .sdram_addr  ( sdram_addr    ),
    .data_read   ( data_read     ),
    .refresh_en  ( refresh_en    )
);

reg [1:0] main_rst_n=2'b0;
always @(negedge clk) begin
    if( !ready || !rst_n )
        main_rst_n <= 2'b0;
    else
        main_rst_n <= { main_rst_n[0], 1'b1 };
end

jtpopeye_main u_main(
    .rst_n          ( main_rst_n[1] ),
    .clk            ( clk           ),
    .cpu_cen        ( cpu_cen       ),
    .ay_cen         ( ay_cen        ),
    .encrypted      ( encrypted     ),
    // cabinet I/O
    .joystick1      ( joystick1     ),
    .joystick2      ( joystick2     ),
    .start_button   ( start_button  ),
    .coin_input     ( coin_input    ),
    .service        ( service       ),
    // DMA
    .INITEO         ( INITEO        ),
    .MEMWRO         ( MEMWRO        ),
    .AD             ( AD            ),
    .DD             ( DD            ),
    .DD_DMA         ( DD_DMA        ),
    .AD_DMA         ( AD_DMA        ),
    .dma_cs         ( dma_cs        ),
    .busrq_n        ( busrq_n       ),
    .busak_n        ( busak_n       ),
    // UART
    .uart_rx        ( uart_rx       ),
    .uart_tx        ( uart_tx       ),
    // Video Access
    .CSBW_n         ( CSBW_n        ),
    .CSVl           ( CSV           ), // CSVl is CSV latched (1-clock delay, no cen)
    .DWRBK          ( DWRBK         ),
    .VB             ( VB            ),
    // DIP switches
    .dip_sw2        ( dip_sw2       ),
    .dip_sw1        ( dip_sw1       ),
    // ROM access
    .rom_cs         ( main_cs       ),
    .rom_addr       ( main_addr     ),
    .rom_data       ( main_data     ),
    .rom_ok         ( main_ok       ),

    .RV_n           ( RV_n          ),   // flip
    // Sound output
    .snd            ( snd           )
);

jtpopeye_video u_video(
    .rst_n      ( rst_n         ),
    .clk        ( clk           ),
    .H0_cen     ( H0_cen        ),
    .cpu_cen    ( cpu_cen       ),
    .pxl_cen    ( pxl_cen       ),  // TXT pixel clock
    .pxl2_cen   ( pxl2_cen      ),  // OBJ pixel clock

    // CPU interface
    .DD         ( DD            ),
    .AD         ( AD[12:0]      ),
    .CSBW_n     ( CSBW_n        ),
    .CSV        ( CSV           ),
    .DWRBK      ( DWRBK         ),
    .MEMWRO     ( MEMWRO        ),
    .RV_n       ( RV_n          ),
    // DMA
    .DD_DMA     ( DD_DMA        ),
    .INITEO     ( INITEO        ),
    .AD_DMA     ( AD_DMA        ),
    .dma_cs     ( dma_cs        ),
    .busrq_n    ( busrq_n       ),
    .busak_n    ( busak_n       ),
    // SDRAM interface
    .obj_addr   ( obj_addr      ),
    .objrom_data( obj_data      ),    
    // PROM
    .prog_addr  ( prog_addr[10:0]),
    .prom_din   ( prog_data     ),    
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
    .HS         ( HS            ),
    .VS         ( VS            ),
    .SY_n       ( SY_n          ),

    .red        ( red           ),
    .green      ( green         ),
    .blue       ( blue          )      // LSB is always zero
);

endmodule // jtpopeye_game