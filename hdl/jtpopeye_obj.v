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
    input               pxl_cen,
    input               pxl2_cen,

    input               ROHVS,
    input               ROHVCK,
    input               RV_n,
    input               INITEO_n,
    input               VB,

    input      [ 7:0]   H,
    input      [17:0]   DJ,
    // SDRAM interface
    output     [12:0]   obj_addr,
    input      [31:0]   objrom_data,
    // pixel data
    output reg [ 2:0]   OBJC,
    output reg [ 1:0]   OBJV
);

assign obj_addr = { DJ[17], DJ[10:1], DJ[0]^INITEO_n };

reg hflip;
reg [15:0] objd0, objd1;

reg [2:0] objc;
reg [4:0] cnt;  // device 5E, video sheet 2/3

always @(posedge clk) if( pxl_cen ) begin
    if( H[2:0]==3'd7 ) begin
        objc   <= DJ[16:14];
        cnt    <= { 1'b0, DJ[13:12] ^ {2{RV_n}}, 1'b1, ~&DJ[16:14] };
        hflip  <= DJ[11] ^ RV_n;
    end else begin
        cnt    <= { 1'b0, cnt[3:0] }+5'd1;
    end
end

// devices 4K, 4L, 4J, 5K, 4F, 4H, 4E and 5F, video sheet 2/3
always @(posedge clk) if(pxl2_cen) begin : shift_register
    if( !cnt[4] ) begin
        { objd1, objd0 } <= objrom_data;
    end else begin
        objd1 <= hflip ? { objd1[14:0], 1'b0 } : { 1'b0, objd1[15:1] }; // pink
        objd0 <= hflip ? { objd0[14:0], 1'b0 } : { 1'b0, objd0[15:1] }; // green
    end
end

always @(posedge clk) if(pxl2_cen) begin
    if(VB) begin
        OBJV <= 2'b00;
    end else if(cnt[4]) begin
        OBJC <= objc;
        OBJV <= hflip ? { objd1[15], objd0[15] } : { objd1[0], objd0[0] };
    end
end

endmodule // jtpopeye_obj