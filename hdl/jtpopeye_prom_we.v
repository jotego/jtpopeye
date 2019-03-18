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

module jtpopeye_prom_we(
    input                clk_rom,
    input                clk_rgb,
    input                prom_cen,
    input                downloading,
    input      [21:0]    ioctl_addr,
    input      [ 7:0]    ioctl_data,
    input                ioctl_wr,
    output reg [21:0]    prog_addr,
    output reg [ 7:0]    prog_data,
    output reg [ 1:0]    prog_mask, // active low
    output reg           prog_we,
    output reg [ 5:0]    prom_we    // update prom_we0 below if prom_we is edited!
);

localparam PROM_ADDR = 8192*8;

reg set_strobe, set_done;
reg [5:0] prom_we0;

always @(posedge clk_rgb) if(prom_cen) begin
    prom_we <= 'd0;
    if( set_strobe ) begin
        prom_we <= prom_we0;
        set_done <= 1'b1;
    end else if(set_done) begin
        set_done <= 1'b0;
    end
end

always @(posedge clk_rom) begin
    prog_we   <= 1'b0;
    if( set_done ) set_strobe <= 1'b0;
    if ( ioctl_wr ) begin
        prog_data <= ioctl_data;
        if( ioctl_addr < PROM_ADDR ) begin
            prog_addr <= { 1'b0, ioctl_addr[21:1] };
            prog_we   <= 1'b1;
            prog_mask <= {ioctl_addr[0], ~ioctl_addr[0]};
            prom_we0  <= 'd0;
        end
        else begin // PROMs
            prog_mask <= 2'b11;
            prog_addr <= ioctl_addr;
            if( !ioctl_addr[12] )
                prom_we0 <= 6'h20; // 5N TXT
            else begin
                case(ioctl_addr[9:8])
                    2'h0: prom_we0 <= 6'h01;    // 7J, timing
                    2'h1: prom_we0 <= 6'h02;    // 5B OBJ PAL
                    2'h2: prom_we0 <= 6'h04;    // 5A OBJ PAL
                    2'h3: prom_we0 <= ioctl_addr[5] ?6'h10 : 6'h08; // 3A, 4A TXT/BACK PAL
                    default: prom_we0 <= 6'h0;  //
                endcase
            end
            set_strobe <= 1'b1;
        end
    end
end

endmodule // jt1492_promprog