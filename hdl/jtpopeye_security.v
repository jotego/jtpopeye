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

module jtpopeye_security(
    input              clk,
    input              cen,
    input      [7:0]   din,
    output reg [7:0]   dout,
    input              rd_n,
    input              wr_n,
    input              A0
);

reg  [2:0] shift;
reg  [7:0] data0, data1;
reg  [7:0] code;
reg  [7:0] data0_sh, data1_sh;

always @(*) begin
    data0_sh = data0 << shift;
    data1_sh = data1 >> (8-shift);
    code = data0 | data1;
end

always @(posedge clk) if( cen ) begin
    if( !wr_n ) begin
        if( !A0 )
            shift <= din[2:0];
        else begin
            data0 <= din;
            data1 <= din;
        end
    end
    if( !rd_n ) begin
        dout <= A0 ? 8'd0 : code;
    end
end


endmodule // jtpopeye_security