/*  This file is part of JTPOPEYE.
    JTPOPEYE program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    JTPOPEYE program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
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

    input       [14:0]  main_addr, // 32 kB, addressed as 8-bit words

    output      [ 7:0]  main_dout,
    input               main_cs,
    output              main_ok,
    output  reg         ready,
    // SDRAM controller interface
    input               downloading,
    input               data_rdy,
    input               sdram_ack,
    input               loop_rst,
    output  reg         sdram_req,
    output  reg         refresh_en,
    output  reg [21:0]  sdram_addr,
    input       [31:0]  data_read
);

localparam  obj_offset = 22'd16384;

reg [3:0] ready_cnt;

reg  data_sel;
wire main_req;
wire [14:0] main_addr_req;

always @(posedge clk) begin
    refresh_en <= main_cs & main_ok;
end

jtframe_romrq #(.AW(15),.INVERT_A0(1)) u_main(
    .rst_n    ( rst_n           ),
    .clk      ( clk             ),
    .addr     ( main_addr       ),
    .addr_ok  ( main_cs         ), 
    .addr_req ( main_addr_req   ),
    .din      ( data_read       ),
    .din_ok   ( data_rdy        ),
    .data_ok  ( main_ok         ),
    .dout     ( main_dout       ),
    .req      ( main_req        ),
    .we       ( data_sel        )
);

// Requests are valid for comparison only if they are not
// being already attended. data_sel is high for the request
// in course
wire valid_req = main_req & ~data_sel;

always @(posedge clk)
if( loop_rst || downloading ) begin
    sdram_addr <= 22'd0;
    ready_cnt <=  4'd0;
    ready     <=  1'b0;
    sdram_req <=  1'b0;
    data_sel  <=  1'd0;
end else begin
    {ready, ready_cnt}  <= {ready_cnt, 1'b1};
    if( sdram_ack ) sdram_req <= 1'b0;
    // accept a new request
    if( !data_sel || data_rdy ) begin
        sdram_req <= valid_req;
        data_sel <= 1'b0;
        if( valid_req ) begin
            sdram_addr  <= { 8'd0, main_addr_req[14:1] };
            data_sel    <= 1'b1;
        end
    end
end

endmodule // jtgng_rom