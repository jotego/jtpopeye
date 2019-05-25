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
    output        VGA_F1,    // Interlaced field

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
);

`include "build_id.v" 
localparam CONF_STR = {
    //   00000000011111111112222222222333333333344444444445
    //   12345678901234567890123456789012345678901234567890
        "A.JTPOPEYE;;", // 12
        "-;",
        "R0,Reset;",
        "J,Fire,Bomb,Start 1P,Start 2P,Coin,Pause;",
        "V,v",`BUILD_DATE, " http://patreon.com/topapate;"
};

assign VGA_F1 = 0;

////////////////////   CLOCKS   ///////////////////

wire clk_sys;
wire pll_locked;

pll pll(
    .refclk     ( CLK_50M    ),
    .rst        ( 1'b0       ),
    .locked     ( pll_locked ),
    .outclk_0   ( clk_sys    ),
    .outclk_1   ( SDRAM_CLK  )
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

assign LED_USER  = { 1'b0, downloading };
assign LED_DISK  = 2'b0;
assign LED_POWER = 2'b0;

assign HDMI_ARX = status[1] ? 8'd16 : status[2] ? 8'd4 : 8'd3;
assign HDMI_ARY = status[1] ? 8'd9  : status[2] ? 8'd3 : 8'd4;

hps_io #(.STRLEN($size(CONF_STR)>>3)) hps_io
(
    .clk_sys    ( clk_sys       ),
    .HPS_BUS    ( HPS_BUS       ),

    .conf_str   ( CONF_STR      ),

    .buttons    ( buttons       ),
    .status     ( status        ),
    .forced_scandoubler(forced_scandoubler),

    .ioctl_download(downloading),
    .ioctl_wr   ( ioctl_wr      ),
    .ioctl_addr ( ioctl_addr    ),
    .ioctl_dout ( ioctl_data    ),

    .joystick_0 ( joy_0         ),
    .joystick_1 ( joy_1         ),
    .ps2_key    ( ps2_key       )
);

wire       pressed = ps2_key[9];
wire [7:0] code    = ps2_key[7:0];

reg btn_one_player = 0;
reg btn_two_players = 0;
reg btn_left = 0;
reg btn_right = 0;
reg btn_down = 0;
reg btn_up = 0;
reg btn_fire1 = 0;
reg btn_fire2 = 0;
reg btn_coin  = 0;
reg btn_pause = 0;

always @(posedge clk_sys) begin
    reg old_state;
    old_state <= ps2_key[10];
    
    if(old_state != ps2_key[10]) begin
        case(code)
            'h75: btn_up            <= pressed; // up
            'h72: btn_down          <= pressed; // down
            'h6B: btn_left              <= pressed; // left
            'h74: btn_right         <= pressed; // right
            'h05: btn_one_player    <= pressed; // F1
            'h06: btn_two_players   <= pressed; // F2
            'h04: btn_coin              <= pressed; // F3
            'h0C: btn_pause     <= pressed; // F4
            'h14: btn_fire1             <= pressed; // ctrl
            'h11: btn_fire1             <= pressed; // alt
            'h29: btn_fire2         <= pressed; // Space
        endcase
    end
end

wire [9:0] joy = joy_0 | joy_1;

wire m_up     = btn_up    | joy[3];
wire m_down   = btn_down  | joy[2];
wire m_left   = btn_left  | joy[1];
wire m_right  = btn_right | joy[0];
wire m_fire   = btn_fire1 | joy[4];
wire m_jump   = btn_fire2 | joy[5];
wire m_pause  = btn_pause | joy[9];

wire m_start1 = btn_one_player  | joy[6];
wire m_start2 = btn_two_players | joy[7];
wire m_coin   = btn_coin        | joy[8];

reg pause = 0;
always @(posedge clk_sys) begin
    reg old_pause;
    
    old_pause <= m_pause;
    if(~old_pause & m_pause) pause <= ~pause;
    if(status[0] | buttons[1]) pause <= 0;
end

///////////////////////////////////////////////////////////////////


wire [2:0] red, green, blue;
wire HSync,VSync,HBlank,VBlank;
wire HS, VS, HB, VB;

assign VGA_CLK  = clk_sys;
assign HDMI_CLK = VGA_CLK;
assign HDMI_CE  = VGA_CE;
assign HDMI_R   = VGA_R;
assign HDMI_G   = VGA_G;
assign HDMI_B   = VGA_B;
assign HDMI_DE  = VGA_DE;
assign HDMI_HS  = HS;
assign HDMI_VS  = VS;
assign HDMI_SL  = sl[1:0];

// base video
assign VGA_R    = { red,   red,   red[2:1] };
assign VGA_G    = { green, green, green[2:1] };
assign VGA_B    = { blue,  blue,  blue[2:1] };
assign VGA_HS   = SY_n;
assign VGA_VS   = 1;

wire [2:0] scale = status[5:3];
wire [2:0] sl = scale ? scale - 1'd1 : 3'd0;
wire       scandoubler = (scale || forced_scandoubler); 

wire [1:0]    dip_level = ~status[13:12];
wire [1:0]    dip_lives = ~status[9:8];
wire [1:0]    dip_bonus = ~status[11:10];
wire          dip_test  = ~status[15];

jtpopeye_game u_game(
    .rst_n          ( rst_n                 ),
    .clk            ( clk_sys               ),   // 40 MHz
    .pxl2_cen       ( pxl2_cen              ),   // 10.08 MHz, pixel clock

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
    .coin_input     ( coin_input            ),
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
    .dip_pause      ( game_pause     ),  // not a DIP on real hardware
    .dip_upright    ( dip_upright    ),
    .dip_level      ( dip_level      ),  // difficulty level
    .dip_bonus      ( dip_bonus      ),
    .dip_demosnd    ( dip_demosnd    ),
    .dip_price      ( dip_price      ),
    .dip_lives      ( dip_lives      ),
    // Sound output
    .snd            ( snd[9:0]       ),
    .sample         ( /* unused  */  ),
    // Debug
    .gfx_en         ( gfx_en         )
);

endmodule // jtpopeye_mist