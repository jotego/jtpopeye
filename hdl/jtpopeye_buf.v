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

module jtpopeye_buf(
    input               rst_n,
    input               clk,
    input               cen,

    input               ROHVS,
    input               ROHVCK,
    input               RV_n,

    input      [ 7:0]   V,
    input      [28:0]   gfx_data, // DO

    output reg [17:0]   DJ
);

reg [8:0] ROVI;
reg ROVI_hc; // half carry
reg [3:0] nc;

always @(*) begin
    ROVI = { 1'b0, gfx_data[15:8] } + { 1'b0, V[7:0] } 
        + { 8'd0, ~RV_n ^ ROHVCK }; // carry in
    { ROVI_hc, nc } = { 1'b0, ROVI[7:4] } + { 4'b0, ROVI[3] };
end

wire [2:0] adder_data = {3{gfx_data[27]}} ^ ROVI[2:0];

wire [17:0] ram_din = { gfx_data[28], gfx_data[26:24]&{3{~V[0]}}, 
        gfx_data[1:0], gfx_data[23:21], gfx_data[20:16], 
        adder_data, gfx_data[27] };

reg [5:0] ADR0, ADR1;
reg [17:0] DJ0, DJ1;

jtgng_ram #(.aw(6), .dw(18)) u_ram0(
    .clk    ( clk            ),
    .cen    ( cen            ),
    .data   ( ram_din        ),
    .addr   ( ADR0           ),
    .we     ( we0            ),
    .q      ( DJ0            )
);

jtgng_ram #(.aw(6), .dw(18)) u_ram1(
    .clk    ( clk            ),
    .cen    ( cen            ),
    .data   ( ram_din        ),
    .addr   ( ADR1           ),
    .we     ( we1            ),
    .q      ( DJ1            )
);

always @(posedge clk)
    if( latch_condition ) DJ <= line_sel ? DJ1 : DJ0;

endmodule // jtpopeye_dma