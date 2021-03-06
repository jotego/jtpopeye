/*  This file is part of JTPOPEYE.
    JTPOPEYE program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    JTPOPEYE program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with JTPOPEYE.  If not, see <http://www.gnu.org/licenses/>.

    Author: Jose Tejada Gomez. Twitter: @topapate
    Version: 1.0
    Date: 12-3-2019 */

`timescale 1ns/1ps

//  5.04MHz  TXT pixel clock
// 10.08MHz  OBJ pixel clock
// 20.16MHz  OBJ pixel clock x2

module jtpopeye_game(
    input           rst,
    input           clk,        // 48 MHz
    output          pxl_cen,    //  5.04MHz  TXT pixel clock
    output          pxl2_cen,   // 10.08MHz  OBJ pixel clock

    output   [2:0]  red,
    output   [2:0]  green,
    output   [2:0]  blue,
    output          LHBL,
    output          LVBL,
    output          LHBL_dly,
    output          LVBL_dly,
    output          HS,
    output          VS,
    output          field,
    // cabinet I/O
    input   [ 1:0]  start_button,
    input   [ 1:0]  coin_input,
    input   [ 6:0]  joystick1,
    input   [ 6:0]  joystick2,
    // SDRAM interface
    input           downloading,
    output          dwnld_busy,
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
    output          prog_rd,

    // DIP Switches
    input   [31:0]  status,
    input           dip_pause,
    input           dip_flip,
    input           dip_test,
    input   [ 1:0]  dip_fxlevel, // Not a DIP on the original PCB    
    // Sound output
    output  [15:0]  snd,        // unsigned
    output          sample,
    input           enable_psg, // unused
    input           enable_fm,  // unused
    // Debug
    input   [3:0]   gfx_en
);

// These signals are used by games which need
// to read back from SDRAM during the ROM download process
assign prog_rd    = 1'b0;
assign dwnld_busy = downloading;
assign snd[5:0]   = 6'd0;
wire   pause      = ~dip_pause;

wire    rst_n = ~rst;
wire    pxl4_cen;
assign  blue[0] = blue[2];
wire    HB;       // horizontal blanking
wire    VB;       // vertical blanking
wire    SY_n;     // original composite sync signal
wire    INITEO;   // INIT EVEN/ODD interlaced video frame
wire    service = ~joystick1[5];

assign LHBL = LHBL_dly; // ~HB;
assign LVBL = LVBL_dly; // ~VB;
assign field = INITEO;

wire          H0_cen;   //  2.52 MHz
wire          cpu_cen, ay_cen;
// SDRAM interface
wire [12:0]   obj_addr;
wire [15:0]   obj_data0, obj_data1;
// PROM
wire [13:0]   prom_we;  
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
wire          RV_n;
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

wire [3:0] pxls_cen;
// wire obj_pxl_cen, txt_pxl_cen;

assign pxl4_cen = pxls_cen[0];
assign pxl2_cen = pxls_cen[1];
assign pxl_cen  = pxls_cen[2];
assign H0_cen   = pxls_cen[3];

jtframe_frac_cen #(4) u_cen_video(
    .clk    ( clk       ),  // 48MHz
    .n      ( 10'd21    ),  // numerator
    .m      ( 10'd50    ),  // denominator
    .cen    ( pxls_cen  ),  // 20.16 MHz
    .cenb   (           )
);

jtframe_frac_cen #(2) u_cen_cpu(
    .clk    ( clk       ),  // 48MHz
    .n      ( 10'd1     ),  // numerator
    .m      ( 10'd12    ),  // denominator
    .cen    ( {ay_cen, cpu_cen} ),  // 4 MHz
    .cenb   (           )
);

assign sample = ay_cen;

wire [ 1:0] dip_level;
wire [ 1:0] dip_lives;
wire [ 1:0] dip_bonus;
wire        dip_upright;
wire        dip_demosnd;
wire [ 3:0] dip_price;
wire        skyskipper;

jtpopeye_dip u_dip(
    .clk        ( clk         ),
    .status     ( status      ),
    .dip_level  ( dip_level   ),
    .dip_lives  ( dip_lives   ),
    .dip_bonus  ( dip_bonus   ),
    .dip_upright( dip_upright ),
    .dip_demosnd( dip_demosnd ),
    .dip_price  ( dip_price   ),
    .skyskipper ( skyskipper  )
);


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

`ifndef MISTER
jtframe_rom #(
    .SLOT6_AW    ( 15     ),    // main
    .SLOT6_DW    ( 8      ),
    .SLOT6_OFFSET( 0      )
) u_rom(
    .rst         ( ~rst_n        ),
    .clk         ( clk           ),
    .vblank      ( VB            ),

    .slot0_cs    ( 1'b0          ),
    .slot1_cs    ( 1'b0          ),
    .slot2_cs    ( 1'b0          ),
    .slot3_cs    ( 1'b0          ),
    .slot4_cs    ( 1'b0          ),
    .slot5_cs    ( 1'b0          ),
    .slot6_cs    ( main_cs       ),
    .slot7_cs    ( 1'b0          ),
    .slot8_cs    ( 1'b0          ),

    .slot6_addr  ( main_addr     ), // 32 kB, addressed as 8-bit words
    .slot6_ok    ( main_ok       ),
    .slot6_dout  ( main_data     ),

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
`else 
jtpopeye_bram u_rom(
    .clk         ( clk             ),
    // ROM loading
    .prog_addr   ( prog_addr[14:0] ),
    .prog_data   ( prog_data       ),
    .prom_we     ( prom_we[9:6]    ),

    .main_addr   ( main_addr       ), // 32 kB, addressed as 8-bit words
    .main_dout   ( main_data       ),
    .main_cs     ( main_cs         )
);
assign main_ok = 1'b1;
assign ready   = 1'b1;
`endif

jtpopeye_objrom u_objrom(
    .clk         ( clk             ),
    // ROM loading
    .prog_addr   ( prog_addr[12:0] ),
    .prog_data   ( prog_data       ),
    .prom_we     ( prom_we[13:10]  ),

    .obj_addr    ( obj_addr        ), // 32 kB
    .obj_dout0   ( obj_data0       ),
    .obj_dout1   ( obj_data1       )
);

reg [1:0] main_rst_n=2'b0;
always @(negedge clk) begin
    if( !ready || !rst_n )
        main_rst_n <= 2'b0;
    else
        main_rst_n <= { main_rst_n[0], 1'b1 };
end

wire rom_rst_n = main_rst_n[1];

jtpopeye_main u_main(
    .rst_n          ( rom_rst_n     ),
    .clk            ( clk           ),
    .cpu_cen        ( cpu_cen       ),
    .ay_cen         ( ay_cen        ),
    .encrypted      ( encrypted     ),
    .skyskipper     ( skyskipper    ),
    .pause          ( pause         ),
    // cabinet I/O
    .joystick1      (~joystick1[4:0]),
    .joystick2      (~joystick2[4:0]),
    .start_button   (~start_button  ),
    .coin_input     (~coin_input[0] ),
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
    .snd            ( snd[15:6]     )
);

jtpopeye_video u_video(
    .rst_n      ( rom_rst_n     ),
    .clk        ( clk           ),
    .H0_cen     ( H0_cen        ),
    .cpu_cen    ( cpu_cen       ),
    .pxl_cen    ( pxl_cen       ),  // TXT pixel clock
    .pxl2_cen   ( pxl2_cen      ),  // OBJ pixel clock
    .gfx_en     ( {gfx_en[3], gfx_en[1:0]} ),
    .pause      ( pause         ),

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
    .obj_data0  ( obj_data0     ), 
    .obj_data1  ( obj_data1     ), 
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
    .LHBL_dly   ( LHBL_dly      ),
    .LVBL_dly   ( LVBL_dly      ),
    .red        ( red           ),
    .green      ( green         ),
    .blue       ( blue[2:1]     )      // LSB is always zero
);

endmodule // jtpopeye_game