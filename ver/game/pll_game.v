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

module pll_game_mist(
    input        inclk0, // 27 MHz
    output reg  c1,     // 40.32 MHz
    output      c2,     // 40.32 MHz delayed
    output      locked
);

assign locked = 1;

initial begin
    c1 = 1'b0;
    forever #12.4 c1 = ~c1;
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
    output reg  outclk_0,     // 40.32 MHz
    output      locked
);

assign locked = 1;

initial begin
    outclk_0 = 1'b0;
    forever #12.4 outclk_0 = ~outclk_0;
end

endmodule // pll_game_mist
