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

jtpopeye_main u_main(
);

jtpopeye_video u_video(
);

endmodule // jtpopeye_game