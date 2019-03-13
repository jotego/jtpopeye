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

module jtpopeye_dma(
    input              rst_n,
    input              clk,
    input              cen,
    // PROM programming
    input   [7:0]      prog_addr,
    input              prom_4a_we
    input              prom_5b_we
    input              prom_5a_we
    input              prom_3a_we
    input   [7:0]      prom_din,
    // mixing
    input              HBD_n,
    input              VB_n,
    // video data
    input   [4:0]      bakc,
    input   [5:0]      objc,
    input   [1:0]      objv,
    input   [3:0]      txtc,
    input              txtv,
    // output video
    output  reg [2:0]  red,
    output  reg [2:0]  green,
    output  reg [2:0]  blue   // LSB is always zero
);