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

module jtpopeye_cen(
    input           clk,        // 20 MHz

    output reg      H0_cen,
    output reg      cpu_cen,
    output reg      ay_cen,
    output reg      pxl_cen,  // TXT pixel clock
    output reg      pxl2_cen  // OBJ pixel clock
);

reg [2:0] cnt2=2'd0;
reg [3:0] cnt10=4'd0;

always @(negedge clk) begin
    cnt2  <=  cnt2 + 3'd1;
    cnt10 <= cnt10 == 4'd9 ? 4'd0 : (cnt10+4'd1);
    pxl2_cen <= cnt2[0];     // 10   MHz
    pxl_cen  <= cnt2[1];     //  5   MHz
    H0_cen   <= cnt2[2];     //  2.5 MHz
    cpu_cen  <= cnt10==4'd0 || cnt10==4'd5;  //  4   MHz
    ay_cen   <= cnt10==4'd0; //  2   MHz
end

endmodule // jtpopeye_cen