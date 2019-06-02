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

// 2^6 = 64 horizontal x4 units
// 2^6 = 64 vertical   x4 units

module jtpopeye_bck(
    input               rst_n,
    input               clk,
    input               pxl_cen,
    input               cpu_cen,

    // CPU interface
    input               CSBW_n,
    input               DWRBK,

    input               ROHVCK,
    input      [12:0]   AD,
    input      [ 8:0]   ROVI,
    input      [28:0]   DO,
    input      [ 7:0]   DD,
    output reg [ 3:0]   BAKC
);

reg [7:0] ROH;  // 74161. 7N/7M video sheet 3/3
reg [8:1] ROVl;

always @(posedge clk) begin
    if(!ROHVCK) begin
        ROH  <= DO[7:0];
        ROVl <= ROVI[8:1];
    end else
    if(pxl_cen) begin
        ROH <= ROH+8'd1;
    end
end

reg [11:0] ram_addr;
wire [7:0] ram_dout;
reg nibble_sel;


always @(posedge clk) if(pxl_cen) begin
    if( ROH[1:0]==2'b11 )
        BAKC <= nibble_sel ? ram_dout[3:0] : ram_dout[7:4];
end

reg [7:0] ram_din;
reg       ram_we;

always @(posedge clk or negedge rst_n) begin: ram_ports
    reg DWRBK_last;
    reg [2:0] st;
    if( !rst_n ) begin
        ram_we     <= 1'b0;
        DWRBK_last <= 1'b0;
        st         <= 3'b1;
    end else begin
        // advance state
        if( (DWRBK && !DWRBK_last) || !st[0] )
            st <= { st[1:0], st[2] };
        DWRBK_last <= DWRBK;
        case( 1'b1 )
            st[0]: begin
                    // set RAM address for reading
                    ram_we     <= 1'b0;
                    ram_addr   <= !CSBW_n ? AD[11:0] : {ROVl[6:1],ROH[7:2]};
                    nibble_sel <= !CSBW_n ? !AD[12] : ROVl[7];
                end 
            st[1]:; // wait for data input
            st[2]: begin // write the requested nibble
                    ram_we     <= 1'b1;
                    ram_din    <= nibble_sel ?
                        { ram_dout[7:4], DD[3:0] } : { DD[3:0], ram_dout[3:0] };
                end
            default:;
        endcase
    end
end

jtgng_ram #(.aw(12), .dw(8)) u_ram1(
    .clk    ( clk            ),
    .cen    ( 1'b1           ),
    .data   ( ram_din        ),
    .addr   ( ram_addr       ),
    .we     ( ram_we         ),
    .q      ( ram_dout       )
);


endmodule // jtpopeye_bak