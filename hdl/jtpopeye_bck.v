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

module jtpopeye_bck(
    input               rst_n,
    input               clk,
    input               pxl_cen,
    input               cpu_cen,

    // CPU interface
    input               CSBW_n,
    input               DWRBK,

    input      [12:0]   AD,
    input      [ 8:0]   ROVI,
    input      [28:0]   DO,
    input      [ 7:0]   DD,
    output reg [ 4:0]   BAKC
);

reg [7:0] ROH;
reg [8:1] ROVl;

always @(posedge clk) if(pxl_cen) begin
    ROVl <= ROVI[8:1];
    ROH  <= DO[7:0];
end

// AD is obfuscated
wire [12:0] ADx;

jtpopeye_video_dec u_dec(
    .AD     ( AD       ),
    .AD_dec ( ADx      )
);

reg [11:0] ADmux;
reg [ 7:0] ram_doutl;
wire [7:0] ram_dout;
reg nibble_sel;


always @(posedge clk) if(pxl_cen) begin
    if( ROH[1:0]==2'b11 )
        BAKC <= nibble_sel ? ram_dout[3:0] : ram_dout[7:4];
end

// RAM is programmed in nibbles:
always @(posedge clk) begin
    ram_doutl <= ram_dout;
end

wire [7:0] ram_din = !AD[12] ?
    { ram_doutl[7:4], DD[3:0] } : { DD[7:4], ram_doutl[3:0] };

always @(*) begin
    ADmux = !CSBW_n ? ADx[11:0] : {ROVl[6:1],ROH[7:2]};
    nibble_sel = !CSBW_n ? !ADx[12] : ROVl[7];
end


jtgng_ram #(.aw(12), .dw(8)) u_ram1(
    .clk    ( clk            ),
    .cen    ( pxl_cen        ),
    .data   ( ram_din        ),
    .addr   ( ADmux          ),
    .we     ( DWRBK          ),
    .q      ( ram_dout       )
);


endmodule // jtpopeye_bak