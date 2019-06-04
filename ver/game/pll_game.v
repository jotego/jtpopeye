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

// 40.32 MHz (T/2=12.4ns) original clock
// 39.40 MHz (T/2=12.69ns) adjusted for 60Hz display

`define HALF_PERIOD 12.82

module pll_game_mist(
    input       inclk0, // 27 MHz
    output reg  c1,     
    output      c2,     // same as c1 but delayed
    output      locked
);

assign locked = 1;
real t2 = `HALF_PERIOD;

initial begin
    c1 = 1'b0;
    forever #t2 c1 = ~c1;
end

`ifndef SDRAM_DELAY
`define SDRAM_DELAY 4
`endif

real sdram_delay = `SDRAM_DELAY;
initial $display("INFO: SDRAM_CLK delay set to %f ns",sdram_delay);

assign #sdram_delay c2=c1;

endmodule // pll_game_mist

///////////// MiSTER PLL
module pll(
    input       refclk, // 27 MHz
    input       rst,
    output reg  outclk_0,     
    output      locked
);

assign locked = 1;
real t2 = `HALF_PERIOD;

initial begin
    outclk_0 = 1'b0;
    forever #t2 outclk_0 = ~outclk_0;
end

endmodule // pll_game_mist

