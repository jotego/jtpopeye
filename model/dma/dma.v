`timescale 1ns/1ps

module dma(
    input   RESET,
    output  ROHVCK,
    output  ROHVS,

    output  [9:0] AD,
    input   AIn,
    input   BIn,
    input   BUSAK_n,
    output  BUSRQn,
    output  DMCS,
    output  DMCS0n,
    output  DMCS1n,
    output  DMCS2n,
    output  DMCS3n,
    output  [7:0] DM,
    input   HBDn,
    input   VB
);


`include "dma_model.v"

assign VBn = ~VB;
pullup p0(DMCSpullup);

endmodule