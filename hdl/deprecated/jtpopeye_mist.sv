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

module jtpopeye_mist(
    input   [1:0]   CLOCK_27,
    output  [5:0]   VGA_R,
    output  [5:0]   VGA_G,
    output  [5:0]   VGA_B,
    output          VGA_HS,
    output          VGA_VS,
    // SDRAM interface
    inout  [15:0]   SDRAM_DQ,       // SDRAM Data bus 16 Bits
    output [12:0]   SDRAM_A,        // SDRAM Address bus 13 Bits
    output          SDRAM_DQML,     // SDRAM Low-byte Data Mask
    output          SDRAM_DQMH,     // SDRAM High-byte Data Mask
    output          SDRAM_nWE,      // SDRAM Write Enable
    output          SDRAM_nCAS,     // SDRAM Column Address Strobe
    output          SDRAM_nRAS,     // SDRAM Row Address Strobe
    output          SDRAM_nCS,      // SDRAM Chip Select
    output [1:0]    SDRAM_BA,       // SDRAM Bank Address
    output          SDRAM_CLK,      // SDRAM Clock
    output          SDRAM_CKE,      // SDRAM Clock Enable
    // UART
    input           UART_RX,
    output          UART_TX,
    // SPI interface to arm io controller
    output          SPI_DO,
    input           SPI_DI,
    input           SPI_SCK,
    input           SPI_SS2,
    input           SPI_SS3,
    input           SPI_SS4,
    input           CONF_DATA0,
    // sound
    output          AUDIO_L,
    output          AUDIO_R,
    // user LED
    output          LED
    `ifdef SIMULATION
    ,output         sim_pxl_cen,
    output          sim_pxl_clk,
    output          sim_vs,
    output          sim_hs
    `endif
);

localparam CONF_STR = {
        "JTPOPEYE;;",
        "O1,Credits,OFF,ON;",
        "F,rom;",
        "OGH,Difficulty,Normal,Easy,Hard,Very hard;",
        "OIJ,Lives,4,3,2,1;",  // 18    
        "OKL,Bonus,40k,60k,80k,No Bonus;",
        "OM,Sky Skipper,No,Yes;",
        "TF,RST ,OFF,ON;",
        "V,http://patreon.com/topapate;"
};


localparam CONF_STR_LEN = $size(CONF_STR)/8;

wire          rst, clk_sys;
wire [31:0]   status, joystick1, joystick2;
wire          downloading;
wire [21:0]   ioctl_addr;
wire [ 7:0]   ioctl_data;
wire          ioctl_wr;
wire          coin_cnt;

