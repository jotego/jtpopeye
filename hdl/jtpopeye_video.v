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

module jtpopeye_video(
    input               rst_n,
    input               clk,
    input               cen,
    input               cpu_cen,
    // PROM
    input   [10:0]      prog_addr,
    input               prom_5n_we,
    input   [7:0]       prom_din,    
);

wire [3:0] TXTC;
wire       TXTV;
wire [2:0] OBJC;
wire [1:0] OBJV;

jtpopeye_txt u_txt(
    .rst_n              ( rst_n         ),
    .clk                ( clk           ),
    .cen                ( cen           ),
    .cpu_cen            ( cpu_cen       ),

    input      [12:0]   AD,
    input      [ 7:0]   DD,
    input      [ 7:0]   H,
    input      [ 7:0]   V,
    input               RV, // flip
    input               CSV,
    input               MEMWR0,

    // PROM
    .prog_addr          ( prog_addr     ),
    .prom_5n_we         ( prom_5n_we    ),
    .prom_din           ( prom_din      ),

    .TXTC               ( TXTC          ),
    .TXTV               ( TXTV          )
);

jtpopeye_obj u_obj(
    .rst_n              ( rst_n         ),
    .clk                ( clk           ),
    .cen                ( cen           ),

    input               ROHVS,
    input               ROHVCK,
    input               RV_n,
    input               INITEO_n,

    input      [ 7:0]   H,
    input      [17:0]   DJ,
    // SDRAM interface
    output     [12:0]   obj_addr,
    input      [31:0]   objrom_data,
    // pixel data
    .OBJC               ( OBJC          ),
    .OBJV               ( OBJV          )
);

jtpopeye_colmix u_colmix(
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

endmodule // jtpopeye_video