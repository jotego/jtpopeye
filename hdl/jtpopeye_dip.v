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
    Date: 3-11-2019 */

module jtpopeye_dip(
    input             clk,
    input      [31:0] status,
    output reg [ 1:0] dip_level,
    output reg [ 1:0] dip_lives,
    output reg [ 1:0] dip_bonus,
    output            dip_upright,
    output            dip_demosnd,
    output     [ 3:0] dip_price,
    output            skyskipper
);

assign dip_upright = 1'b0;
assign dip_demosnd = 1'b0;
assign dip_price   = 4'hf;
assign dip_lives   = status[19:18];
assign dip_bonus   = status[21:20];
assign skyskipper  = status[22];


// play level. Latch all inputs to game module
always @(posedge clk) begin
    case( status[17:16] )
        2'b00: dip_level <= 2'b10; // normal
        2'b01: dip_level <= 2'b11; // easy
        2'b10: dip_level <= 2'b01; // hard
        2'b11: dip_level <= 2'b00; // very hard
    endcase
end

endmodule

