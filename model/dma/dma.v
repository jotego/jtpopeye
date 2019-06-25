`timescale 1ns/1ps

module dma(
    input   RESET,
    input   CLK20,
    output  ROHVCK,
    output  ROHVS,
    
    // from timing
    input   [7:0] V,
    input   HBDn,
    input   VB,
    
    // from CPU
    inout   [7:0] DD,
    inout   [11:0] AD,
    input   CSBWn,
    input   DWRBKn,
    input   MEMWR0,
    input   BUSAK_n,
    output  BUSRQn,
    input   RVn,
    
    // Background
    output  [3:0] BAKC,
    // Objects
    output  [2:0] OBJC,
    output  [1:0] OBJV,
    
    output  DMCS,
    output  [28:0] DO
);

`include "dma_model.v"

assign VBn = ~VB;
assign _video3_ROV[0]=1'b0;  // ROV[0] does not exist on real schematics

endmodule
