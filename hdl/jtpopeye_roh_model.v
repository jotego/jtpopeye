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

// Sheet 1 of 3, CPU

module jtpopeye_roh_model(
    input       VB_n,
    input       AI_n,
    input       BI_n,
    input       HBD_n,
    input       DM10,
    input       busak,
    output      ROHVS,
    output      ROHVCK,
    output      MR_n
);

reg busrq_n, busak_d;

// LS74, 1L
always @( posedge ~VB_n or negedge ~DM10 )
    if( DM10 )
        busrq_n <= 1'b1;
    else
        busrq_n <= 1'b0;

// LS74, 2D (1st FF)
reg H1l;

always @( posedge ~AI_n )
    H1l <= ~BI_n;

// LS74, 2D (second FF)
always @( posedge BI_n )
    busak_d <= busak;

// LS74, 1C
reg ff_1c0;
wire ff_1c0_clr_n = ~(~busrq_n & ~busak_d);
wire ff_1c0_din   = busak_d | ~HBD_n;

always @( posedge H1l or negedge ff_1c0_clr_n)
    if( !ff_1c0_clr_n )
        ff_1c0 <= 1'b0;
    else
        ff_1c0 <= ff_1c0_din;


reg ff_1c1;
wire ff_1c1_din = ~( ~ff_1c0 & ff_1c0_din );

always @( posedge ~AI_n )
    ff_1c1 <= ff_1c1_din;

assign ROHVS  = ~ff_1c1 | ~ff_1c1_din;
assign ROHVCK = ~( ~ff_1c1 & ~BI_n );
assign MR_n   = ff_1c0_din;

endmodule