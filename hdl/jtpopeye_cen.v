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
    input           clk,        // 40 MHz

    output reg      H0_cen,   // 2.5 MHz <> 400ns
    output reg      cpu_cen,  // 4 MHz <> 250ns
    output reg      ay_cen,   // 2 MHz <> 500ns
    output reg      pxl_cen,  // TXT pixel clock.  5 MHz <> 200ns
    output reg      pxl2_cen  // OBJ pixel clock. 10 MHz <> 100ns
);

reg [3:0] cnt2='d0;
reg [4:0] cnt20='d0;


always @(negedge clk) begin
    cnt2  <= cnt2 + 4'd1;
    cnt20 <= cnt20 == 5'd19 ? 5'd0 : (cnt20+5'd1);
    
    pxl2_cen <= cnt2[1:0]==2'b00;     // 10   MHz
    pxl_cen  <= cnt2[2:0]==3'b000;    //  5   MHz
    H0_cen   <= cnt2[3:0]==4'b1000;   //  2.5 MHz

    cpu_cen  <= cnt20==5'd0 || cnt20==5'd10;  //  4   MHz
    ay_cen   <= cnt20==5'd0;  //  2   MHz
end

endmodule // jtpopeye_cen