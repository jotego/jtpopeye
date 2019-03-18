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

// TPP2-VIDEO SCHEMATIC 1/3

module jtpopeye_buf(    
    input               rst_n,
    input               clk,
    input               H0_cen,

    input               ROHVS,
    input               ROHVCK,
    input               RV_n,

    input      [ 7:0]   H,
    input      [ 7:0]   V,
    input               HB,
    input               H2O,
    input      [28:0]   DO,

    output reg [ 8:0]   ROVI,
    output reg [17:0]   DJ
);

reg ROVI_hc; // half carry
reg [3:0] nc;

always @(*) begin
    ROVI = { 1'b0, DO[15:8] } + { 1'b0, V[7:0] } 
        + { 8'd0, ~RV_n ^ ROHVCK }; // carry in
    { ROVI_hc, nc } = { 1'b0, ROVI[7:4] } + { 4'b0, ROVI[3] }; // 3T LS283
end

wire [2:0] adder_data = {3{DO[27]}} ^ ROVI[2:0];

wire [17:0] ram_din = { DO[28], DO[26:24]&{3{~V[0]}}, 
        DO[1:0], DO[23:21], DO[20:16], 
        adder_data, DO[27] };

wire [5:0] scan_addr = { H[7:3], H2O };
wire [5:0] wr_addr   = DO[7:2];

reg [5:0] ADR0, ADR1;
wire [17:0] DJ0, DJ1;
wire line_sel = V[0];
// wire DJ_sel;
reg we0, we1;
reg [1:0] we_v0;

always @(*) begin
    ADR0 = !line_sel ? scan_addr : wr_addr;
    ADR1 =  line_sel ? scan_addr : wr_addr;
    // DJ_sel = line_sel ? ~(ROVI_hc | (ROHVS | ~H[0])) : 1'b1;
    we_v0[0] = ~H[0];   // active-low logic on schematics
    we_v0[1] = H[0] & H[1] & ~HB; // active-low logic on schematics
    we0      = we_v0[ V[0]];
    we1      = we_v0[~V[0]];
end

jtgng_ram #(.aw(6), .dw(18)) u_ram0(
    .clk    ( clk            ),
    .cen    ( H0_cen         ),
    .data   ( ram_din        ),
    .addr   ( ADR0           ),
    .we     ( we0            ),
    .q      ( DJ0            )
);

jtgng_ram #(.aw(6), .dw(18)) u_ram1(
    .clk    ( clk            ),
    .cen    ( H0_cen         ),
    .data   ( ram_din        ),
    .addr   ( ADR1           ),
    .we     ( we1            ),
    .q      ( DJ1            )
);

always @(posedge clk)
    if( H[1:0]==2'b11 ) DJ <= line_sel ? DJ1 : DJ0;

endmodule // jtpopeye_dma