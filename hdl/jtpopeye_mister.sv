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

`ifndef MISTER
`define MISTER
`endif

module emu
(
    //Master input clock
    input         CLK_50M,

    //Async reset from top-level module.
    //Can be used as initial reset.
    input         RESET,

    //Must be passed to hps_io module
    inout  [44:0] HPS_BUS,

    //Base video clock. Usually equals to CLK_SYS.
    output        VGA_CLK,

    //Multiple resolutions are supported using different VGA_CE rates.
    //Must be based on CLK_VIDEO
    output        VGA_CE,

    output  [7:0] VGA_R,
    output  [7:0] VGA_G,
    output  [7:0] VGA_B,
    output        VGA_HS,
    output        VGA_VS,
    output        VGA_DE,    // = ~(VBlank | HBlank)
    output  reg   VGA_F1,    // Interlaced field

    //Base video clock. Usually equals to CLK_SYS.
    output        HDMI_CLK,

    //Multiple resolutions are supported using different HDMI_CE rates.
    //Must be based on CLK_VIDEO
    output        HDMI_CE,

    output  [7:0] HDMI_R,
    output  [7:0] HDMI_G,
    output  [7:0] HDMI_B,
    output        HDMI_HS,
    output        HDMI_VS,
    output        HDMI_DE,   // = ~(VBlank | HBlank)
    output  [1:0] HDMI_SL,   // scanlines fx

    //Video aspect ratio for HDMI. Most retro systems have ratio 4:3.
    output  [7:0] HDMI_ARX,
    output  [7:0] HDMI_ARY,

    output        LED_USER,  // 1 - ON, 0 - OFF.

    // b[1]: 0 - LED status is system status OR'd with b[0]
    //       1 - LED status is controled solely by b[0]
    // hint: supply 2'b00 to let the system control the LED.
    output  [1:0] LED_POWER,
    output  [1:0] LED_DISK,

    output [15:0] AUDIO_L,
    output [15:0] AUDIO_R,
    output        AUDIO_S,   // 1 - signed audio samples, 0 - unsigned

    output  [1:0] ROTATE,

    //SDRAM interface with lower latency
    output        SDRAM_CLK,
    output        SDRAM_CKE,
    output [12:0] SDRAM_A,
    output  [1:0] SDRAM_BA,
    inout  [15:0] SDRAM_DQ,
    output        SDRAM_DQML,
    output        SDRAM_DQMH,
    output        SDRAM_nCS,
    output        SDRAM_nCAS,
    output        SDRAM_nRAS,
    output        SDRAM_nWE
    `ifdef SIMULATION
    ,output         sim_pxl_cen,
    output          sim_pxl_clk,
    output          sim_vs,
    output          sim_hs
    `endif    
);

`include "build_id.v" 
localparam CONF_STR = {
    "JTPOP;;",
    "O1,Credits,OFF,ON;",
    "-;",
    "F,rom;",
    "O2,Aspect Ratio,Original,Wide;",
    "O35,Scandoubler Fx,None,HQ2x,CRT 25%,CRT 50%,CRT 75%;",
    "OGH,Difficulty,Normal,Easy,Hard,Very hard;",
    "OIJ,Lives,4,3,2,1;",  // 18    
    "OKL,Bonus,40k,60k,80k,No Bonus;",
//     "O9,Sky Skipper,No,Yes;",    
//     "OA,HDMI interlaced,No,Yes;",
    "-;",
    "R0,Reset;",
    "J,Punch,Start 1P,Start 2P,Coin,Pause;",
    "V,v",`BUILD_DATE, " http://patreon.com/topapate;"
};

/// SDRAM is not used:
assign SDRAM_DQ  = 16'hzzzz;
assign SDRAM_CLK =  1'b0;
assign SDRAM_CKE =  1'b0;
assign SDRAM_A   = 13'b0;
assign SDRAM_BA  =  2'b0;
assign SDRAM_DQML=  1'b1;
assign SDRAM_DQMH=  1'b1;
assign SDRAM_nCS =  1'b1;
assign SDRAM_nCAS=  1'b1;
assign SDRAM_nRAS=  1'b1;
assign SDRAM_nWE =  1'b1;
////////////////////   CLOCKS   ///////////////////

wire clk_sys;
wire pll_locked;

pll pll(
    .refclk     ( CLK_50M    ),
    .rst        ( 1'b0       ),
    .locked     ( pll_locked ),
    .outclk_0   ( clk_sys    )
);

///////////////////////////////////////////////////

wire [31:0] status;
wire  [1:0] buttons;

wire        ioctl_wr;
wire [24:0] ioctl_addr;
wire  [7:0] ioctl_data;

wire [10:0] ps2_key;
wire [15:0] joy_0, joy_1;

wire        forced_scandoubler;
wire        downloading;
wire        rst_n;

assign LED_USER  = downloading;
assign LED_DISK  = 2'b0;
assign LED_POWER = 2'b0;

wire skyskipper      = 1'b0; // status[32'd9];
wire HDMI_interlaced = 1'b1; // status[32'd10];

wire [4:0] game_joy1, game_joy2;
wire [1:0] game_start, game_coin;

wire [2:0] red, green;
wire [1:0] blue;

wire [3:0] game_r = { red, red[2] };
wire [3:0] game_g = { green, green[2] };
wire [3:0] game_b = { blue, blue };

wire       HS, VS;

///////////////////////////////////////////////////////////////////


jtframe_mister #(
    .CONF_STR      ( CONF_STR       ),
    .THREE_BUTTONS ( 1'b0           ))
u_frame(
    .clk_sys        ( clk_sys        ),
    .clk_rom        ( clk_sys        ),
    .clk_vga        ( clk_sys        ),
    .pll_locked     ( pll_locked     ),
    // interface with microcontroller
    .status         ( status         ),
    .HPS_BUS        ( HPS_BUS        ),
    .buttons        ( buttons        ),
    // Base video
    .game_r         ( game_r         ),
    .game_g         ( game_g         ),
    .game_b         ( game_b         ),
    .LHBL           ( LHBL_dly       ),
    .LVBL           ( LVBL_dly       ),
    .hs             ( HS             ),
    .vs             ( VS             ),
    .pxl_cen        ( pxl_cen        ),
    .pxl2_cen       ( pxl2_cen       ),
    // SDRAM interface
    .SDRAM_CLK      ( SDRAM_CLK      ),
    .SDRAM_DQ       ( SDRAM_DQ       ),
    .SDRAM_A        ( SDRAM_A        ),
    .SDRAM_DQML     ( SDRAM_DQML     ),
    .SDRAM_DQMH     ( SDRAM_DQMH     ),
    .SDRAM_nWE      ( SDRAM_nWE      ),
    .SDRAM_nCAS     ( SDRAM_nCAS     ),
    .SDRAM_nRAS     ( SDRAM_nRAS     ),
    .SDRAM_nCS      ( SDRAM_nCS      ),
    .SDRAM_BA       ( SDRAM_BA       ),
    .SDRAM_CKE      ( SDRAM_CKE      ),
    // ROM load
    .ioctl_addr     ( ioctl_addr     ),
    .ioctl_data     ( ioctl_data     ),
    .ioctl_wr       ( ioctl_wr       ),
    .prog_addr      (                ),
    .prog_data      (                ),
    .prog_mask      (                ),
    .prog_we        (                ),
    .prog_rd        ( 1'b0           ),
    .downloading    ( downloading    ),
    .dwnld_busy     ( downloading    ),
    // ROM access from game
    .loop_rst       ( loop_rst       ),
    .sdram_addr     ( sdram_addr     ),
    .sdram_req      ( sdram_req      ),
    .sdram_ack      ( sdram_ack      ),
    .data_read      ( data_read      ),
    .data_rdy       ( data_rdy       ),
    .refresh_en     ( refresh_en     ),
//////////// board
    .rst            ( rst            ),
    .rst_n          ( rst_n          ), // unused
    .game_rst       ( game_rst       ),
    .game_rst_n     (                ),
    // reset forcing signals:
    .rst_req        ( rst_req        ),
    // joystick
    .game_joystick1 ( game_joy1      ),
    .game_joystick2 ( game_joy2      ),
    .game_coin      ( game_coin      ),
    .game_start     ( game_start     ),
    .game_service   (                ), // unused
    .LED            ( LED_USER       ),
    // DIP and OSD settings
    .enable_fm      ( enable_fm      ),
    .enable_psg     ( enable_psg     ),
    .dip_test       ( dip_test       ),
    .dip_pause      ( dip_pause      ),
    .dip_flip       ( dip_flip       ),
    .dip_fxlevel    ( dip_fxlevel    ),
    // screen
    .rotate         ( ROTATE         ),
    // HDMI
    .hdmi_r         ( HDMI_R         ),
    .hdmi_g         ( HDMI_G         ),
    .hdmi_b         ( HDMI_B         ),
    .hdmi_hs        ( HDMI_HS        ),
    .hdmi_vs        ( HDMI_VS        ),
    .hdmi_clk       ( HDMI_CLK       ),
    .hdmi_cen       ( HDMI_CE        ),
    .hdmi_de        ( HDMI_DE        ),
    .hdmi_sl        ( HDMI_SL        ),
    .hdmi_arx       ( HDMI_ARX       ),
    .hdmi_ary       ( HDMI_ARY       ),
    // scan doubler output to VGA pins
    .scan2x_r       ( VGA_R          ),
    .scan2x_g       ( VGA_G          ),
    .scan2x_b       ( VGA_B          ),
    .scan2x_hs      ( VGA_HS         ),
    .scan2x_vs      ( VGA_VS         ),
    .scan2x_clk     ( VGA_CLK        ),
    .scan2x_cen     ( VGA_CE         ),
    .scan2x_de      ( VGA_DE         ),
    // Debug
    .gfx_en         ( gfx_en         )
);

wire pxl2_cen, pxl_cen;
wire game_pause = pause;
wire game_service = 1'b0;
assign rst_n = ~(RESET | status[0] | buttons[1] | downloading );

assign VGA_CE = pxl2_cen;

assign ROTATE = 2'b00;
`ifdef SIMULATION
assign sim_pxl_clk = clk_sys;
assign sim_pxl_cen = pxl_cen;
`endif

jtpopeye_game u_game(
    .rst_n          ( rst_n            ),
    .clk            ( clk_sys          ),   // 40 MHz
    .pxl_cen        ( pxl_cen          ),   // 10.08 MHz, pixel clock
    .pxl2_cen       ( pxl2_cen         ),

    .red            ( red              ),
    .green          ( green            ),
    .blue           ( blue             ),
    .HB             ( HB               ),
    .VB             ( VB               ),
    .HS             ( HS               ),
    .VS             ( VS               ),
    .SY_n           (                  ),
    .INITEO         ( INITEO           ),
    // cabinet I/O
    .start_button   ( game_start       ),
    .coin_input     ( game_coin        ),
    .joystick1      ( game_joy1        ),
    .joystick2      ( game_joy2        ),
    .service        ( game_service     ),

    // UART
    .uart_rx        ( 1'b0             ),
    .uart_tx        (                  ),

    // ROM LOAD
    .downloading    ( downloading      ),
    .ioctl_addr     ( ioctl_addr[21:0] ),
    .ioctl_data     ( ioctl_data       ),
    .ioctl_wr       ( ioctl_wr         ),
    .skyskipper     ( skyskipper       ),

    // DIP Switches
    .dip_pause      ( game_pause     ),  // not a DIP on real hardware
    .status         ( status         ),
    // Sound output
    .snd            ( AUDIO_L[15:6]  ),
    .sample         ( /* unused  */  ),
    // Debug
    .gfx_en         ( ~3'd0          )
);

assign AUDIO_L[5:0] = 6'd0;
assign AUDIO_R = AUDIO_L;
assign AUDIO_S = 0;

endmodule // jtpopeye_mist