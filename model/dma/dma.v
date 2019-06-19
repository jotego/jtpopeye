`timescale 1ns/1ps

module dma(
    input   RESET,
    output  ROHVCK,
    output  ROHVS,
    
    
    // from timing
    input   H2O,
    input   [7:0] H,
    input   [7:0] V,
    input   HBDn,
    input   HB,
    input   VB,
    input   DOTCK,
    
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
    
    output  DMCS,
    output  [28:0] DO
);

wire [17:0] DJ;
wire [8:0] ROVI;
wire [7:0] dma_DM;
wire [3:0] dma_DMCSn;
wire [5:0] video1_ADR0;
wire [5:0] video1_ADR1;
wire [17:0] video1_DJI;
wire [2:0] video1_ROVIalt;
wire [12:0] video3_AD;
wire [5:0] video3_ADx;
wire [11:0] video3_AT;
wire [7:0] video3_BK;
wire [7:0] video3_ROH;
wire [8:0] video3_ROV;

wire AIn;
wire BIn;

wire TXTCL;
wire VBn;
wire dma_AI;
wire dma_BI;
wire dma_BUSAK;
wire dma_BUSRQ;
wire dma_DMCSpullup;
wire dma_DMEND;
wire dma_DMclr_n;
wire video1_CEn0;
wire video1_CEn1;
wire video1_H0ln;
wire video1_RV;
wire video1_WEn0;
wire video1_WEn1;
wire video3_AT11n;
wire video3_BAKCK;


`include "dma_model.v"

assign VBn = ~VB;
assign video3_ROV[0]=1'b0;  // ROV[0] does not exist on real schematics

endmodule
