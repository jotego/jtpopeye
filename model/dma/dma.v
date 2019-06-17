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
    inout   [9:0] AD,
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

wire Net__1D1_Pad10_;
wire Net__1D1_Pad12_;
wire Net__1D1_Pad8_;
wire Net__1D1_Pad9_;
wire Net__1M1_Pad1_;
wire Net__1M1_Pad25_;
wire Net__1M1_Pad26_;
wire Net__1M1_Pad27_;
wire Net__1M1_Pad2_;
wire Net__1M1_Pad3_;
wire Net__1R1_Pad1_;
wire Net__1R1_Pad21_;
wire Net__1R1_Pad2_;
wire Net__1R1_Pad3_;
wire Net__1R1_Pad4_;
wire Net__1R1_Pad5_;
wire Net__1R1_Pad6_;
wire Net__1R1_Pad7_;
wire Net__1S1_Pad1_;
wire Net__1S1_Pad21_;
wire Net__1S1_Pad2_;
wire Net__1S1_Pad3_;
wire Net__1S1_Pad4_;
wire Net__1S1_Pad5_;
wire Net__1S1_Pad6_;
wire Net__1S1_Pad7_;
wire Net__1T1_Pad1_;
wire Net__1T1_Pad21_;
wire Net__1T1_Pad2_;
wire Net__1T1_Pad3_;
wire Net__1T1_Pad4_;
wire Net__1T1_Pad5_;
wire Net__1T1_Pad6_;
wire Net__1T1_Pad7_;
wire Net__1U1_Pad12_;
wire Net__1U1_Pad14_;
wire Net__1U1_Pad16_;
wire Net__1U1_Pad1_;
wire Net__1U1_Pad21_;
wire Net__1U1_Pad2_;
wire Net__1U1_Pad3_;
wire Net__1U1_Pad4_;
wire Net__1U1_Pad5_;
wire Net__1U1_Pad6_;
wire Net__1U1_Pad7_;
wire Net__2A1_Pad10_;
wire Net__2A1_Pad3_;
wire Net__2C1_Pad1_;
wire Net__2C1_Pad3_;
wire Net__2C1_Pad6_;
wire Net__2C1_Pad8_;
wire Net__2D1_Pad3_;
wire Net__2D1_Pad6_;
wire Net__2D1_Pad8_;
wire Net__2R1_Pad1_;
wire Net__2R1_Pad21_;
wire Net__2R1_Pad2_;
wire Net__2R1_Pad3_;
wire Net__2R1_Pad4_;
wire Net__2R1_Pad5_;
wire Net__2R1_Pad6_;
wire Net__2R1_Pad7_;
wire Net__2S1_Pad1_;
wire Net__2S1_Pad21_;
wire Net__2S1_Pad2_;
wire Net__2S1_Pad3_;
wire Net__2S1_Pad4_;
wire Net__2S1_Pad5_;
wire Net__2S1_Pad6_;
wire Net__2S1_Pad7_;
wire Net__2T1_Pad1_;
wire Net__2T1_Pad21_;
wire Net__2T1_Pad2_;
wire Net__2T1_Pad3_;
wire Net__2T1_Pad4_;
wire Net__2T1_Pad5_;
wire Net__2T1_Pad6_;
wire Net__2T1_Pad7_;
wire Net__2U1_Pad1_;
wire Net__2U1_Pad21_;
wire Net__2U1_Pad2_;
wire Net__2U1_Pad3_;
wire Net__2U1_Pad4_;
wire Net__2U1_Pad5_;
wire Net__2U1_Pad6_;
wire Net__2U1_Pad7_;
wire Net__3A1_Pad10_;
wire Net__3A1_Pad1_;
wire Net__3A1_Pad2_;
wire Net__3A1_Pad3_;
wire Net__3A1_Pad8_;
wire Net__3A2_Pad2_;
wire Net__3A2_Pad3_;
wire Net__3M1_Pad1_;
wire Net__3M1_Pad25_;
wire Net__3M1_Pad26_;
wire Net__3M1_Pad27_;
wire Net__3M1_Pad2_;
wire Net__3M1_Pad3_;
wire Net__4A1_Pad11_;
wire Net__4A1_Pad8_;
wire Net__4B1_Pad9_;
wire Net__4P2_Pad10_;
wire Net__5L1_Pad2_;
wire Net__5L1_Pad8_;
wire Net__6T1_Pad10_;
wire Net__6T1_Pad4_;
wire Net__6T1_Pad6_;
wire Net__6T1_Pad8_;
wire Net__6U1_Pad10_;
wire Net__6U1_Pad11_;
wire Net__6U1_Pad12_;
wire Net__6U1_Pad13_;
wire Net__6U1_Pad14_;
wire Net__6U1_Pad3_;
wire Net__6U1_Pad7_;
wire Net__6U1_Pad9_;
wire Net__7L1_Pad11_;
wire Net__7M1_Pad10_;
wire Net__7M1_Pad15_;
wire Net__8L1_Pad2_;
wire Net__8L2_Pad2_;
wire Net__8L3_Pad2_;
wire Net__8L4_Pad2_;
wire Net__8L5_Pad2_;
wire Net__8T1_Pad12_;
wire Net__8T1_Pad4_;
wire Net__8T1_Pad7_;
wire Net__8T1_Pad9_;
wire Net__8U1_Pad12_;
wire Net__8U1_Pad15_;
wire Net__U1B1_Pad10_;
wire Net__U1B1_Pad12_;
wire Net__U1B1_Pad3_;
wire Net__U1B1_Pad6_;
wire Net__U1D1_Pad1_;
wire Net__U1D1_Pad3_;
wire Net__U1D1_Pad4_;
wire Net__U1D1_Pad5_;
wire Net__U1D1_Pad6_;
wire Net__U1D1_Pad8_;
wire Net__U1E1_Pad10_;
wire Net__U1E1_Pad11_;
wire Net__U1E1_Pad1_;
wire Net__U1E1_Pad2_;
wire Net__U1E1_Pad7_;
wire Net__U1E1_Pad9_;
wire Net__U1F1_Pad11_;
wire Net__U1F1_Pad12_;
wire Net__U1F1_Pad13_;
wire Net__U1F1_Pad14_;
wire Net__U1F1_Pad15_;
wire Net__U1F1_Pad3_;
wire Net__U1F1_Pad4_;
wire Net__U1F1_Pad5_;
wire Net__U1F1_Pad6_;
wire Net__U1L1_Pad1_;
wire Net__U1L1_Pad3_;
wire Net__U2D1_Pad6_;
wire Net__U2E1_Pad10_;
wire Net__U2E1_Pad11_;
wire Net__U2E1_Pad15_;
wire Net__U2E1_Pad3_;
wire Net__U2E1_Pad4_;
wire Net__U2E1_Pad5_;
wire Net__U2E1_Pad6_;
wire Net__U2F1_Pad11_;
wire Net__U2F1_Pad12_;
wire Net__U2F1_Pad13_;
wire Net__U2F1_Pad14_;
wire Net__U2F1_Pad3_;
wire Net__U2F1_Pad4_;
wire Net__U2F1_Pad5_;
wire Net__U2F1_Pad6_;
wire Net__U2_Pad5_;
wire Net__U2_Pad6_;
wire Net__U3H1_Pad10_;
wire Net__U3H1_Pad1_;
wire Net__U3H1_Pad2_;
wire Net__U3H1_Pad3_;
wire Net__U3H1_Pad4_;
wire Net__U3H1_Pad5_;
wire Net__U3H1_Pad6_;
wire Net__U3H1_Pad7_;
wire Net__U3H1_Pad9_;
wire Net__U3R1_Pad7_;
wire Net__U3T1_Pad10_;
wire Net__U3T1_Pad13_;
wire Net__U3T1_Pad1_;
wire Net__U3T1_Pad4_;
wire Net__U4E1_Pad5_;
wire Net__U9_Pad5_;

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
pullup p0(dma_DMCSpullup);

endmodule
