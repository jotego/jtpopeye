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

module jtpopeye_rom(
    input               rst_n,
    input               clk,
    input               pxl_cen, // 10 MHz
    input               LVBL,
    output  reg         sdram_re, // any edge (rising or falling)
        // means a read request

    input       [14:0]  main_addr, // 32 kB, addressed as 8-bit words
    input       [12:0]  obj_addr,  // 32 kB

    output      [ 7:0]  main_dout,
    output      [31:0]  obj_dout,
    output  reg         ready,
    // ROM interface
    input               downloading,
    input               loop_rst,
    output  reg [21:0]  sdram_addr,
    input       [31:0]  data_read
);

parameter  obj_offset = 4*8192/2;

reg [3:0] ready_cnt;

reg [1:0] data_sel;
wire main_req, obj_req;
wire [14:0] main_addr_req;
wire [12:0] obj_addr_req;

always @(posedge clk) if(pxl_cen) begin
    if( loop_rst || downloading )
        sdram_re <= 1'b0;   // start strobing before ready signal
            // because first data must be read before that signal.
    else
        if(main_req||obj_req) sdram_re <= ~sdram_re;
end


jt1943_romrq #(.AW(15),.INVERT_A0(1)) u_main(
    .rst_n    ( rst_n           ),
    .clk      ( clk             ),
    .cen      ( pxl_cen         ),
    .addr     ( main_addr       ),
    .addr_ok  ( 1'b1            ), 
    .addr_req ( main_addr_req   ),
    .din      ( data_read       ),
    .dout     ( main_dout       ),
    .req      ( main_req        ),
    .we       ( data_sel[0]     )
);

jt1943_romrq #(.AW(13),.DW(32)) u_obj(
    .rst_n    ( rst_n           ),
    .clk      ( clk             ),
    .cen      ( pxl_cen         ),
    .addr     ( obj_addr        ),
    .addr_ok  ( 1'b1            ),
    .addr_req ( obj_addr_req    ),
    .din      ( data_read       ),
    .dout     ( obj_dout        ),
    .req      ( obj_req         ),
    .we       ( data_sel[1]     )
);

`ifdef SIMULATION
real busy_cnt=0, total_cnt=0;
always @(posedge clk) begin
    total_cnt <= total_cnt + 1;
    if( |data_sel ) busy_cnt <= busy_cnt+1;
end
always @(posedge LVBL) begin
    $display("INFO: frame ROM stats: %.0f %%", 100.0*busy_cnt/total_cnt);
end
`endif

always @(posedge clk)
if( loop_rst || downloading ) begin
    sdram_addr <= 'b0;
    ready_cnt <=  4'd0;
    ready     <=  1'b0;
end else if(pxl_cen) begin
    {ready, ready_cnt}  <= {ready_cnt, 1'b1};
    case( 1'b1 )
        main_req: begin
            sdram_addr <= { 8'd0, main_addr_req[14:1] };
            data_sel   <= 'b1;
        end
        obj_req: begin
            sdram_addr <= obj_offset + { 8'b0, obj_addr_req, 1'b0 };
            data_sel   <= 'b10;
        end
        default: data_sel <= 'b0;
    endcase
end

endmodule // jtgng_rom