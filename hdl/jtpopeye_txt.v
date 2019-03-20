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

module jtpopeye_txt(
    input               rst_n,
    input               clk,
    input               pxl_cen,
    input               cpu_cen,

    input      [12:0]   AD,
    input      [ 7:0]   DD,
    input      [ 7:0]   H,
    input      [ 7:0]   V,
    input               RV, // flip
    input               CSV,
    input               MEMWRO,

    // PROM
    input       [10:0]  prog_addr,
    input               prom_5n_we,
    input       [ 7:0]  prom_din,

    output  reg [ 3:0]  TXTC,
    output  reg         TXTV
);


wire [3:0] txtc;
reg  [3:0] txtc0;
wire [10:0] rom_addr;
reg  [ 9:0] ram_addr;
wire [ 9:0] scan_addr = { V[7:3], H[7:3] };
wire [12:0]  ADx;

assign rom_addr[2:0] = V[2:0];

// AD is obfuscated
jtpopeye_video_dec u_dec(
    .AD     ( AD    ),
    .AD_dec ( ADx   )
);

wire we = CSV & MEMWRO;
reg wev, wec;

always @(*) begin
    ram_addr = we ? ADx[9:0] : { V[7:3], H[7:3] };
    wev = we && AD[11:10]==2'b00;
    wec = we && AD[11:10]==2'b01;
end

jtgng_ram #(.aw(10), .dw(8)) u_ram_5pr(
    .clk    ( clk            ),
    .cen    ( cpu_cen        ),
    .data   ( DD             ),
    .addr   ( ram_addr       ),
    .we     ( wev            ),
    .q      ( rom_addr[10:3] )
);

jtgng_ram #(.aw(10), .dw(4)) u_ram_5s(
    .clk    ( clk            ),
    .cen    ( cpu_cen        ),
    .data   ( DD[3:0]        ),
    .addr   ( ram_addr       ),
    .we     ( wec            ),
    .q      ( txtc           )
);

///////////////////////////
// Character ROM

wire [7:0] txtv;

jtgng_prom #(.aw(11),.dw(8),.simfile("../../rom/tpp2-v.5n"),
    .offset(12'h800)
) u_prom_5n(
    .clk    ( clk               ),
    .cen    ( pxl_cen           ),
    .data   ( prom_din          ),
    .rd_addr( rom_addr          ),
    .wr_addr( prog_addr[10:0]   ),
    .we     ( prom_5n_we        ),
    .q      ( txtv              )
);

reg [7:0] txtv0;

always @(posedge clk) if(pxl_cen) begin
    if( H[2:0]==3'd7 ) begin // TXTSHIFT
        txtv0 <= txtv;
        txtc0 <= txtc;
    end
    else txtv0 <= RV ? { txtv0[6:0], 1'b0 } : { 1'b0, txtv0[7:1] };
    TXTV <= ~(RV ? txtv0[7] : txtv0[0]);
    TXTC <= txtc0;
end

endmodule // jtpopeye_txt