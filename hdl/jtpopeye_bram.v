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

module jtpopeye_bram(
    input               clk,
    // ROM loading
    input       [14:0]  prog_addr,
    input       [ 7:0]  prog_data,
    input       [ 7:0]  prom_we,
    // ROM access
    input       [14:0]  main_addr, // 32 kB, addressed as 8-bit words

    output reg  [ 7:0]  main_dout,
    input               main_cs
);

wire [7:0] main0_data, main1_data, main2_data, main3_data;

wire prom_7a_we = prom_we[0];
wire prom_7b_we = prom_we[1];
wire prom_7c_we = prom_we[2];
wire prom_7e_we = prom_we[3];

always @(posedge clk) if(main_cs) begin
    case( main_addr[14:13] )
        2'd0: main_dout <= main0_data;
        2'd1: main_dout <= main1_data;
        2'd2: main_dout <= main2_data;
        2'd3: main_dout <= main3_data;
    endcase
end

// Main CPU ROMs
jtgng_prom #(.aw(13), .simfile("../../rom/tpp2-c.7a")) u_main0(
    .clk    ( clk             ),
    .cen    ( 1'b1            ),
    .data   ( prog_data       ),
    .rd_addr( main_addr[12:0] ),
    .wr_addr( prog_addr[12:0] ),
    .we     ( prom_7a_we      ),
    .q      ( main0_data      )
);

jtgng_prom #(.aw(13), .simfile("../../rom/tpp2-c.7b")) u_main1(
    .clk    ( clk             ),
    .cen    ( 1'b1            ),
    .data   ( prog_data       ),
    .rd_addr( main_addr[12:0] ),
    .wr_addr( prog_addr[12:0] ),
    .we     ( prom_7b_we      ),
    .q      ( main1_data      )
);

jtgng_prom #(.aw(13), .simfile("../../rom/tpp2-c.7c")) u_main2(
    .clk    ( clk             ),
    .cen    ( 1'b1            ),
    .data   ( prog_data       ),
    .rd_addr( main_addr[12:0] ),
    .wr_addr( prog_addr[12:0] ),
    .we     ( prom_7c_we      ),
    .q      ( main2_data      )
);

jtgng_prom #(.aw(13), .simfile("../../rom/tpp2-c.7e")) u_main3(
    .clk    ( clk             ),
    .cen    ( 1'b1            ),
    .data   ( prog_data       ),
    .rd_addr( main_addr[12:0] ),
    .wr_addr( prog_addr[12:0] ),
    .we     ( prom_7e_we      ),
    .q      ( main3_data      )
);

endmodule // jtgng_rom