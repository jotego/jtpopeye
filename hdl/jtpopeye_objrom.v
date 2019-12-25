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

// MAME ROM sets seem to have the ROM address for objects inverted
// That's why prog_addr is inverted in this module, to correct for that.

module jtpopeye_objrom(
    input               clk,
    // ROM loading
    input       [12:0]  prog_addr,
    input       [ 7:0]  prog_data,
    input       [ 3:0]  prom_we,
    // ROM access
    input       [12:0]  obj_addr,  // 32 kB
    output reg  [15:0]  obj_dout0,
    output reg  [15:0]  obj_dout1
);

wire [7:0] objk_data, objj_data, objf_data, obje_data;

wire prom_1e_we = prom_we[0];
wire prom_1f_we = prom_we[1];
wire prom_1j_we = prom_we[2];
wire prom_1k_we = prom_we[3];

always @(posedge clk) begin
    // obj_dout0 <= { objk_data, objj_data };
    // obj_dout1 <= { objf_data, obje_data };
    obj_dout0 <= { objj_data, objk_data };
    obj_dout1 <= { obje_data, objf_data };
end

// Object ROMs
jtframe_prom #(.aw(13), .simfile("../../rom/tpp2-v.1e")) u_obj0(
    .clk    ( clk             ),
    .cen    ( 1'b1            ),
    .data   ( prog_data       ),
    .rd_addr( obj_addr        ),
    .wr_addr( ~prog_addr      ),
    .we     ( prom_1e_we      ),
    .q      ( obje_data       )
);

jtframe_prom #(.aw(13), .simfile("../../rom/tpp2-v.1f")) u_obj1(
    .clk    ( clk             ),
    .cen    ( 1'b1            ),
    .data   ( prog_data       ),
    .rd_addr( obj_addr        ),
    .wr_addr( ~prog_addr      ),
    .we     ( prom_1f_we      ),
    .q      ( objf_data       )
);

jtframe_prom #(.aw(13), .simfile("../../rom/tpp2-v.1j")) u_obj2(
    .clk    ( clk             ),
    .cen    ( 1'b1            ),
    .data   ( prog_data       ),
    .rd_addr( obj_addr        ),
    .wr_addr( ~prog_addr      ),
    .we     ( prom_1j_we      ),
    .q      ( objj_data       )
);

jtframe_prom #(.aw(13), .simfile("../../rom/tpp2-v.1k")) u_obj3(
    .clk    ( clk             ),
    .cen    ( 1'b1            ),
    .data   ( prog_data       ),
    .rd_addr( obj_addr        ),
    .wr_addr( ~prog_addr      ),
    .we     ( prom_1k_we      ),
    .q      ( objk_data       )
);
endmodule // jtgng_rom