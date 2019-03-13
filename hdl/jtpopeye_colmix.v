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

module jtpopeye_colmix(
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

wire [2:0] bakr, objr, txtr;
wire [2:0] bakg, objg, txtg;
wire [1:0] bakb, objb, txtb;

wire [7:0] bak_rgb, obj_rgb, txt_rgb;

assign { bakr, bakg, bakb } = bak_rgb;
assign { objr, objg, objb } = obj_rgb;
assign { txtr, txtg, txtb } = txt_rgb;

reg txt_cs, obj_cs, bak_cs;

// latch priorities to process on the next clock edge
always @(posedge clk) if(cen) begin
    txt_cs <= !txtv; // txtv low -> text selected
    obj_cs <= |objv & txtv;
    bak_cs <= ~|objv & txtv & VB_n & HBD_n;
end

// merge the colours!
always @(posedge clk) if(cen) begin
    blue[0] <= 1'b0;
    case( {txt_cs, obj_cs, bak_cs} )
        3'b100: {red, green, blue[2:1]} <= txt_rgb;
        3'b010: {red, green, blue[2:1]} <= obj_rgb;
        3'b001: {red, green, blue[2:1]} <= bak_rgb;
        default: {red, green, blue[2:1]} <= 8'd0;
    endcase
end

// Background
jtgng_prom #(.aw(5),.dw(8),.simfile("../../../rom/tpp2-c.3a")) u_prom_4a(
    .clk    ( clk               ),
    .cen    ( cen               ),
    .data   ( prom_din          ),
    .rd_addr( bakc              ),
    .wr_addr( prog_addr[4:0]    ),
    .we     ( prom_4a_we        ),
    .q      ( bak_rgb           )
);

// OBJ

wire [7:0] obj_addr = { objc, objv };

jtgng_prom #(.aw(8),.dw(4),.simfile("../../../rom/tpp2-c.5b")) u_prom_5b(
    .clk    ( clk               ),
    .cen    ( cen               ),
    .data   ( prom_din[3:0]     ),
    .rd_addr( objc              ),
    .wr_addr( prog_addr[4:0]    ),
    .we     ( prom_5b_we        ),
    .q      ( obj_rgb[3:0]      )
);

jtgng_prom #(.aw(5),.dw(4),.simfile("../../../rom/tpp2-c.5a")) u_prom_5a(
    .clk    ( clk               ),
    .cen    ( cen               ),
    .data   ( prom_din[7:4]     ),
    .rd_addr( objc              ),
    .wr_addr( prog_addr[4:0]    ),
    .we     ( prom_5a_we        ),
    .q      ( obj_rgb[7:4]      )
);

// TXT

jtgng_prom #(.aw(5),.dw(8),.simfile("../../../rom/tpp2-c.5b")) u_prom_3a(
    .clk    ( clk               ),
    .cen    ( cen               ),
    .data   ( prom_din          ),
    .rd_addr( txtc              ),
    .wr_addr( prog_addr[4:0]    ),
    .we     ( prom_3a_we        ),
    .q      ( txt_rgb           )
);


endmodule // jtpopeye_colmix