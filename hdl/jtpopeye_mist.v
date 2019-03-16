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
);

localparam CONF_STR = {
    //   00000000011111111112222222222333333333344444444445
    //   12345678901234567890123456789012345678901234567890
        "JTPOPEYE;;", //8
        "O1,Pause,OFF,ON;", // 16
        "F,rom;", // 6
        "O23,Difficulty,Normal,Easy,Hard,Very hard;", // 42
        "O4,Test mode,OFF,ON;", // 20
        "O56,Lives,1,2,3,4;",  // 18
        "O9,Screen filter,ON,OFF;", // 24
        "TF,RST ,OFF,ON;", // 15
        "V,http://patreon.com/topapate;" // 30
};


localparam CONF_STR_LEN = 8+16+6+42+20+18+24+15+30;
parameter CLK_SPEED=20;

wire          rst, clk_rgb, clk_rom;
wire          cen12, cen6, cen3, cen1p5;
wire [31:0]   status, joystick1, joystick2;
wire [21:0]   sdram_addr;
wire [31:0]   data_read;
wire          loop_rst, autorefresh, sdram_re;
wire          downloading;
wire [21:0]   ioctl_addr;
wire [ 7:0]   ioctl_data;
wire          ioctl_wr;
wire          coin_cnt;

assign LED = ~downloading; // | coin_cnt | rst;
wire rst_req = status[32'hf];
wire cheat_invincible = status[32'd10];

wire enable_fm = ~status[8], enable_psg = ~status[7];

wire game_pause;
`ifdef SIMULATION
    wire dip_pause = 1'b1; // ~status[1];
    initial if(!dip_pause) $display("INFO: DIP pause enabled");
`else
wire dip_pause = ~status[1] & ~game_pause;
`endif

wire dip_upright = 1'b1;
reg [1:0] dip_level;
wire dip_demosnd = 1'b0;
wire [1:0] dip_lives  = status[6:5];
wire [3:0] dip_price  = 4'b0;
wire [1:0] dip_bonus  = 2'b0;

wire [21:0]   prog_addr;
wire [ 7:0]   prog_data;
wire [ 1:0]   prog_mask;
wire          prog_we;

wire [2:0] red, green, blue;

wire HB, VB, hs, vs;
wire [9:0] snd;

wire [9:0] game_joystick1, game_joystick2;
wire [1:0] game_coin, game_start;
wire game_rst;
wire [3:0] gfx_en;

// play level
always @(*)
    case( status[3:2] )
        2'b00: dip_level = 2'b01; // normal
        2'b01: dip_level = 2'b00; // easy
        2'b10: dip_level = 2'b10; // hard
        2'b11: dip_level = 2'b11; // very hard
    endcase // status[3:2]

jtframe_mist #( .CONF_STR(CONF_STR), .CONF_STR_LEN(CONF_STR_LEN),
    .CLK_SPEED(20),
    .SIGNED_SND(1'b0), .THREE_BUTTONS(1'b0))
u_frame(
    .CLOCK_27       ( CLOCK_27       ),
    .clk_rgb        ( clk_rgb        ),
    .clk_rom        ( clk_rom        ),
    .cen12          ( cen12          ),
    .pxl_cen        ( pxl_cen        ),
    .status         ( status         ),
    // Base video
    .osd_rotate     ( 2'b00          ),
    // convert from 3-bit colour to 4-bit colour
    .game_r         ( { red, red[2] }     ),
    .game_g         ( { green, green[2] } ),
    .game_b         ( { blue, blue[2] }   ),
    .LHBL           ( ~HB            ),
    .LVBL           ( ~VB            ),
    .hs             ( hs             ),
    .vs             ( vs             ),
    // VGA
    .en_mixing      ( ~status[9]     ),
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
    .downloading    ( downloading    ),
    // ROM access from game
    .loop_rst       ( loop_rst       ),
    .autorefresh    ( autorefresh    ),
    .sdram_addr     ( sdram_addr     ),
    .sdram_re       ( sdram_re       ),
    .data_read      ( data_read      ),
//////////// board
    .rst            ( rst            ),
    .game_rst       ( game_rst       ),
    // reset forcing signals:
    .dip_flip       ( /* unused */   ),
    .rst_req        ( rst_req        ),
    // Sound
    .snd            ( { snd, 6'd0 }  ),
    .AUDIO_L        ( AUDIO_L        ),
    .AUDIO_R        ( AUDIO_R        ),
    // joystick
    .game_joystick1 ( game_joystick1 ),
    .game_joystick2 ( game_joystick2 ),
    .game_coin      ( game_coin      ),
    .game_start     ( game_start     ),
    .game_pause     ( game_pause     ),
    // Debug
    .gfx_en         ( gfx_en         )
);

jtpopeye_game u_game(
    .rst_n          ( rst_n                 ),
    .clk            ( clk_rgb               ),   // 20 MHz
    .clk_rom        ( clk_rom               ),   // SDRAM clock
    .pxl2_cen       ( pxl2_cen              ),   // 10.08 MHz, pixel clock

    .red            ( red                   ),
    .green          ( green                 ),
    .blue           ( blue                  ),
    .HB             ( HB                    ),
    .VB             ( VB                    ),
    .HS             ( HS                    ),
    .VS             ( VS                    ),
    // cabinet I/O
    .start_button   ( game_start            ),
    .coin_input     ( |game_coin            ),
    .joystick1      ( game_joystick1[4:0]   ),
    .joystick2      ( game_joystick2[4:0]   ),

    // SDRAM interface
    .downloading    ( downloading           ),
    .loop_rst       ( loop_rst              ),
    .sdram_re       ( sdram_re              ),
    .sdram_addr     ( sdram_addr            ),
    .data_read      ( data_read             ),

    // ROM LOAD
    .ioctl_addr     ( ioctl_addr            ),
    .ioctl_data     ( ioctl_data            ),
    .ioctl_wr       ( ioctl_wr              ),
    .prog_addr      ( prog_addr             ),
    .prog_data      ( prog_data             ),
    .prog_mask      ( prog_mask             ),
    .prog_we        ( prog_we               ),

    // DIP Switches
    .dip_pause      ( game_pause            ),  // not a DIP on real hardware
    .dip_upright    ( dip_upright           ),
    .dip_level      ( dip_level             ),  // difficulty level
    .dip_bonus      ( dip_bonus             ), 
    .dip_demosnd    ( dip_demosnd           ),
    .dip_price      ( dip_price             ),
    .dip_lives      ( dip_lives             ),
    // Sound output
    .snd            ( snd[9:0]              ),
    .sample         ( /* unused  */         ),
    // Debug
    .gfx_en         ( gfx_en                )
);

endmodule // jtpopeye_mist