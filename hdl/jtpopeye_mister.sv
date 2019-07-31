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
    "A.POP;;",
    "-;",
    "F,rom;",
    "O23,Difficulty,Normal,Easy,Hard,Very hard;",
    "O56,Lives,4,3,2,1;",  // 18    
    "O78,Bonus,40k,60k,80k,No Bonus;",
    "-;",
    "R0,Reset;",
    "J,Punch,Start 1P,Start 2P,Coin,Pause;",
    "V,v",`BUILD_DATE, " http://patreon.com/topapate;"
};

assign VGA_F1 = 0;

/// SDRAM is not used:
assign SDRAM_DQ = 16'hzzzz;
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

assign LED_USER  = downloading;
assign LED_DISK  = 2'b0;
assign LED_POWER = 2'b0;

assign HDMI_ARX = status[1] ? 8'd16 : status[2] ? 8'd4 : 8'd3;
assign HDMI_ARY = status[1] ? 8'd9  : status[2] ? 8'd3 : 8'd4;

hps_io #(.STRLEN($size(CONF_STR)>>3)) hps_io
(
    .clk_sys       ( clk_sys       ),
    .HPS_BUS       ( HPS_BUS       ),

    .conf_str      ( CONF_STR      ),

    .buttons       ( buttons       ),
    .status        ( status        ),
    .forced_scandoubler(forced_scandoubler),

    .ioctl_download(downloading    ),
    .ioctl_wr      ( ioctl_wr      ),
    .ioctl_addr    ( ioctl_addr    ),
    .ioctl_dout    ( ioctl_data    ),

    .joystick_0    ( joy_0         ),
    .joystick_1    ( joy_1         ),
    .ps2_key       ( ps2_key       )
);

wire       pressed = ps2_key[9];
wire [7:0] code    = ps2_key[7:0];

reg btn_one_player  = 0;
reg btn_two_players = 0;
reg btn_left        = 0;
reg btn_right       = 0;
reg btn_down        = 0;
reg btn_up          = 0;
reg btn_fire1       = 0;
reg btn_coin        = 0;
reg btn_pause       = 0;

always @(posedge clk_sys) begin
    reg old_state;
    old_state <= ps2_key[10];
    
    if(old_state != ps2_key[10]) begin
        case(code)
            'h75: btn_up          <= pressed; // up
            'h72: btn_down        <= pressed; // down
            'h6B: btn_left        <= pressed; // left
            'h74: btn_right       <= pressed; // right
            'h05: btn_one_player  <= pressed; // F1
            'h06: btn_two_players <= pressed; // F2
            'h04: btn_coin        <= pressed; // F3
            'h0C: btn_pause       <= pressed; // F4
            'h14: btn_fire1       <= pressed; // ctrl
        endcase
    end
end

reg m_up, m_down, m_left, m_right, m_punch, m_jump, m_pause;
reg m_start1, m_start2, m_coin;
reg m2_up, m2_down, m2_left, m2_right, m2_punch, m2_jump;

always @(posedge clk_sys) begin
    m_up     <= ~(btn_up    | joy_0[3]);
    m_down   <= ~(btn_down  | joy_0[2]);
    m_left   <= ~(btn_left  | joy_0[1]);
    m_right  <= ~(btn_right | joy_0[0]);
    m_punch  <= ~(btn_fire1 | joy_0[4]);
    m_pause  <= ~(btn_pause | joy_0[9]);
    m_start1 <= ~(btn_one_player  | joy_0[6]);
    m_start2 <= ~(btn_two_players | joy_0[7]);
    m_coin   <= ~(btn_coin        | joy_0[8]);
    m2_up    <= ~joy_1[3];
    m2_down  <= ~joy_1[2];
    m2_left  <= ~joy_1[1];
    m2_right <= ~joy_1[0];
    m2_punch <= ~joy_1[4];
end
reg pause = 0;
always @(posedge clk_sys) begin
    reg old_pause;
    
    old_pause <= m_pause;
    if(~old_pause & m_pause) pause <= ~pause;
    if(status[0] | buttons[1]) pause <= 0;
end

wire dip_upright = 1'b0;
wire dip_demosnd = 1'b0;
wire [3:0] dip_price  = 4'b0;

///////////////////////////////////////////////////////////////////


wire [2:0] red, green;
wire [1:0] blue;
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
assign HDMI_SL  = 2'b0;

// base video
assign VGA_R    = { red,   red,   red[2:1] };
assign VGA_G    = { green, green, green[2:1] };
assign VGA_B    = { 4{blue} };
assign VGA_HS   = HS;
assign VGA_VS   = VS;

reg  [1:0]    dip_level;
wire [1:0]    dip_lives = status[6:5];
wire [1:0]    dip_bonus = status[8:7];
wire          dip_test  = 0; // ~status[15];

// play level. Latch all inputs to game module
always @(posedge clk_sys) begin
    case( status[3:2] )
        2'b00: dip_level <= 2'b10; // normal
        2'b01: dip_level <= 2'b11; // easy
        2'b10: dip_level <= 2'b01; // hard
        2'b11: dip_level <= 2'b00; // very hard
    endcase // status[3:2]
end

wire [4:0] game_joystick1 = { m_punch,  m_up,  m_down,  m_left,  m_right  };
wire [4:0] game_joystick2 = { m2_punch, m2_up, m2_down, m2_left, m2_right };
wire [1:0] game_start     = { m_start2, m_start1 };

wire pxl2_cen, pxl_cen;
wire game_pause = m_pause;
wire game_service = 1'b0;
wire rst_n = ~(RESET | status[0] | buttons[1]);

assign VGA_CE = pxl_cen;

assign ROTATE = 2'b00;
`ifdef SIMULATION
assign sim_pxl_clk = clk_sys;
assign sim_pxl_cen = pxl_cen;
`endif

jtpopeye_game u_game(
    .rst_n          ( rst_n                 ),
    .clk            ( clk_sys               ),   // 40 MHz
    .pxl2_cen       ( pxl2_cen              ),   // 10.08 MHz, pixel clock
    .pxl_cen        ( pxl_cen               ),   // 10.08 MHz, pixel clock

    .red            ( red                   ),
    .green          ( green                 ),
    .blue           ( blue                  ),
    .HB             ( HB                    ),
    .VB             ( VB                    ),
    .HS             ( HS                    ),
    .VS             ( VS                    ),
    .SY_n           (                       ),
    // cabinet I/O
    .start_button   ( game_start            ),
    .coin_input     ( m_coin                ),
    .joystick1      ( game_joystick1        ),
    .joystick2      ( game_joystick2        ),
    .service        ( game_service          ),

    // UART
    .uart_rx        ( 1'b0             ),
    .uart_tx        (                  ),

    // ROM LOAD
    .downloading    ( downloading      ),
    .ioctl_addr     ( ioctl_addr[21:0] ),
    .ioctl_data     ( ioctl_data       ),
    .ioctl_wr       ( ioctl_wr         ),

    // DIP Switches
    .dip_pause      ( game_pause     ),  // not a DIP on real hardware
    .dip_upright    ( dip_upright    ),
    .dip_level      ( dip_level      ),  // difficulty level
    .dip_bonus      ( dip_bonus      ),
    .dip_demosnd    ( dip_demosnd    ),
    .dip_price      ( dip_price      ),
    .dip_lives      ( dip_lives      ),
    // Sound output
    .snd            ( AUDIO_L[15:6]  ),
    .sample         ( /* unused  */  ),
    // Debug
    .gfx_en         ( ~4'd0          )
);

assign AUDIO_L[5:0] = 6'd0;
assign AUDIO_R = AUDIO_L;
assign AUDIO_S = 0;

endmodule // jtpopeye_mist