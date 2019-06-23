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
    input                downloading,
    input      [21:0]    ioctl_addr,
    input      [ 7:0]    ioctl_data,
    input                ioctl_wr,
    output reg [21:0]    prog_addr,
    output reg [ 7:0]    prog_data,
    output reg [ 1:0]    prog_mask, // active low
    output reg           prog_we,
    output reg [13:0]    prom_we,   // update prom_we0 below if prom_we is edited!
    // signal whether the CPU data is encrypted or not
    output               encrypted
);

`ifndef MISTER
localparam PROM_ADDR = 8192*8;
`else
localparam PROM_ADDR = 0;
`endif

reg set_strobe, set_done;
reg [13:0] prom_we0;

always @(posedge clk_rgb) begin
    prom_we <= 14'd0;
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
            prom_we0  <= 14'd0;
        end
        else begin // PROMs
            prog_mask <= 2'b11;
            prog_addr <= ioctl_addr;
            prom_we0  <= 14'd0;
            if( !ioctl_addr[16] ) begin
                prom_we0[ ioctl_addr[15:13] ] <= 1'b1;
            end else begin
                if( ioctl_addr[12:11] == 2'b01 )
                    prom_we0[5] <= 1'b1; // 5N TXT, throw away the 1st half of the file
                else if(ioctl_addr[12]) begin
                    case(ioctl_addr[9:8])
                        2'h0: prom_we0[0] <= 1'b1;    // 7J, timing
                        2'h1: prom_we0[1] <= 1'b1;    // 5B OBJ PAL
                        2'h2: prom_we0[2] <= 1'b1;    // 5A OBJ PAL
                        2'h3: if( ioctl_addr[5] )
                            prom_we0[4] <= 1'b1;
                        else
                            prom_we0[3] <= 1'b1; // 3A, 4A TXT/BACK PAL
                    endcase
                end
                set_strobe <= 1'b1;
            end
        end
    end
end
/*
`ifndef TESTROM
reg [3:0] encrypt_test=4'hf;
reg check;
reg last_downloading;

always @(posedge clk_rom) begin
    last_downloading <= downloading;
    if( !last_downloading && downloading ) check<=1'b1;
    if( check && ioctl_wr ) begin
        case( ioctl_addr[1:0] )
            2'b00: encrypt_test[0] = ioctl_data==8'he4;
            2'b01: encrypt_test[1] = ioctl_data==8'h64;
            2'b10: encrypt_test[2] = ioctl_data==8'ha5;
            2'b11: begin
                encrypt_test[3] = ioctl_data==8'h46;
                check <= 1'b0;
            end
        endcase
    end
    encrypted <= &encrypt_test;
end
`else
// For simulations with test roms and no loading:
initial encrypted = 1'b0;
`endif

`ifdef SIMULATION
always @(negedge downloading) if( prog_addr )  // avoid displaying a message
    // at time 0
begin
    if( encrypted )
        $display("Finished downloading an ENCRYPTED ROM");
    else
        $display("Finished downloading a NON-ENCRYPTED ROM");
end
`endif
*/
`ifndef TESTROM
assign encrypted = 1'b1;
`else
assign encrypted = 1'b0;
`endif
endmodule // jt1492_promprog