wire rst_req = status[32'hf];

wire game_pause, game_service;
`ifdef SIMULATION
    wire dip_pause = 1'b1; // ~status[1];
    initial if(!dip_pause) $display("INFO: DIP pause enabled");
`else
reg dip_pause;
always @(posedge clk_sys) dip_pause <= status[1] | game_pause;
`endif

wire dip_upright = 1'b0;
reg [1:0] dip_level;
wire dip_demosnd = 1'b0;
wire [1:0] dip_lives = status[6:5];
wire [3:0] dip_price = 4'hf;
wire [1:0] dip_bonus = status[8:7];

wire [21:0]   prog_addr;
wire [ 7:0]   prog_data;
wire [ 1:0]   prog_mask;
wire          prog_we;

wire [2:0] red, green;
wire [1:0] blue;

wire HB, VB, HS, VS, SY_n;
wire [9:0] snd;

wire [9:0] game_joystick1, game_joystick2;
wire [1:0] game_coin, game_start;
wire game_rst_n, rst_n;
wire [3:0] gfx_en;
reg en_mixing, coin_input;

// ROM access from game
wire        loop_rst;
wire [21:0] sdram_addr;
wire        sdram_req;
wire        sdram_ack;
wire [31:0] data_read;
wire        data_rdy;
wire        refresh_en;
wire        pll_locked;
wire        pxl_cen, pxl2_cen, pxl4_cen;

wire [3:0]
    r4 = { red, red[2] },
    g4 = { green, green[2] },
    b4 = { blue, blue };

pll_game_mist u_pll_game(
    .inclk0 ( CLOCK_27[0] ),
    .c1     ( clk_sys     ), // 40 MHz
    .c2     ( SDRAM_CLK   ),
    .locked ( pll_locked  )
);

`ifdef SIMULATION
assign sim_pxl_cen = pxl4_cen;
assign sim_pxl_clk = clk_sys;
assign sim_vs = VS;
assign sim_hs = HS;
`endif

jtframe_mist #(
    .CONF_STR              ( CONF_STR ),
    .SIGNED_SND            ( 1'b0     ),
    .THREE_BUTTONS         ( 1'b0     ),
    .GAME_INPUTS_ACTIVE_LOW( 1'b0     ))
u_frame(
    .clk_sys        ( clk_sys        ),
    .clk_rom        ( clk_sys        ),
    .clk_vga        ( clk_sys        ),
    .status         ( status         ),
    .pll_locked     ( pll_locked     ),
    // convert from 3-bit colour to 4-bit colour
    .game_r         ( r4             ),
    .game_g         ( g4             ),
    .game_b         ( b4             ),
    .LHBL           ( ~HB            ),
    .LVBL           ( ~VB            ),
    .hs             ( HS             ),
    .vs             ( VS             ),
    .pxl_cen        ( pxl_cen        ),
    .pxl2_cen       ( pxl2_cen       ),
    // MiST VGA pins
    .VGA_R          ( VGA_R          ),
    .VGA_G          ( VGA_G          ),
    .VGA_B          ( VGA_B          ),
    .VGA_HS         ( VGA_HS         ),
    .VGA_VS         ( VGA_VS         ),
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
    // SPI interface to arm io controller
    .SPI_DO         ( SPI_DO         ),
    .SPI_DI         ( SPI_DI         ),
    .SPI_SCK        ( SPI_SCK        ),
    .SPI_SS2        ( SPI_SS2        ),
    .SPI_SS3        ( SPI_SS3        ),
    .SPI_SS4        ( SPI_SS4        ),
    .CONF_DATA0     ( CONF_DATA0     ),
    // ROM
    .ioctl_addr     ( ioctl_addr     ),
    .ioctl_data     ( ioctl_data     ),
    .ioctl_wr       ( ioctl_wr       ),
    .prog_addr      ( prog_addr      ),
    .prog_data      ( prog_data      ),
    .prog_mask      ( prog_mask      ),
    .prog_we        ( prog_we        ),
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
    .rst_n          ( rst_n          ),
    .game_rst_n     ( game_rst_n     ),
    // reset forcing signals:
    .dip_flip       ( /* unused */   ),
    .rst_req        ( rst_req        ),
    // Sound
    .snd_left       ( { snd, 6'd0 }  ),
    .snd_right      ( { snd, 6'd0 }  ),
    .AUDIO_L        ( AUDIO_L        ),
    .AUDIO_R        ( AUDIO_R        ),
    // joystick
    .game_joystick1 ( game_joystick1 ),
    .game_joystick2 ( game_joystick2 ),
    .game_coin      ( game_coin      ),
    .game_start     ( game_start     ),
    .game_pause     ( game_pause     ),
    .game_service   ( game_service   ),
    // Debug
    .LED            ( LED            ),
    .gfx_en         ( gfx_en         )
);

jtpopeye_game u_game(
    .rst_n          ( game_rst_n            ),
    .clk            ( clk_sys               ),   // 40 MHz
    .pxl_cen        ( pxl_cen               ),   //  5.04 MHz, pixel clock
    .pxl2_cen       ( pxl2_cen              ),   // 10.08 MHz, pixel clock
    .pxl4_cen       ( pxl4_cen              ),   // 20.16 MHz, pixel clock

    .red            ( red                   ),
    .green          ( green                 ),
    .blue           ( blue                  ),
    .HB             ( HB                    ),
    .VB             ( VB                    ),
    .HS             ( HS                    ),
    .VS             ( VS                    ),
    .SY_n           ( SY_n                  ),
    // cabinet I/O
    .start_button   ( game_start            ),
    .coin_input     ( game_coin             ),
    .joystick1      ( game_joystick1[4:0]   ),
    .joystick2      ( game_joystick2[4:0]   ),
    .service        ( game_service          ),

    // ROM access from game
    .loop_rst       ( loop_rst       ),
    .sdram_addr     ( sdram_addr     ),
    .sdram_req      ( sdram_req      ),
    .sdram_ack      ( sdram_ack      ),
    .data_read      ( data_read      ),
    .data_rdy       ( data_rdy       ),
    .refresh_en     ( refresh_en     ),

    // UART
    .uart_rx        ( UART_RX        ),
    .uart_tx        ( UART_TX        ),

    // ROM LOAD
    .downloading    ( downloading    ),
    .ioctl_addr     ( ioctl_addr     ),
    .ioctl_data     ( ioctl_data     ),
    .ioctl_wr       ( ioctl_wr       ),
    .prog_addr      ( prog_addr      ),
    .prog_data      ( prog_data      ),
    .prog_mask      ( prog_mask      ),
    .prog_we        ( prog_we        ),

    // DIP Switches
    .dip_pause      ( dip_pause      ),  // not a DIP on real hardware
    .status         ( status         ),

    // Sound output
    .snd            ( snd[9:0]       ),
    .sample         ( /* unused  */  ),
    // Debug
    .gfx_en         ( gfx_en[2:0]    )
);

endmodule // jtpopeye_mist