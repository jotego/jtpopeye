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

module jtpopeye_main(
    input              rst_n,
    input              clk,
    input              cen4,
    input              cen2,
    input              LVBL,
    // cabinet I/O
    input   [6:0]      joystick1,
    input   [6:0]      joystick2,
    input   [1:0]      start_button,
    input              coin_input,
    input              service,
    // DIP switches
    input   [7:0]       dip_sw2,
    input   [3:0]       dip_sw1,
    //
    output              RV_n,
    output              cpu_cen,
    // Sound output
    output reg [ 8:0]  snd
);

wire [15:0] AD, Ascrambled;
assign cpu_cen = cen4;
wire iorq_n;
wire wr_n, rd_n;
wire iowr = ~wr_n & ~iorq_n;

wire [7:0] cabinet_input;

// Address obfuscation
assign AD[2:0]   = Ascrambled[2:0];
assign AD[ 3]    = Ascrambled[4];
assign AD[ 4]    = Ascrambled[5];
assign AD[ 5]    = Ascrambled[9];
assign AD[ 6]    = Ascrambled[3];
assign AD[ 7]    = Ascrambled[6];
assign AD[ 8]    = Ascrambled[7];
assign AD[ 9]    = Ascrambled[8];
assign AD[15:10] = Ascrambled[15:10];

///////////////////////////
// cabinet input
reg ay_cs;

always @(*) begin
    cabinet_input = 8'hff;
    ay_cs = 'b0;
    if( !iorq_n && !rd_n )
        case(AD[1:0])
            2'd0: ay_cs = 'b1;
            2'd1: begin
                cabinet_input[7]   = coin_input;
                cabinet_input[6]   = service;
                cabinet_input[5]   = init_eo;   // ??
                cabinet_input[3:2] = start_button;
            end
            2'd2: begin // 2P input
                cabinet_input[1:0] = joystick2[1:0]; // 2P left, right
                cabinet_input[2]   = joystick2[3]; // 2P up
                cabinet_input[3]   = joystick2[2]; // 2P down
                cabinet_input[4]   = joystick2[4]; // 2P punch
            end
            2'd3: begin // 1P input
                cabinet_input[1:0] = joystick1[1:0]; // 1P left, right
                cabinet_input[2]   = joystick1[3]; // 1P up
                cabinet_input[3]   = joystick1[2]; // 1P down
                cabinet_input[4]   = joystick1[4]; // 1P punch
            end
        endcase
end



T80s u_cpu(
    .RESET_n    ( rst_n       ),
    .CLK        ( clk         ),
    .CEN        ( cpu_cen     ),
    .WAIT_n     ( 1'b1        ),
    .INT_n      ( 1'b1        ),
    .RD_n       ( rd_n        ),
    .WR_n       ( wr_n        ),
    .A          ( Ascrambled  ),
    .DI         ( cpu_din     ),
    .DO         ( cpu_dout    ),
    .IORQ_n     ( iorq_n      ),
    .M1_n       ( m1_n        ),
    .MREQ_n     ( mreq_n      ),
    .NMI_n      ( 1'b1        ),
    .BUSRQ_n    ( ~bus_req    ),
    .BUSAK_n    ( busak_n     ),
    .RFSH_n     ( rfsh_n      ),
    .out0       ( 1'b0        )
);


// Dip switches and AY I/O ports
reg  [7:0] dip_data;
wire [7:0] IOA;
wire [2:0] dip_mux = IOA[3:1];
assign RV_n = IOA[0];

always @( * ) begin
    dip_data[3:0] = dip_sw1;
    dip_data[6:5] = 3'b000;
    dip_data[7] = dip_sw2[dip_mux];
end

wire bc = (iowr & AD[0]) | ay_cs;

jt49_bus u_ay( // note that input ports are not multiplexed
    .rst_n  ( rst_n     ),
    .clk    ( clk       ),
    .clk_en ( cen2      ),
    .bdir   ( iowr      ),
    .bc1    ( bc        ),
    .din    ( dout      ),
    .sel    ( 1'b0      ),
    .dout   ( ay0_dout  ),
    .sound  ( sound0    ),
    .IOA_out( IOA       ),
    .IOB_in ( dip_data  ),
    .A(), .B(), .C() // unused outputs
);

endmodule // jtpopeye_main