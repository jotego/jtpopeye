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

wire [17:0] DJ;
wire [7:0] H;
wire [8:0] ROVI;
wire AIn;
wire BIn;
wire BUSAK_n;
wire BUSRQn;
wire CSBWn;
wire DMCS;
wire DOTCK;
wire DWRBKn;
wire H2O;
wire HB;
wire INIT_EOn;
wire MEMWR0;
wire RVn;
wire TXTCL;
wire TXT_SHIFTn;
wire VBn;

wire [7:0] dma_DM;
wire [3:0] dma_DMCSn;
wire [5:0] video1_ADR0;
wire [5:0] video1_ADR1;
wire [17:0] video1_DJI;
wire [2:0] video1_ROVIalt;
wire [1:0] video2_S;
wire [3:0] video2_objcnt_start;
wire [5:0] video3_ADx;
wire [11:0] video3_AT;
wire [7:0] video3_BK;
wire [7:0] video3_ROH;
wire [8:0] video3_ROV;


`include "dma_model.v"

assign VBn = ~VB;
assign video3_ROV[0]=1'b0;  // ROV[0] does not exist on real schematics

endmodule
