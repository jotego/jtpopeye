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

module jtpopeye_obj(
    input               rst_n,
    input               clk,
    input               cen,

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
    output     [ 2:0]   OBJC,
    output     [ 1:0]   OBJV
);

assign obj_addr = { DJ[17], DJ[10:1], DJ[0]^INITEO_n };

reg hflip;
reg [31:0] objd;
reg [1:0] offset;

always @(posedge clk) if( cen ) begin
    if( &H[2:0]==3'd7 ) begin
        objc   <= DJ[16:14];
        objd   <= objrom_data;
        offset <= DJ[13:12];
    end
end


endmodule // jtpopeye_obj