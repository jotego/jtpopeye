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
    input               rst_n,
    input               clk,

    input       [14:0]  main_addr, // 32 kB, addressed as 8-bit words
    input       [12:0]  obj_addr,  // 32 kB

    output reg  [ 7:0]  main_dout,
    output reg  [31:0]  obj_dout,
    input               main_cs,
    // ROM loading
    input               prog_we,    // strobe
    input       [14:0]  prog_addr,
    input       [ 7:0]  prog_data,
    input       [ 1:0]  prog_mask
);

reg [7:0] main_mem[0:32767];
reg [7:0] obj0_mem[0:8191];
reg [7:0] obj1_mem[0:8191];
reg [7:0] obj2_mem[0:8191];
reg [7:0] obj3_mem[0:8191];

reg [14:0] wr_addr;

reg [7:0] data_in;

reg main_we;
reg [3:0] obj_we;
wire addr0 = prog_mask[0];

always @(posedge clk or negedge rst_n) 
    if( !rst_n ) begin
        wr_addr  <= 15'd0;
        data_in  <= 8'd0;
        main_we  <= 1'b0;
        obj_we   <= 4'd0;
    end else begin
        if( prog_we ) begin
            wr_addr <= { prog_addr[13:0], addr0 };
            data_in      <= prog_data;
            main_we <= ~prog_addr[14];
            obj_we[0] <=  prog_addr[14:12] == 3'b100;
            obj_we[1] <=  prog_addr[14:12] == 3'b101;
            obj_we[2] <=  prog_addr[14:12] == 3'b110;
            obj_we[3] <=  prog_addr[14:12] == 3'b111;
        end
        else begin
            main_we <= 1'b0;
            obj_we  <= 4'b0;
        end
    end

always @(posedge clk or negedge rst_n) 
    if( !rst_n ) begin
        main_dout <= 8'd0;
    end else begin
        if( main_we ) 
            main_mem[wr_addr] <= data_in;
        else if(main_cs)
            main_dout <= main_mem[main_addr];
    end

always @(posedge clk) begin
    if( obj_we[0] ) obj0_mem[ wr_addr[11:0] ] <= data_in;
    if( obj_we[1] ) obj1_mem[ wr_addr[11:0] ] <= data_in;
    if( obj_we[2] ) obj2_mem[ wr_addr[11:0] ] <= data_in;
    if( obj_we[3] ) obj3_mem[ wr_addr[11:0] ] <= data_in;
    obj_dout <= {
        obj3_mem[obj_addr],
        obj2_mem[obj_addr],
        obj1_mem[obj_addr],
        obj0_mem[obj_addr]
    };
end

`ifdef SIMULATION
initial begin : load
    integer f;
    f=$fopen("../../rom/tpp2-c.7a", "rb"); $fread( main_mem, f,      0, 8191); $fclose(f);
    f=$fopen("../../rom/tpp2-c.7b", "rb"); $fread( main_mem, f,  8192,16383 ); $fclose(f);
    f=$fopen("../../rom/tpp2-c.7c", "rb"); $fread( main_mem, f, 16384,24575 ); $fclose(f);
    f=$fopen("../../rom/tpp2-c.7e", "rb"); $fread( main_mem, f, 24576,31767 ); $fclose(f);

    f=$fopen("../../rom/tpp2-v.1e", "rb"); $fread( obj0_mem, f); $fclose(f);
    f=$fopen("../../rom/tpp2-v.1f", "rb"); $fread( obj1_mem, f); $fclose(f);
    f=$fopen("../../rom/tpp2-v.1j", "rb"); $fread( obj2_mem, f); $fclose(f);
    f=$fopen("../../rom/tpp2-v.1k", "rb"); $fread( obj3_mem, f); $fclose(f);
end
`endif

endmodule // jtgng_rom