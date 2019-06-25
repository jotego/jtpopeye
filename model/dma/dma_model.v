jt7404 u_1A1(
    .in1       ( BIn                      ) /* pin 1*/ ,
    .out2      ( _dma_BI                  ) /* pin 2*/ ,
    .in3       ( AIn                      ) /* pin 3*/ ,
    .out4      ( _dma_AI                  ) /* pin 4*/ 
);

jt7400 u_1B1(
    .in1       ( _dma_BI                  ) /* pin 1*/ ,
    .in2       ( _dma_BI                  ) /* pin 2*/ ,
    .out3      ( Net__1B1_Pad3_           ) /* pin 3*/ ,
    .in4       ( _dma_AI                  ) /* pin 4*/ ,
    .in5       ( _dma_AI                  ) /* pin 5*/ ,
    .out6      ( Net__1B1_Pad6_           ) /* pin 6*/ ,
    .out8      ( ROHVS                    ) /* pin 8*/ ,
    .in9       ( _dma_DMclr_n             ) /* pin 9*/ ,
    .in10      ( Net__1B1_Pad10_          ) /* pin 10*/ ,
    .out11     ( ROHVCK                   ) /* pin 11*/ ,
    .in12      ( Net__1B1_Pad12_          ) /* pin 12*/ ,
    .in13      ( _dma_BI                  ) /* pin 13*/ 
);

jt7474 u_1C1(
    .cl1_b     ( Net__1C1_Pad1_           ) /* pin 1*/ ,
    .d1        ( Net__1C1_Pad2_           ) /* pin 2*/ ,
    .clk1      ( Net__1C1_Pad3_           ) /* pin 3*/ ,
    .pr1_b     ( 1'b1                     ) /* pin 4*/ ,
    .q1        ( Net__1C1_Pad5_           ) /* pin 5*/ ,
    .q1_b      ( Net__1C1_Pad6_           ) /* pin 6*/ ,
    .q2_b      ( Net__1B1_Pad12_          ) /* pin 8*/ ,
    .q2        ( Net__1B1_Pad10_          ) /* pin 9*/ ,
    .pr2_b     ( 1'b1                     ) /* pin 10*/ ,
    .clk2      ( _dma_AI                  ) /* pin 11*/ ,
    .d2        ( _dma_DMclr_n             ) /* pin 12*/ ,
    .cl2_b     ( 1'b1                     ) /* pin 13*/ 
);

jt7432 u_1D1(
    .out8      ( _video1_DJ_CEn           ) /* pin 8*/ ,
    .in9       ( _video1_carry            ) /* pin 9*/ ,
    .in10      ( _video1_train            ) /* pin 10*/ ,
    .out11     ( _video1_train            ) /* pin 11*/ ,
    .in12      ( _video1_H0H0or           ) /* pin 12*/ ,
    .in13      ( ROHVS                    ) /* pin 13*/ 
);

jt7400 u_1D2(
    .in1       ( Net__1D2_Pad1_           ) /* pin 1*/ ,
    .in2       ( HBDn                     ) /* pin 2*/ ,
    .out3      ( Net__1C1_Pad2_           ) /* pin 3*/ ,
    .in4       ( Net__1D2_Pad4_           ) /* pin 4*/ ,
    .in5       ( Net__1C1_Pad3_           ) /* pin 5*/ ,
    .out6      ( Net__1D2_Pad6_           ) /* pin 6*/ ,
    .out8      ( Net__1C1_Pad1_           ) /* pin 8*/ ,
    .in9       ( Net__1D2_Pad1_           ) /* pin 9*/ ,
    .in10      ( _dma_BUSRQ               ) /* pin 10*/ ,
    .out11     ( _dma_DMclr_n             ) /* pin 11*/ ,
    .in12      ( Net__1C1_Pad2_           ) /* pin 12*/ ,
    .in13      ( Net__1C1_Pad6_           ) /* pin 13*/ 
);

jt74138 u_1E1(
    .e1_b      ( Net__1D2_Pad1_           ) /* pin 4*/ ,
    .e2_b      ( _dma_DMEND               ) /* pin 5*/ ,
    .e3        ( Net__1B1_Pad3_           ) /* pin 6*/ ,
    .a         ({ 1'b0,
                  Net__1E1_Pad2_,
                  Net__1E1_Pad1_}),
    .y_b       ({ Net__1E1_Pad7_,
                  Net__1E1_Pad9_,
                  Net__1E1_Pad10_,
                  Net__1E1_Pad11_,
                  _dma_DMCSn[3],
                  _dma_DMCSn[2],
                  _dma_DMCSn[1],
                  _dma_DMCSn[0]})
);

ROM_2764 u_1E2(
    .CEn       ( 1'b0                     ) /* pin 20*/ ,
    .OEn       ( 1'b0                     ) /* pin 22*/ ,
    .P         ( 1'b1                     ) /* pin 27*/ ,
    .A         ({ DJ[16],
                  DJ[17],
                  DJ[10],
                  DJ[9],
                  DJ[8],
                  DJ[7],
                  DJ[6],
                  DJ[5],
                  DJ[4],
                  DJ[3],
                  DJ[2],
                  DJ[1],
                  _video2_DJEO}),
    .D         ({ Net__1E2_Pad19_,
                  Net__1E2_Pad18_,
                  Net__1E2_Pad17_,
                  Net__1E2_Pad16_,
                  Net__1E2_Pad15_,
                  Net__1E2_Pad13_,
                  Net__1E2_Pad12_,
                  Net__1E2_Pad11_})
);

jt74161 u_1F1(
    .cl_b      ( _dma_DMclr_n             ) /* pin 1*/ ,
    .clk       ( Net__1B1_Pad6_           ) /* pin 2*/ ,
    .cep       ( Net__1D2_Pad6_           ) /* pin 7*/ ,
    .ld_b      ( 1'b1                     ) /* pin 9*/ ,
    .cet       ( Net__1D2_Pad6_           ) /* pin 10*/ ,
    .ca        ( Net__1F1_Pad15_          ) /* pin 15*/ ,
    .d         ({ Net__1F1_Pad6_,
                  Net__1F1_Pad5_,
                  Net__1F1_Pad4_,
                  Net__1F1_Pad3_}),
    .q         ({ Net__1F1_Pad11_,
                  Net__1F1_Pad12_,
                  Net__1F1_Pad13_,
                  Net__1F1_Pad14_})
);

ROM_2764 u_1F2(
    .CEn       ( 1'b0                     ) /* pin 20*/ ,
    .OEn       ( 1'b0                     ) /* pin 22*/ ,
    .P         ( 1'b1                     ) /* pin 27*/ ,
    .A         ({ DJ[16],
                  DJ[17],
                  DJ[10],
                  DJ[9],
                  DJ[8],
                  DJ[7],
                  DJ[6],
                  DJ[5],
                  DJ[4],
                  DJ[3],
                  DJ[2],
                  DJ[1],
                  _video2_DJEO}),
    .D         ({ Net__1F2_Pad19_,
                  Net__1F2_Pad18_,
                  Net__1F2_Pad17_,
                  Net__1F2_Pad16_,
                  Net__1F2_Pad15_,
                  Net__1F2_Pad13_,
                  Net__1F2_Pad12_,
                  Net__1F2_Pad11_})
);

ROM_2764 u_1J1(
    .CEn       ( 1'b0                     ) /* pin 20*/ ,
    .OEn       ( 1'b0                     ) /* pin 22*/ ,
    .P         ( 1'b1                     ) /* pin 27*/ ,
    .A         ({ DJ[16],
                  DJ[17],
                  DJ[10],
                  DJ[9],
                  DJ[8],
                  DJ[7],
                  DJ[6],
                  DJ[5],
                  DJ[4],
                  DJ[3],
                  DJ[2],
                  DJ[1],
                  _video2_DJEO}),
    .D         ({ Net__1J1_Pad19_,
                  Net__1J1_Pad18_,
                  Net__1J1_Pad17_,
                  Net__1J1_Pad16_,
                  Net__1J1_Pad15_,
                  Net__1J1_Pad13_,
                  Net__1J1_Pad12_,
                  Net__1J1_Pad11_})
);

ROM_2764 u_1K1(
    .CEn       ( 1'b0                     ) /* pin 20*/ ,
    .OEn       ( 1'b0                     ) /* pin 22*/ ,
    .P         ( 1'b1                     ) /* pin 27*/ ,
    .A         ({ DJ[16],
                  DJ[17],
                  DJ[10],
                  DJ[9],
                  DJ[8],
                  DJ[7],
                  DJ[6],
                  DJ[5],
                  DJ[4],
                  DJ[3],
                  DJ[2],
                  DJ[1],
                  _video2_DJEO}),
    .D         ({ Net__1K1_Pad19_,
                  Net__1K1_Pad18_,
                  Net__1K1_Pad17_,
                  Net__1K1_Pad16_,
                  Net__1K1_Pad15_,
                  Net__1K1_Pad13_,
                  Net__1K1_Pad12_,
                  Net__1K1_Pad11_})
);

jt7474 u_1L1(
    .cl1_b     ( Net__1L1_Pad1_           ) /* pin 1*/ ,
    .d1        ( 1'b1                     ) /* pin 2*/ ,
    .clk1      ( Net__1L1_Pad3_           ) /* pin 3*/ ,
    .pr1_b     ( 1'b1                     ) /* pin 4*/ ,
    .q1        ( _dma_BUSRQ               ) /* pin 5*/ ,
    .q1_b      ( BUSRQn                   ) /* pin 6*/ 
);

jt74174 u_1L2(
    .cl_b      ( 1'b1                     ) /* pin 1*/ ,
    .clk       ( _video1_DJ_latch_clk     ) /* pin 9*/ ,
    .d         ({ _video1_DJI[5],
                  _video1_DJI[4],
                  _video1_DJI[3],
                  _video1_DJI[2],
                  _video1_DJI[1],
                  _video1_DJI[0]}),
    .q         ({ DJ[5],
                  DJ[4],
                  DJ[3],
                  DJ[2],
                  DJ[1],
                  DJ[0]})
);

RAM_7063 u_1M2(
    .WEn       ( _video1_WEn0             ) /* pin 13*/ ,
    .CEn       ( _video1_CEn0             ) /* pin 15*/ ,
    .A         ({ _video1_ADR0[5],
                  _video1_ADR0[4],
                  _video1_ADR0[3],
                  _video1_ADR0[2],
                  _video1_ADR0[1],
                  _video1_ADR0[0]}),
    .I         ({ DO[20],
                  DO[19],
                  DO[18],
                  DO[17],
                  DO[16],
                  _video1_ROVIalt[2],
                  _video1_ROVIalt[1],
                  _video1_ROVIalt[0],
                  DO[27]}),
    .O         ({ _video1_DJI[8],
                  _video1_DJI[7],
                  _video1_DJI[6],
                  _video1_DJI[5],
                  _video1_DJI[4],
                  _video1_DJI[3],
                  _video1_DJI[2],
                  _video1_DJI[1],
                  _video1_DJI[0]})
);

RAM_7063 u_1P1(
    .WEn       ( _video1_WEn1             ) /* pin 13*/ ,
    .CEn       ( _video1_CEn1             ) /* pin 15*/ ,
    .A         ({ _video1_ADR1[5],
                  _video1_ADR1[4],
                  _video1_ADR1[3],
                  _video1_ADR1[2],
                  _video1_ADR1[1],
                  _video1_ADR1[0]}),
    .I         ({ DO[20],
                  DO[19],
                  DO[18],
                  DO[17],
                  DO[16],
                  _video1_ROVIalt[2],
                  _video1_ROVIalt[1],
                  _video1_ROVIalt[0],
                  DO[27]}),
    .O         ({ _video1_DJI[8],
                  _video1_DJI[7],
                  _video1_DJI[6],
                  _video1_DJI[5],
                  _video1_DJI[4],
                  _video1_DJI[3],
                  _video1_DJI[2],
                  _video1_DJI[1],
                  _video1_DJI[0]})
);

RAM_5501 u_1R1(
    .WEn       ( _dma_DMCSn[2]            ) /* pin 20*/ ,
    .A         ({ _dma_DM[7],
                  _dma_DM[6],
                  _dma_DM[5],
                  _dma_DM[4],
                  _dma_DM[3],
                  _dma_DM[2],
                  _dma_DM[1],
                  _dma_DM[0]}),
    .D         ({ DD[7],
                  DD[6],
                  DD[5],
                  DD[4]}),
    .Q         ({ DO[23],
                  DO[22],
                  DO[21],
                  DO[20]})
);

RAM_5501 u_1S1(
    .WEn       ( _dma_DMCSn[1]            ) /* pin 20*/ ,
    .A         ({ _dma_DM[7],
                  _dma_DM[6],
                  _dma_DM[5],
                  _dma_DM[4],
                  _dma_DM[3],
                  _dma_DM[2],
                  _dma_DM[1],
                  _dma_DM[0]}),
    .D         ({ DD[7],
                  DD[6],
                  DD[5],
                  DD[4]}),
    .Q         ({ DO[15],
                  DO[14],
                  DO[13],
                  DO[12]})
);

RAM_5501 u_1T1(
    .WEn       ( _dma_DMCSn[0]            ) /* pin 20*/ ,
    .A         ({ _dma_DM[7],
                  _dma_DM[6],
                  _dma_DM[5],
                  _dma_DM[4],
                  _dma_DM[3],
                  _dma_DM[2],
                  _dma_DM[1],
                  _dma_DM[0]}),
    .D         ({ DD[7],
                  DD[6],
                  DD[5],
                  DD[4]}),
    .Q         ({ DO[7],
                  DO[6],
                  DO[5],
                  DO[4]})
);

RAM_5501 u_1U1(
    .WEn       ( _dma_DMCSn[3]            ) /* pin 20*/ ,
    .A         ({ _dma_DM[7],
                  _dma_DM[6],
                  _dma_DM[5],
                  _dma_DM[4],
                  _dma_DM[3],
                  _dma_DM[2],
                  _dma_DM[1],
                  _dma_DM[0]}),
    .D         ({ DD[7],
                  DD[6],
                  DD[5],
                  DD[4]}),
    .Q         ({ Net__1U1_Pad16_,
                  Net__1U1_Pad14_,
                  Net__1U1_Pad12_,
                  DO[28]})
);

jt7486 u_2A1(
    .in1       ( _video1_RV               ) /* pin 1*/ ,
    .in2       ( Net__2A1_Pad10_          ) /* pin 2*/ ,
    .out3      ( Net__2A1_Pad3_           ) /* pin 3*/ ,
    .in4       ( ROVI[0]                  ) /* pin 4*/ ,
    .in5       ( Net__2A1_Pad10_          ) /* pin 5*/ ,
    .out6      ( _video1_ROVIalt[0]       ) /* pin 6*/ ,
    .out8      ( _video1_ROVIalt[1]       ) /* pin 8*/ ,
    .in9       ( ROVI[1]                  ) /* pin 9*/ ,
    .in10      ( Net__2A1_Pad10_          ) /* pin 10*/ ,
    .out11     ( _video1_ROVIalt[2]       ) /* pin 11*/ ,
    .in12      ( Net__2A1_Pad10_          ) /* pin 12*/ ,
    .in13      ( ROVI[2]                  ) /* pin 13*/ 
);

jt7408 u_2C1(
    .in1       ( Net__2C1_Pad1_           ) /* pin 1*/ ,
    .in2       ( DO[24]                   ) /* pin 2*/ ,
    .out3      ( Net__2C1_Pad3_           ) /* pin 3*/ ,
    .in4       ( Net__2C1_Pad1_           ) /* pin 4*/ ,
    .in5       ( DO[25]                   ) /* pin 5*/ ,
    .out6      ( Net__2C1_Pad6_           ) /* pin 6*/ ,
    .out8      ( Net__2C1_Pad8_           ) /* pin 8*/ ,
    .in9       ( Net__2C1_Pad1_           ) /* pin 9*/ ,
    .in10      ( DO[26]                   ) /* pin 10*/ ,
    .out11     ( _video1_H0H0or           ) /* pin 11*/ ,
    .in12      ( AIn                      ) /* pin 12*/ ,
    .in13      ( _video1_H0ln             ) /* pin 13*/ 
);

jt7408 u_2D1(
    .in1       ( V[0]                     ) /* pin 1*/ ,
    .in2       ( DO[24]                   ) /* pin 2*/ ,
    .out3      ( Net__2D1_Pad3_           ) /* pin 3*/ ,
    .in4       ( V[0]                     ) /* pin 4*/ ,
    .in5       ( DO[25]                   ) /* pin 5*/ ,
    .out6      ( Net__2D1_Pad6_           ) /* pin 6*/ ,
    .out8      ( Net__2D1_Pad8_           ) /* pin 8*/ ,
    .in9       ( V[0]                     ) /* pin 9*/ ,
    .in10      ( DO[26]                   ) /* pin 10*/ 
);

jt7474 u_2D2(
    .cl1_b     ( 1'b1                     ) /* pin 1*/ ,
    .d1        ( _dma_BI                  ) /* pin 2*/ ,
    .clk1      ( _dma_AI                  ) /* pin 3*/ ,
    .pr1_b     ( 1'b1                     ) /* pin 4*/ ,
    .q1        ( Net__1C1_Pad3_           ) /* pin 5*/ ,
    .q1_b      ( Net__2D2_Pad6_           ) /* pin 6*/ ,
    .q2_b      ( Net__1D2_Pad1_           ) /* pin 8*/ ,
    .q2        ( Net__1D2_Pad4_           ) /* pin 9*/ ,
    .pr2_b     ( 1'b1                     ) /* pin 10*/ ,
    .clk2      ( Net__1B1_Pad3_           ) /* pin 11*/ ,
    .d2        ( _dma_BUSAK               ) /* pin 12*/ ,
    .cl2_b     ( 1'b1                     ) /* pin 13*/ 
);

jt74161 u_2E1(
    .cl_b      ( _dma_DMclr_n             ) /* pin 1*/ ,
    .clk       ( Net__1B1_Pad6_           ) /* pin 2*/ ,
    .cep       ( 1'b1                     ) /* pin 7*/ ,
    .ld_b      ( 1'b1                     ) /* pin 9*/ ,
    .cet       ( Net__2E1_Pad10_          ) /* pin 10*/ ,
    .ca        ( Net__2E1_Pad15_          ) /* pin 15*/ ,
    .d         ({ Net__2E1_Pad6_,
                  Net__2E1_Pad5_,
                  Net__2E1_Pad4_,
                  Net__2E1_Pad3_}),
    .q         ({ Net__2E1_Pad11_,
                  _dma_DMEND,
                  Net__1E1_Pad2_,
                  Net__1E1_Pad1_})
);

jt74161 u_2F1(
    .cl_b      ( _dma_DMclr_n             ) /* pin 1*/ ,
    .clk       ( Net__1B1_Pad6_           ) /* pin 2*/ ,
    .cep       ( 1'b1                     ) /* pin 7*/ ,
    .ld_b      ( 1'b1                     ) /* pin 9*/ ,
    .cet       ( Net__1F1_Pad15_          ) /* pin 10*/ ,
    .ca        ( Net__2E1_Pad10_          ) /* pin 15*/ ,
    .d         ({ Net__2F1_Pad6_,
                  Net__2F1_Pad5_,
                  Net__2F1_Pad4_,
                  Net__2F1_Pad3_}),
    .q         ({ Net__2F1_Pad11_,
                  Net__2F1_Pad12_,
                  Net__2F1_Pad13_,
                  Net__2F1_Pad14_})
);

jt74367 u_2H1(
    .oe1_b     ( 1'b0                     ) /* pin 1*/ ,
    .oe2_b     ( 1'b0                     ) /* pin 15*/ ,
    .A         ({ Net__2F1_Pad14_,
                  Net__1F1_Pad13_,
                  Net__1F1_Pad11_,
                  Net__1F1_Pad14_,
                  Net__2F1_Pad13_,
                  Net__1F1_Pad12_}),
    .Y         ({ _dma_DM[4],
                  _dma_DM[1],
                  _dma_DM[3],
                  _dma_DM[0],
                  _dma_DM[5],
                  _dma_DM[2]})
);

jt7402 u_2K1(
    .out1      ( Net__1L1_Pad3_           ) /* pin 1*/ ,
    .in2       ( VBn                      ) /* pin 2*/ ,
    .in3       ( VBn                      ) /* pin 3*/ ,
    .out4      ( Net__1L1_Pad1_           ) /* pin 4*/ ,
    .in5       ( RESET                    ) /* pin 5*/ ,
    .in6       ( _dma_DMEND               ) /* pin 6*/ 
);

jt74174 u_2L1(
    .cl_b      ( 1'b1                     ) /* pin 1*/ ,
    .clk       ( _video1_DJ_latch_clk     ) /* pin 9*/ ,
    .d         ({ _video1_DJI[11],
                  _video1_DJI[10],
                  _video1_DJI[9],
                  _video1_DJI[8],
                  _video1_DJI[7],
                  _video1_DJI[6]}),
    .q         ({ DJ[11],
                  DJ[10],
                  DJ[9],
                  DJ[8],
                  DJ[7],
                  DJ[6]})
);

RAM_5501 u_2R1(
    .WEn       ( _dma_DMCSn[2]            ) /* pin 20*/ ,
    .A         ({ _dma_DM[7],
                  _dma_DM[6],
                  _dma_DM[5],
                  _dma_DM[4],
                  _dma_DM[3],
                  _dma_DM[2],
                  _dma_DM[1],
                  _dma_DM[0]}),
    .D         ({ DD[3],
                  DD[2],
                  DD[1],
                  DD[0]}),
    .Q         ({ DO[19],
                  DO[18],
                  DO[17],
                  DO[16]})
);

RAM_5501 u_2S1(
    .WEn       ( _dma_DMCSn[1]            ) /* pin 20*/ ,
    .A         ({ _dma_DM[7],
                  _dma_DM[6],
                  _dma_DM[5],
                  _dma_DM[4],
                  _dma_DM[3],
                  _dma_DM[2],
                  _dma_DM[1],
                  _dma_DM[0]}),
    .D         ({ DD[3],
                  DD[2],
                  DD[1],
                  DD[0]}),
    .Q         ({ DO[11],
                  DO[10],
                  DO[9],
                  DO[8]})
);

RAM_5501 u_2T1(
    .WEn       ( _dma_DMCSn[0]            ) /* pin 20*/ ,
    .A         ({ _dma_DM[7],
                  _dma_DM[6],
                  _dma_DM[5],
                  _dma_DM[4],
                  _dma_DM[3],
                  _dma_DM[2],
                  _dma_DM[1],
                  _dma_DM[0]}),
    .D         ({ DD[3],
                  DD[2],
                  DD[1],
                  DD[0]}),
    .Q         ({ DO[3],
                  DO[2],
                  DO[1],
                  DO[0]})
);

RAM_5501 u_2U1(
    .WEn       ( _dma_DMCSn[3]            ) /* pin 20*/ ,
    .A         ({ _dma_DM[7],
                  _dma_DM[6],
                  _dma_DM[5],
                  _dma_DM[4],
                  _dma_DM[3],
                  _dma_DM[2],
                  _dma_DM[1],
                  _dma_DM[0]}),
    .D         ({ DD[3],
                  DD[2],
                  DD[1],
                  DD[0]}),
    .Q         ({ DO[27],
                  DO[26],
                  DO[25],
                  DO[24]})
);

jt7400 u_3A1(
    .in1       ( Net__3A1_Pad1_           ) /* pin 1*/ ,
    .in2       ( _video1_HBn              ) /* pin 2*/ ,
    .out3      ( TXT_SHIFTn               ) /* pin 3*/ ,
    .out8      ( _video1_preWEx           ) /* pin 8*/ ,
    .in9       ( Net__3A1_Pad10_          ) /* pin 9*/ ,
    .in10      ( Net__3A1_Pad10_          ) /* pin 10*/ 
);

jt7400 u_3A2(
    .in1       ( H[0]                     ) /* pin 1*/ ,
    .in2       ( Net__3A2_Pad2_           ) /* pin 2*/ ,
    .out3      ( _video1_H0H0n            ) /* pin 3*/ 
);

jt74174 u_3C1(
    .cl_b      ( 1'b1                     ) /* pin 1*/ ,
    .clk       ( Net__3C1_Pad9_           ) /* pin 9*/ ,
    .d         ({ 1'b0,
                  1'b0,
                  DJ[11],
                  DJ[16],
                  DJ[15],
                  DJ[14]}),
    .q         ({ Net__3C1_Pad15_,
                  Net__3C1_Pad12_,
                  _video2_hflip,
                  Net__3C1_Pad7_,
                  Net__3C1_Pad5_,
                  Net__3C1_Pad2_})
);

jt7410 u_3D1(
    .Yc        ( Net__3D1_Pad8_           ) /* pin 8*/ ,
    .C         ({ Net__3D1_Pad11_,
                  Net__3D1_Pad10_,
                  Net__3D1_Pad9_})
);

jt74367 u_3E1(
    .oe1_b     ( _dma_DMCSpullup          ) /* pin 1*/ ,
    .oe2_b     ( _dma_DMCSpullup          ) /* pin 15*/ ,
    .A         ({ Net__1E1_Pad2_,
                  Net__2F1_Pad11_,
                  Net__1E1_Pad1_,
                  Net__1F1_Pad12_,
                  Net__1F1_Pad11_,
                  Net__1F1_Pad14_}),
    .Y         ({ AD[1],
                  AD[5],
                  AD[0],
                  AD[3],
                  AD[4],
                  AD[2]})
);

jt74377 u_3E2(
    .cen_b     ( 1'b0                     ) /* pin 1*/ ,
    .clk       ( _video2_ROMclk           ) /* pin 11*/ ,
    .D         ({ Net__1E2_Pad19_,
                  Net__1E2_Pad18_,
                  Net__1E2_Pad17_,
                  Net__1E2_Pad16_,
                  Net__1E2_Pad15_,
                  Net__1E2_Pad13_,
                  Net__1E2_Pad12_,
                  Net__1E2_Pad11_}),
    .Q         ({ Net__3E2_Pad19_,
                  Net__3E2_Pad16_,
                  Net__3E2_Pad15_,
                  Net__3E2_Pad12_,
                  Net__3E2_Pad9_,
                  Net__3E2_Pad6_,
                  Net__3E2_Pad5_,
                  Net__3E2_Pad2_})
);

jt74377 u_3F1(
    .cen_b     ( 1'b0                     ) /* pin 1*/ ,
    .clk       ( _video2_ROMclk           ) /* pin 11*/ ,
    .D         ({ Net__1F2_Pad19_,
                  Net__1F2_Pad18_,
                  Net__1F2_Pad17_,
                  Net__1F2_Pad16_,
                  Net__1F2_Pad15_,
                  Net__1F2_Pad13_,
                  Net__1F2_Pad12_,
                  Net__1F2_Pad11_}),
    .Q         ({ Net__3F1_Pad19_,
                  Net__3F1_Pad16_,
                  Net__3F1_Pad15_,
                  Net__3F1_Pad12_,
                  Net__3F1_Pad9_,
                  Net__3F1_Pad6_,
                  Net__3F1_Pad5_,
                  Net__3F1_Pad2_})
);

jt74367 u_3H1(
    .oe1_b     ( Net__3H1_Pad1_           ) /* pin 1*/ ,
    .oe2_b     ( 1'b0                     ) /* pin 15*/ ,
    .A         ({ Net__2F1_Pad11_,
                  Net__2F1_Pad12_,
                  Net__3H1_Pad10_,
                  Net__3H1_Pad6_,
                  Net__3H1_Pad4_,
                  Net__3H1_Pad2_}),
    .Y         ({ _dma_DM[7],
                  _dma_DM[6],
                  Net__3H1_Pad9_,
                  Net__3H1_Pad7_,
                  Net__3H1_Pad5_,
                  Net__3H1_Pad3_})
);

jt74377 u_3K1(
    .cen_b     ( 1'b0                     ) /* pin 1*/ ,
    .clk       ( _video2_ROMclk           ) /* pin 11*/ ,
    .D         ({ Net__1K1_Pad19_,
                  Net__1K1_Pad18_,
                  Net__1K1_Pad17_,
                  Net__1K1_Pad16_,
                  Net__1K1_Pad15_,
                  Net__1K1_Pad13_,
                  Net__1K1_Pad12_,
                  Net__1K1_Pad11_}),
    .Q         ({ Net__3K1_Pad19_,
                  Net__3K1_Pad16_,
                  Net__3K1_Pad15_,
                  Net__3K1_Pad12_,
                  Net__3K1_Pad9_,
                  Net__3K1_Pad6_,
                  Net__3K1_Pad5_,
                  Net__3K1_Pad2_})
);

jt74377 u_3K2(
    .cen_b     ( 1'b0                     ) /* pin 1*/ ,
    .clk       ( _video2_ROMclk           ) /* pin 11*/ ,
    .D         ({ Net__1J1_Pad19_,
                  Net__1J1_Pad18_,
                  Net__1J1_Pad17_,
                  Net__1J1_Pad16_,
                  Net__1J1_Pad15_,
                  Net__1J1_Pad13_,
                  Net__1J1_Pad12_,
                  Net__1J1_Pad11_}),
    .Q         ({ Net__3K2_Pad19_,
                  Net__3K2_Pad16_,
                  Net__3K2_Pad15_,
                  Net__3K2_Pad12_,
                  Net__3K2_Pad9_,
                  Net__3K2_Pad6_,
                  Net__3K2_Pad5_,
                  Net__3K2_Pad2_})
);

jt74174 u_3L1(
    .cl_b      ( 1'b1                     ) /* pin 1*/ ,
    .clk       ( _video1_DJ_latch_clk     ) /* pin 9*/ ,
    .d         ({ _video1_DJI[17],
                  _video1_DJI[16],
                  _video1_DJI[15],
                  _video1_DJI[14],
                  _video1_DJI[13],
                  _video1_DJI[12]}),
    .q         ({ DJ[17],
                  DJ[16],
                  DJ[15],
                  DJ[14],
                  DJ[13],
                  DJ[12]})
);

RAM_7063 u_3M2(
    .WEn       ( _video1_WEn0             ) /* pin 13*/ ,
    .CEn       ( _video1_CEn0             ) /* pin 15*/ ,
    .A         ({ _video1_ADR0[5],
                  _video1_ADR0[4],
                  _video1_ADR0[3],
                  _video1_ADR0[2],
                  _video1_ADR0[1],
                  _video1_ADR0[0]}),
    .I         ({ DO[28],
                  Net__2D1_Pad8_,
                  Net__2D1_Pad6_,
                  Net__2D1_Pad3_,
                  DO[1],
                  DO[0],
                  DO[23],
                  DO[22],
                  DO[21]}),
    .O         ({ _video1_DJI[17],
                  _video1_DJI[16],
                  _video1_DJI[15],
                  _video1_DJI[14],
                  _video1_DJI[13],
                  _video1_DJI[12],
                  _video1_DJI[11],
                  _video1_DJI[10],
                  _video1_DJI[9]})
);

RAM_7063 u_3P1(
    .WEn       ( _video1_WEn1             ) /* pin 13*/ ,
    .CEn       ( _video1_CEn1             ) /* pin 15*/ ,
    .A         ({ _video1_ADR1[5],
                  _video1_ADR1[4],
                  _video1_ADR1[3],
                  _video1_ADR1[2],
                  _video1_ADR1[1],
                  _video1_ADR1[0]}),
    .I         ({ DO[28],
                  Net__2C1_Pad8_,
                  Net__2C1_Pad6_,
                  Net__2C1_Pad3_,
                  DO[1],
                  DO[0],
                  DO[23],
                  DO[22],
                  DO[21]}),
    .O         ({ _video1_DJI[17],
                  _video1_DJI[16],
                  _video1_DJI[15],
                  _video1_DJI[14],
                  _video1_DJI[13],
                  _video1_DJI[12],
                  _video1_DJI[11],
                  _video1_DJI[10],
                  _video1_DJI[9]})
);

jt7411 u_4A1(
    .in1       ( H[2]                     ) /* pin 1*/ ,
    .in2       ( H[1]                     ) /* pin 2*/ ,
    .in3       ( _video1_HBn              ) /* pin 3*/ ,
    .in4       ( H[1]                     ) /* pin 4*/ ,
    .in5       ( _video1_H0H0n            ) /* pin 5*/ ,
    .out6      ( Net__3A1_Pad10_          ) /* pin 6*/ ,
    .out8      ( _video1_DJ_latch_clk     ) /* pin 8*/ ,
    .in9       ( _video1_H0ln             ) /* pin 9*/ ,
    .in10      ( H[0]                     ) /* pin 10*/ ,
    .in11      ( _video1_H1n              ) /* pin 11*/ ,
    .out12     ( Net__3A1_Pad1_           ) /* pin 12*/ ,
    .in13      ( H[0]                     ) /* pin 13*/ 
);

jt7474 u_4B1(
    .cl1_b     ( 1'b1                     ) /* pin 1*/ ,
    .d1        ( H[0]                     ) /* pin 2*/ ,
    .clk1      ( DOTCK                    ) /* pin 3*/ ,
    .pr1_b     ( 1'b1                     ) /* pin 4*/ ,
    .q1        ( Net__3A2_Pad2_           ) /* pin 5*/ ,
    .q1_b      ( _video1_H0ln             ) /* pin 6*/ ,
    .q2_b      ( TXTCL                    ) /* pin 8*/ ,
    .q2        ( Net__4B1_Pad9_           ) /* pin 9*/ ,
    .pr2_b     ( 1'b1                     ) /* pin 10*/ ,
    .clk2      ( DOTCK                    ) /* pin 11*/ ,
    .d2        ( TXT_SHIFTn               ) /* pin 12*/ ,
    .cl2_b     ( 1'b1                     ) /* pin 13*/ 
);

jt74175 u_4C1(
    .cl_b      ( 1'b1                     ) /* pin 1*/ ,
    .clk       ( Net__4C1_Pad9_           ) /* pin 9*/ ,
    .d         ({ Net__4C1_Pad13_,
                  Net__3C1_Pad7_,
                  Net__3C1_Pad5_,
                  Net__3C1_Pad2_}),
    .q         ({ Net__4C1_Pad15_,
                  Net__4C1_Pad10_,
                  Net__4C1_Pad7_,
                  Net__4C1_Pad2_}),
    .qn        ({ Net__4C1_Pad14_,
                  OBJC[2],
                  OBJC[1],
                  OBJC[0]})
);

jt7400 u_4D1(
    .in1       ( Net__4C1_Pad15_          ) /* pin 1*/ ,
    .in2       ( Net__4D1_Pad13_          ) /* pin 2*/ ,
    .out3      ( _video2_S[1]             ) /* pin 3*/ ,
    .in4       ( Net__4D1_Pad13_          ) /* pin 4*/ ,
    .in5       ( Net__4D1_Pad13_          ) /* pin 5*/ ,
    .out6      ( Net__4C1_Pad9_           ) /* pin 6*/ ,
    .out8      ( Net__4D1_Pad13_          ) /* pin 8*/ ,
    .in9       ( Net__4D1_Pad9_           ) /* pin 9*/ ,
    .in10      ( Net__4D1_Pad10_          ) /* pin 10*/ ,
    .out11     ( _video2_S[0]             ) /* pin 11*/ ,
    .in12      ( Net__4C1_Pad14_          ) /* pin 12*/ ,
    .in13      ( Net__4D1_Pad13_          ) /* pin 13*/ 
);

jt74365 u_4E1(
    .oe1_b     ( Net__1D2_Pad1_           ) /* pin 1*/ ,
    .oe2_b     ( _dma_DMEND               ) /* pin 15*/ ,
    .A         ({ 1'b0,
                  1'b0,
                  Net__1F1_Pad13_,
                  Net__2F1_Pad14_,
                  Net__2F1_Pad13_,
                  Net__2F1_Pad12_}),
    .Y         ({ _dma_DMCSpullup,
                  Net__4E1_Pad5_,
                  AD[6],
                  AD[7],
                  AD[8],
                  AD[9]})
);

jt74194 u_4E2(
    .cl_b      ( 1'b1                     ) /* pin 1*/ ,
    .R         ( Net__4E2_Pad2_           ) /* pin 2*/ ,
    .L         ( Net__4E2_Pad7_           ) /* pin 7*/ ,
    .clk       ( _video2_phi2             ) /* pin 11*/ ,
    .D         ({ Net__3E2_Pad2_,
                  Net__3E2_Pad5_,
                  Net__3E2_Pad6_,
                  Net__3E2_Pad9_}),
    .Q         ({ Net__4E2_Pad12_,
                  Net__4E2_Pad13_,
                  Net__4E2_Pad14_,
                  Net__4E2_Pad15_}),
    .S         ({ _video2_S[1],
                  _video2_S[0]})
);

jt74194 u_4F1(
    .cl_b      ( 1'b1                     ) /* pin 1*/ ,
    .R         ( Net__4F1_Pad2_           ) /* pin 2*/ ,
    .L         ( 1'b0                     ) /* pin 7*/ ,
    .clk       ( _video2_phi2             ) /* pin 11*/ ,
    .D         ({ Net__3F1_Pad2_,
                  Net__3F1_Pad5_,
                  Net__3F1_Pad6_,
                  Net__3F1_Pad9_}),
    .Q         ({ _video2_objv1_msb,
                  Net__4F1_Pad13_,
                  Net__4F1_Pad14_,
                  Net__4F1_Pad15_}),
    .S         ({ _video2_S[1],
                  _video2_S[0]})
);

jt74194 u_4H1(
    .cl_b      ( 1'b1                     ) /* pin 1*/ ,
    .R         ( Net__4E2_Pad12_          ) /* pin 2*/ ,
    .L         ( Net__4F1_Pad15_          ) /* pin 7*/ ,
    .clk       ( _video2_phi2             ) /* pin 11*/ ,
    .D         ({ Net__3F1_Pad12_,
                  Net__3F1_Pad15_,
                  Net__3F1_Pad16_,
                  Net__3F1_Pad19_}),
    .Q         ({ Net__4F1_Pad2_,
                  Net__4H1_Pad13_,
                  Net__4H1_Pad14_,
                  Net__4E2_Pad7_}),
    .S         ({ _video2_S[1],
                  _video2_S[0]})
);

jt74194 u_4J1(
    .cl_b      ( 1'b1                     ) /* pin 1*/ ,
    .R         ( Net__4J1_Pad2_           ) /* pin 2*/ ,
    .L         ( Net__4J1_Pad7_           ) /* pin 7*/ ,
    .clk       ( _video2_phi2             ) /* pin 11*/ ,
    .D         ({ Net__3K2_Pad2_,
                  Net__3K2_Pad5_,
                  Net__3K2_Pad6_,
                  Net__3K2_Pad9_}),
    .Q         ({ Net__4J1_Pad12_,
                  Net__4J1_Pad13_,
                  Net__4J1_Pad14_,
                  Net__4J1_Pad15_}),
    .S         ({ _video2_S[1],
                  _video2_S[0]})
);

jt74194 u_4K1(
    .cl_b      ( 1'b1                     ) /* pin 1*/ ,
    .R         ( Net__4K1_Pad2_           ) /* pin 2*/ ,
    .L         ( 1'b0                     ) /* pin 7*/ ,
    .clk       ( _video2_phi2             ) /* pin 11*/ ,
    .D         ({ Net__3K1_Pad2_,
                  Net__3K1_Pad5_,
                  Net__3K1_Pad6_,
                  Net__3K1_Pad9_}),
    .Q         ({ _video2_objv0_msb,
                  Net__4K1_Pad13_,
                  Net__4K1_Pad14_,
                  Net__4K1_Pad15_}),
    .S         ({ _video2_S[1],
                  _video2_S[0]})
);

jt74194 u_4L1(
    .cl_b      ( 1'b1                     ) /* pin 1*/ ,
    .R         ( Net__4J1_Pad12_          ) /* pin 2*/ ,
    .L         ( Net__4K1_Pad15_          ) /* pin 7*/ ,
    .clk       ( _video2_phi2             ) /* pin 11*/ ,
    .D         ({ Net__3K1_Pad12_,
                  Net__3K1_Pad15_,
                  Net__3K1_Pad16_,
                  Net__3K1_Pad19_}),
    .Q         ({ Net__4K1_Pad2_,
                  Net__4L1_Pad13_,
                  Net__4L1_Pad14_,
                  Net__4J1_Pad7_}),
    .S         ({ _video2_S[1],
                  _video2_S[0]})
);

jt74157 u_4M1(
    .S         ( V[0]                     ) /* pin 1*/ ,
    .Gn        ( 1'b0                     ) /* pin 15*/ ,
    .A         ({ H[5],
                  H[4],
                  H[3],
                  H2O}),
    .B         ({ DO[5],
                  DO[4],
                  DO[3],
                  DO[2]}),
    .Y         ({ _video1_ADR0[3],
                  _video1_ADR0[2],
                  _video1_ADR0[1],
                  _video1_ADR0[0]})
);

jt74157 u_4N1(
    .S         ( V[0]                     ) /* pin 1*/ ,
    .Gn        ( 1'b0                     ) /* pin 15*/ ,
    .A         ({ DO[7],
                  DO[6],
                  H[7],
                  H[6]}),
    .B         ({ H[7],
                  H[6],
                  DO[6],
                  DO[7]}),
    .Y         ({ _video1_ADR1[5],
                  _video1_ADR1[4],
                  _video1_ADR0[5],
                  _video1_ADR0[4]})
);

jt74157 u_4P1(
    .S         ( V[0]                     ) /* pin 1*/ ,
    .Gn        ( 1'b0                     ) /* pin 15*/ ,
    .A         ({ DO[5],
                  DO[4],
                  DO[3],
                  DO[2]}),
    .B         ({ H[5],
                  H[4],
                  H[3],
                  H2O}),
    .Y         ({ _video1_ADR1[3],
                  _video1_ADR1[2],
                  _video1_ADR1[1],
                  _video1_ADR1[0]})
);

jt74157 u_4P2(
    .S         ( V[0]                     ) /* pin 1*/ ,
    .Gn        ( 1'b0                     ) /* pin 15*/ ,
    .A         ({ _video1_preWEy,
                  _video1_preWEx,
                  _video1_DJ_CEn,
                  1'b0}),
    .B         ({ _video1_preWEx,
                  _video1_preWEy,
                  1'b0,
                  _video1_DJ_CEn}),
    .Y         ({ _video1_WEn1,
                  _video1_WEn0,
                  _video1_CEn1,
                  _video1_CEn0})
);

jt7404 u_5A1(
    .in1       ( H[0]                     ) /* pin 1*/ ,
    .out2      ( AIn                      ) /* pin 2*/ ,
    .in5       ( HB                       ) /* pin 5*/ ,
    .out6      ( _video1_HBn              ) /* pin 6*/ ,
    .out8      ( Net__2C1_Pad1_           ) /* pin 8*/ ,
    .in9       ( V[0]                     ) /* pin 9*/ ,
    .out10     ( BIn                      ) /* pin 10*/ ,
    .in11      ( H[1]                     ) /* pin 11*/ ,
    .out12     ( _video1_H1n              ) /* pin 12*/ ,
    .in13      ( H[1]                     ) /* pin 13*/ 
);

jt7486 u_5D1(
    .in1       ( _video2_hflip            ) /* pin 1*/ ,
    .in2       ( _video2_RV               ) /* pin 2*/ ,
    .out3      ( Net__4C1_Pad13_          ) /* pin 3*/ ,
    .in4       ( INIT_EOn                 ) /* pin 4*/ ,
    .in5       ( DJ[0]                    ) /* pin 5*/ ,
    .out6      ( _video2_DJEO             ) /* pin 6*/ ,
    .out8      ( _video2_objcnt_start[0]  ) /* pin 8*/ ,
    .in9       ( DJ[12]                   ) /* pin 9*/ ,
    .in10      ( _video2_RV               ) /* pin 10*/ ,
    .out11     ( _video2_objcnt_start[1]  ) /* pin 11*/ ,
    .in12      ( DJ[13]                   ) /* pin 12*/ ,
    .in13      ( _video2_RV               ) /* pin 13*/ 
);

jt74194 u_5F1(
    .cl_b      ( 1'b1                     ) /* pin 1*/ ,
    .R         ( 1'b0                     ) /* pin 2*/ ,
    .L         ( Net__4E2_Pad15_          ) /* pin 7*/ ,
    .clk       ( _video2_phi2             ) /* pin 11*/ ,
    .D         ({ Net__3E2_Pad12_,
                  Net__3E2_Pad15_,
                  Net__3E2_Pad16_,
                  Net__3E2_Pad19_}),
    .Q         ({ Net__4E2_Pad2_,
                  Net__5F1_Pad13_,
                  Net__5F1_Pad14_,
                  _video2_objv1_lsb}),
    .S         ({ _video2_S[1],
                  _video2_S[0]})
);

jt7437 u_5H1(
    .in1       ( BUSAK_n                  ) /* pin 1*/ ,
    .in2       ( BUSAK_n                  ) /* pin 2*/ ,
    .out3      ( _dma_BUSAK               ) /* pin 3*/ 
);

jt74157 u_5J1(
    .S         ( Net__5J1_Pad1_           ) /* pin 1*/ ,
    .Gn        ( VB                       ) /* pin 15*/ ,
    .A         ({ 1'b0,
                  1'b0,
                  _video2_objv1_msb,
                  _video2_objv0_msb}),
    .B         ({ 1'b0,
                  1'b0,
                  _video2_objv1_lsb,
                  _video2_objv0_lsb}),
    .Y         ({ Net__5J1_Pad12_,
                  Net__5J1_Pad9_,
                  OBJV[1],
                  OBJV[0]})
);

jt74194 u_5K1(
    .cl_b      ( 1'b1                     ) /* pin 1*/ ,
    .R         ( 1'b0                     ) /* pin 2*/ ,
    .L         ( Net__4J1_Pad15_          ) /* pin 7*/ ,
    .clk       ( _video2_phi2             ) /* pin 11*/ ,
    .D         ({ Net__3K2_Pad12_,
                  Net__3K2_Pad15_,
                  Net__3K2_Pad16_,
                  Net__3K2_Pad19_}),
    .Q         ({ Net__4J1_Pad2_,
                  Net__5K1_Pad13_,
                  Net__5K1_Pad14_,
                  _video2_objv0_lsb}),
    .S         ({ _video2_S[1],
                  _video2_S[0]})
);

jt7404 u_5L1(
    .in1       ( ROHVCK                   ) /* pin 1*/ ,
    .out2      ( Net__5L1_Pad2_           ) /* pin 2*/ ,
    .in3       ( Net__5L1_Pad2_           ) /* pin 3*/ ,
    .out4      ( Net__2A1_Pad10_          ) /* pin 4*/ ,
    .out8      ( Net__5L1_Pad8_           ) /* pin 8*/ ,
    .in9       ( ROHVCK                   ) /* pin 9*/ ,
    .out12     ( _video1_RV               ) /* pin 12*/ ,
    .in13      ( RVn                      ) /* pin 13*/ 
);

jt7404 u_5U1(
    .in1       ( AD[5]                    ) /* pin 1*/ ,
    .out2      ( _video3_ADx[5]           ) /* pin 2*/ ,
    .in3       ( AD[0]                    ) /* pin 3*/ ,
    .out4      ( _video3_ADx[0]           ) /* pin 4*/ ,
    .in5       ( AD[3]                    ) /* pin 5*/ ,
    .out6      ( _video3_ADx[3]           ) /* pin 6*/ ,
    .out8      ( _video3_ADx[4]           ) /* pin 8*/ ,
    .in9       ( AD[4]                    ) /* pin 9*/ ,
    .out10     ( _video3_ADx[1]           ) /* pin 10*/ ,
    .in11      ( AD[1]                    ) /* pin 11*/ ,
    .out12     ( _video3_ADx[2]           ) /* pin 12*/ ,
    .in13      ( AD[2]                    ) /* pin 13*/ 
);

jt7402 u_6C1(
    .out1      ( DMCS                     ) /* pin 1*/ ,
    .in2       ( _dma_DMCSpullup          ) /* pin 2*/ ,
    .in3       ( _dma_DMCSpullup          ) /* pin 3*/ 
);

jt74368 u_6C2(
    .oe_n1     ( 1'b0                     ) /* pin 1*/ ,
    .oe_n2     ( 1'b0                     ) /* pin 15*/ ,
    .A         ({ Net__6C2_Pad10_,
                  Net__6C2_Pad5_,
                  Net__6C2_Pad3_,
                  Net__4D1_Pad10_}),
    .B         ({ Net__6C2_Pad14_,
                  Net__3D1_Pad9_}),
    .Ya        ({ Net__6C2_Pad9_,
                  DOTCK,
                  Net__6C2_Pad5_,
                  Net__6C2_Pad3_}),
    .Yb        ({ Net__6C2_Pad13_,
                  _video2_objcnt_clk})
);

jt74367 u_6D1(
    .oe1_b     ( 1'b0                     ) /* pin 1*/ ,
    .oe2_b     ( 1'b0                     ) /* pin 15*/ ,
    .A         ({ Net__6D1_Pad14_,
                  Net__3D1_Pad11_,
                  Net__3D1_Pad10_,
                  Net__3D1_Pad9_,
                  Net__3D1_Pad8_,
                  Net__6D1_Pad2_}),
    .Y         ({ H[2],
                  H[1],
                  H[0],
                  Net__4D1_Pad10_,
                  _video2_ROMclk,
                  Net__6D1_Pad3_})
);

jt74161 u_6E1(
    .cl_b      ( 1'b1                     ) /* pin 1*/ ,
    .clk       ( Net__3D1_Pad9_           ) /* pin 2*/ ,
    .cep       ( 1'b1                     ) /* pin 7*/ ,
    .ld_b      ( 1'b1                     ) /* pin 9*/ ,
    .cet       ( 1'b1                     ) /* pin 10*/ ,
    .ca        ( Net__6E1_Pad15_          ) /* pin 15*/ ,
    .d         ({ Net__6E1_Pad6_,
                  Net__6E1_Pad5_,
                  Net__6E1_Pad4_,
                  Net__6E1_Pad3_}),
    .q         ({ Net__6E1_Pad11_,
                  Net__6D1_Pad14_,
                  Net__3D1_Pad11_,
                  Net__3D1_Pad10_})
);

jt7486 u_6F1(
    .in1       ( RVn                      ) /* pin 1*/ ,
    .in2       ( 1'b1                     ) /* pin 2*/ ,
    .out3      ( _video2_RVx              ) /* pin 3*/ ,
    .in4       ( Net__6E1_Pad11_          ) /* pin 4*/ ,
    .in5       ( _video2_RVx              ) /* pin 5*/ ,
    .out6      ( H[3]                     ) /* pin 6*/ ,
    .out8      ( H2O                      ) /* pin 8*/ ,
    .in9       ( Net__6D1_Pad14_          ) /* pin 9*/ ,
    .in10      ( _video2_RVx              ) /* pin 10*/ 
);

jt7404 u_6T1(
    .in1       ( _video3_AT[11]           ) /* pin 1*/ ,
    .out2      ( _video3_AT11n            ) /* pin 2*/ ,
    .in3       ( DWRBKn                   ) /* pin 3*/ ,
    .out4      ( Net__6T1_Pad4_           ) /* pin 4*/ ,
    .in5       ( Net__6T1_Pad4_           ) /* pin 5*/ ,
    .out6      ( Net__6T1_Pad6_           ) /* pin 6*/ ,
    .out8      ( Net__6T1_Pad8_           ) /* pin 8*/ ,
    .in9       ( ROVI[8]                  ) /* pin 9*/ ,
    .out10     ( Net__6T1_Pad10_          ) /* pin 10*/ ,
    .in11      ( AD[1]                    ) /* pin 11*/ 
);

jt74157 u_6U1(
    .S         ( CSBWn                    ) /* pin 1*/ ,
    .Gn        ( 1'b0                     ) /* pin 15*/ ,
    .A         ({ Net__6U1_Pad14_,
                  Net__6U1_Pad11_,
                  Net__6T1_Pad10_,
                  MEMWR0}),
    .B         ({ Net__6U1_Pad13_,
                  Net__6U1_Pad10_,
                  _video3_ROV[7],
                  Net__6U1_Pad3_}),
    .Y         ({ Net__6U1_Pad12_,
                  Net__6U1_Pad9_,
                  Net__6U1_Pad7_,
                  _video3_BAKCK})
);

jt7404 u_7D1(
    .out8      ( _video2_phi2             ) /* pin 8*/ ,
    .in9       ( Net__7D1_Pad10_          ) /* pin 9*/ ,
    .out10     ( Net__7D1_Pad10_          ) /* pin 10*/ ,
    .in11      ( Net__7D1_Pad11_          ) /* pin 11*/ 
);

jt74161 u_7E1(
    .cl_b      ( 1'b1                     ) /* pin 1*/ ,
    .clk       ( 1'b1                     ) /* pin 2*/ ,
    .cep       ( CLK20                    ) /* pin 7*/ ,
    .ld_b      ( 1'b1                     ) /* pin 9*/ ,
    .cet       ( 1'b1                     ) /* pin 10*/ ,
    .ca        ( Net__7E1_Pad15_          ) /* pin 15*/ ,
    .d         ({ Net__7E1_Pad6_,
                  Net__7E1_Pad5_,
                  Net__7E1_Pad4_,
                  Net__7E1_Pad3_}),
    .q         ({ Net__7E1_Pad11_,
                  Net__7E1_Pad12_,
                  Net__3D1_Pad9_,
                  Net__7D1_Pad11_})
);

jt7486 u_7K1(
    .in1       ( Net__7K1_Pad1_           ) /* pin 1*/ ,
    .in2       ( _video2_RVx              ) /* pin 2*/ ,
    .out3      ( H[7]                     ) /* pin 3*/ ,
    .in4       ( Net__7K1_Pad4_           ) /* pin 4*/ ,
    .in5       ( _video2_RVx              ) /* pin 5*/ ,
    .out6      ( H[5]                     ) /* pin 6*/ ,
    .out8      ( H[4]                     ) /* pin 8*/ ,
    .in9       ( Net__7K1_Pad9_           ) /* pin 9*/ ,
    .in10      ( _video2_RVx              ) /* pin 10*/ ,
    .out11     ( H[6]                     ) /* pin 11*/ ,
    .in12      ( Net__7K1_Pad12_          ) /* pin 12*/ ,
    .in13      ( _video2_RVx              ) /* pin 13*/ 
);

jt7400 u_7L1(
    .out11     ( Net__7L1_Pad11_          ) /* pin 11*/ ,
    .in12      ( _video3_ROH[1]           ) /* pin 12*/ ,
    .in13      ( _video3_ROH[0]           ) /* pin 13*/ 
);

jt74161 u_7M1(
    .cl_b      ( 1'b1                     ) /* pin 1*/ ,
    .clk       ( DOTCK                    ) /* pin 2*/ ,
    .cep       ( 1'b1                     ) /* pin 7*/ ,
    .ld_b      ( ROHVCK                   ) /* pin 9*/ ,
    .cet       ( Net__7M1_Pad10_          ) /* pin 10*/ ,
    .ca        ( Net__7M1_Pad15_          ) /* pin 15*/ ,
    .d         ({ DO[7],
                  DO[6],
                  DO[5],
                  DO[4]}),
    .q         ({ _video3_ROH[7],
                  _video3_ROH[6],
                  _video3_ROH[5],
                  _video3_ROH[4]})
);

jt74161 u_7N1(
    .cl_b      ( 1'b1                     ) /* pin 1*/ ,
    .clk       ( DOTCK                    ) /* pin 2*/ ,
    .cep       ( 1'b1                     ) /* pin 7*/ ,
    .ld_b      ( ROHVCK                   ) /* pin 9*/ ,
    .cet       ( 1'b1                     ) /* pin 10*/ ,
    .ca        ( Net__7M1_Pad10_          ) /* pin 15*/ ,
    .d         ({ DO[3],
                  DO[2],
                  DO[1],
                  DO[0]}),
    .q         ({ _video3_ROH[3],
                  _video3_ROH[2],
                  _video3_ROH[1],
                  _video3_ROH[0]})
);

jt74157 u_7P1(
    .S         ( CSBWn                    ) /* pin 1*/ ,
    .Gn        ( _video3_ROV[8]           ) /* pin 15*/ ,
    .A         ({ AD[6],
                  _video3_ADx[2],
                  _video3_ADx[1],
                  _video3_ADx[0]}),
    .B         ({ _video3_ROH[5],
                  _video3_ROH[4],
                  _video3_ROH[3],
                  _video3_ROH[2]}),
    .Y         ({ _video3_AT[3],
                  _video3_AT[2],
                  _video3_AT[1],
                  _video3_AT[0]})
);

jt74157 u_7R1(
    .S         ( CSBWn                    ) /* pin 1*/ ,
    .Gn        ( _video3_ROV[8]           ) /* pin 15*/ ,
    .A         ({ AD[8],
                  AD[7],
                  _video3_ADx[4],
                  _video3_ADx[3]}),
    .B         ({ _video3_ROV[2],
                  _video3_ROV[1],
                  _video3_ROH[7],
                  _video3_ROH[6]}),
    .Y         ({ _video3_AT[7],
                  _video3_AT[6],
                  _video3_AT[5],
                  _video3_AT[4]})
);

jt74157 u_7S1(
    .S         ( CSBWn                    ) /* pin 1*/ ,
    .Gn        ( _video3_ROV[8]           ) /* pin 15*/ ,
    .A         ({ AD[11],
                  AD[10],
                  _video3_ADx[5],
                  AD[9]}),
    .B         ({ _video3_ROV[6],
                  _video3_ROV[5],
                  _video3_ROV[4],
                  _video3_ROV[3]}),
    .Y         ({ _video3_AT[11],
                  _video3_AT[10],
                  _video3_AT[9],
                  _video3_AT[8]})
);

jt74257 u_7T1(
    .sel       ( Net__6T1_Pad10_          ) /* pin 1*/ ,
    .en_b      ( Net__6T1_Pad6_           ) /* pin 15*/ ,
    .a         ({ BAKC[3],
                  BAKC[2],
                  BAKC[1],
                  BAKC[0]}),
    .b         ({ DD[3],
                  DD[2],
                  DD[1],
                  DD[0]}),
    .y         ({ _video3_BK[3],
                  _video3_BK[2],
                  _video3_BK[1],
                  _video3_BK[0]})
);

jt74257 u_7U1(
    .sel       ( Net__6T1_Pad10_          ) /* pin 1*/ ,
    .en_b      ( Net__6T1_Pad6_           ) /* pin 15*/ ,
    .a         ({ DD[3],
                  DD[2],
                  DD[1],
                  DD[0]}),
    .b         ({ BAKC[3],
                  BAKC[2],
                  BAKC[1],
                  BAKC[0]}),
    .y         ({ _video3_BK[7],
                  _video3_BK[6],
                  _video3_BK[5],
                  _video3_BK[4]})
);

jt7474 u_8B1(
    .cl1_b     ( 1'b1                     ) /* pin 1*/ ,
    .d1        ( Net__8B1_Pad2_           ) /* pin 2*/ ,
    .clk1      ( Net__8B1_Pad3_           ) /* pin 3*/ ,
    .pr1_b     ( 1'b1                     ) /* pin 4*/ ,
    .q1        ( Net__8B1_Pad12_          ) /* pin 5*/ ,
    .q1_b      ( Net__8B1_Pad2_           ) /* pin 6*/ ,
    .q2_b      ( _video2_HBn              ) /* pin 8*/ ,
    .q2        ( HB                       ) /* pin 9*/ ,
    .pr2_b     ( 1'b1                     ) /* pin 10*/ ,
    .clk2      ( Net__3D1_Pad9_           ) /* pin 11*/ ,
    .d2        ( Net__8B1_Pad12_          ) /* pin 12*/ ,
    .cl2_b     ( 1'b1                     ) /* pin 13*/ 
);

jt7486 u_8C1(
    .in1       ( 1'b1                     ) /* pin 1*/ ,
    .in2       ( Net__8C1_Pad2_           ) /* pin 2*/ ,
    .out3      ( Net__8C1_Pad12_          ) /* pin 3*/ ,
    .in4       ( 1'b0                     ) /* pin 4*/ ,
    .in5       ( _video2_RVx              ) /* pin 5*/ ,
    .out6      ( _video2_RV               ) /* pin 6*/ ,
    .out11     ( Net__8B1_Pad3_           ) /* pin 11*/ ,
    .in12      ( Net__8C1_Pad12_          ) /* pin 12*/ ,
    .in13      ( 1'b1                     ) /* pin 13*/ 
);

jt74161 u_8H1(
    .cl_b      ( 1'b1                     ) /* pin 1*/ ,
    .clk       ( Net__3D1_Pad9_           ) /* pin 2*/ ,
    .cep       ( 1'b1                     ) /* pin 7*/ ,
    .ld_b      ( Net__8H1_Pad9_           ) /* pin 9*/ ,
    .cet       ( Net__6E1_Pad15_          ) /* pin 10*/ ,
    .ca        ( Net__8C1_Pad2_           ) /* pin 15*/ ,
    .d         ({ Net__8B1_Pad12_,
                  Net__8B1_Pad12_,
                  1'b0,
                  1'b0}),
    .q         ({ Net__7K1_Pad1_,
                  Net__7K1_Pad12_,
                  Net__7K1_Pad4_,
                  Net__7K1_Pad9_})
);

jt7404 u_8L1(
    .in1       ( _video1_H0H0n            ) /* pin 1*/ ,
    .out2      ( Net__8L1_Pad2_           ) /* pin 2*/ 
);

jt7404 u_8L2(
    .in1       ( Net__8L1_Pad2_           ) /* pin 1*/ ,
    .out2      ( Net__8L2_Pad2_           ) /* pin 2*/ 
);

jt7404 u_8L3(
    .in1       ( Net__8L2_Pad2_           ) /* pin 1*/ ,
    .out2      ( Net__8L3_Pad2_           ) /* pin 2*/ 
);

jt7404 u_8L4(
    .in1       ( Net__8L3_Pad2_           ) /* pin 1*/ ,
    .out2      ( Net__8L4_Pad2_           ) /* pin 2*/ 
);

jt7404 u_8L5(
    .in1       ( Net__8L4_Pad2_           ) /* pin 1*/ ,
    .out2      ( Net__8L5_Pad2_           ) /* pin 2*/ 
);

jt7404 u_8L6(
    .in1       ( Net__8L5_Pad2_           ) /* pin 1*/ ,
    .out2      ( _video1_preWEy           ) /* pin 2*/ 
);

RAM_2016 u_8P1(
    .CEn       ( _video3_AT11n            ) /* pin 18*/ ,
    .WEn       ( DWRBKn                   ) /* pin 21*/ ,
    .A         ({ _video3_AT[10],
                  _video3_AT[9],
                  _video3_AT[8],
                  _video3_AT[7],
                  _video3_AT[6],
                  _video3_AT[5],
                  _video3_AT[4],
                  _video3_AT[3],
                  _video3_AT[2],
                  _video3_AT[1],
                  _video3_AT[0]}),
    .D         ({ _video3_BK[7],
                  _video3_BK[6],
                  _video3_BK[5],
                  _video3_BK[4],
                  _video3_BK[3],
                  _video3_BK[2],
                  _video3_BK[1],
                  _video3_BK[0]})
);

RAM_2016 u_8S1(
    .CEn       ( _video3_AT[11]           ) /* pin 18*/ ,
    .WEn       ( DWRBKn                   ) /* pin 21*/ ,
    .A         ({ _video3_AT[10],
                  _video3_AT[9],
                  _video3_AT[8],
                  _video3_AT[7],
                  _video3_AT[6],
                  _video3_AT[5],
                  _video3_AT[4],
                  _video3_AT[3],
                  _video3_AT[2],
                  _video3_AT[1],
                  _video3_AT[0]}),
    .D         ({ _video3_BK[7],
                  _video3_BK[6],
                  _video3_BK[5],
                  _video3_BK[4],
                  _video3_BK[3],
                  _video3_BK[2],
                  _video3_BK[1],
                  _video3_BK[0]})
);

jt74157 u_8T1(
    .S         ( Net__6U1_Pad7_           ) /* pin 1*/ ,
    .Gn        ( 1'b0                     ) /* pin 15*/ ,
    .A         ({ _video3_BK[3],
                  _video3_BK[2],
                  _video3_BK[1],
                  _video3_BK[0]}),
    .B         ({ _video3_BK[7],
                  _video3_BK[6],
                  _video3_BK[5],
                  _video3_BK[4]}),
    .Y         ({ Net__8T1_Pad12_,
                  Net__8T1_Pad9_,
                  Net__8T1_Pad7_,
                  Net__8T1_Pad4_})
);

jt74174 u_8U1(
    .cl_b      ( 1'b1                     ) /* pin 1*/ ,
    .clk       ( _video3_BAKCK            ) /* pin 9*/ ,
    .d         ({ 1'b0,
                  1'b0,
                  Net__8T1_Pad12_,
                  Net__8T1_Pad9_,
                  Net__8T1_Pad7_,
                  Net__8T1_Pad4_}),
    .q         ({ Net__8U1_Pad15_,
                  Net__8U1_Pad12_,
                  BAKC[3],
                  BAKC[2],
                  BAKC[1],
                  BAKC[0]})
);

jt7410 U1(
    .Yb        ( _video2_objcnt_start[3]  ) /* pin 6*/ ,
    .B         ({ DJ[14],
                  DJ[15],
                  DJ[16]})
);

jt74161 U2(
    .cl_b      ( Net__U2_Pad1_            ) /* pin 1*/ ,
    .clk       ( _video2_objcnt_clk       ) /* pin 2*/ ,
    .cep       ( 1'b1                     ) /* pin 7*/ ,
    .ld_b      ( Net__U2_Pad9_            ) /* pin 9*/ ,
    .cet       ( 1'b1                     ) /* pin 10*/ ,
    .ca        ( Net__4D1_Pad9_           ) /* pin 15*/ ,
    .d         ({ _video2_objcnt_start[3],
                  _video2_objcnt_start[2],
                  _video2_objcnt_start[1],
                  _video2_objcnt_start[0]}),
    .q         ({ Net__U2_Pad11_,
                  Net__U2_Pad12_,
                  Net__U2_Pad13_,
                  Net__U2_Pad14_})
);

jt74283 U3R1(
    .cin       ( _video1_v_halfcarry      ) /* pin 7*/ ,
    .cout      ( ROVI[8]                  ) /* pin 9*/ ,
    .a         ({ DO[15],
                  DO[14],
                  DO[13],
                  DO[12]}),
    .b         ({ V[7],
                  V[6],
                  V[5],
                  V[4]}),
    .s         ({ ROVI[7],
                  ROVI[6],
                  ROVI[5],
                  ROVI[4]})
);

jt74283 U3S1(
    .cin       ( Net__2A1_Pad3_           ) /* pin 7*/ ,
    .cout      ( _video1_v_halfcarry      ) /* pin 9*/ ,
    .a         ({ DO[11],
                  DO[10],
                  DO[9],
                  DO[8]}),
    .b         ({ V[3],
                  V[2],
                  V[1],
                  V[0]}),
    .s         ({ ROVI[3],
                  ROVI[2],
                  ROVI[1],
                  ROVI[0]})
);

jt74283 U3T1(
    .cin       ( ROVI[3]                  ) /* pin 7*/ ,
    .cout      ( _video1_carry            ) /* pin 9*/ ,
    .a         ({ ROVI[7],
                  ROVI[6],
                  ROVI[5],
                  ROVI[4]}),
    .b         ({ 1'b1,
                  1'b1,
                  1'b1,
                  1'b1}),
    .s         ({ Net__U3T1_Pad10_,
                  Net__U3T1_Pad13_,
                  Net__U3T1_Pad1_,
                  Net__U3T1_Pad4_})
);

jt74273 U8(
    .cl_b      ( CSBWn                    ) /* pin 1*/ ,
    .clk       ( ROHVCK                   ) /* pin 11*/ ,
    .d         ({ Net__6T1_Pad8_,
                  ROVI[7],
                  ROVI[6],
                  ROVI[5],
                  ROVI[4],
                  ROVI[3],
                  ROVI[2],
                  ROVI[1]}),
    .q         ({ _video3_ROV[8],
                  _video3_ROV[7],
                  _video3_ROV[6],
                  _video3_ROV[5],
                  _video3_ROV[4],
                  _video3_ROV[3],
                  _video3_ROV[2],
                  _video3_ROV[1]})
);

jt7474 U9(
    .cl1_b     ( 1'b1                     ) /* pin 1*/ ,
    .d1        ( Net__7L1_Pad11_          ) /* pin 2*/ ,
    .clk1      ( Net__5L1_Pad8_           ) /* pin 3*/ ,
    .pr1_b     ( 1'b1                     ) /* pin 4*/ ,
    .q1        ( Net__U9_Pad5_            ) /* pin 5*/ ,
    .q1_b      ( Net__6U1_Pad3_           ) /* pin 6*/ 
);

rpullup pu1(
    .x         ( _video1_DJI[9]           ) /* pin 1*/ 
);

rpullup pu10(
    .x         ( _video1_DJI[0]           ) /* pin 1*/ 
);

rpullup pu11(
    .x         ( _video1_DJI[1]           ) /* pin 1*/ 
);

rpullup pu12(
    .x         ( _video1_DJI[2]           ) /* pin 1*/ 
);

rpullup pu13(
    .x         ( _video1_DJI[3]           ) /* pin 1*/ 
);

rpullup pu14(
    .x         ( _video1_DJI[4]           ) /* pin 1*/ 
);

rpullup pu15(
    .x         ( _video1_DJI[5]           ) /* pin 1*/ 
);

rpullup pu16(
    .x         ( _video1_DJI[6]           ) /* pin 1*/ 
);

rpullup pu17(
    .x         ( _video1_DJI[7]           ) /* pin 1*/ 
);

rpullup pu18(
    .x         ( _video1_DJI[8]           ) /* pin 1*/ 
);

rpullup pu19(
    .x         ( _dma_DMCSpullup          ) /* pin 1*/ 
);

rpullup pu2(
    .x         ( _video1_DJI[10]          ) /* pin 1*/ 
);

rpullup pu20(
    .x         ( _video2_objcnt_start[2]  ) /* pin 1*/ 
);

rpullup pu3(
    .x         ( _video1_DJI[11]          ) /* pin 1*/ 
);

rpullup pu4(
    .x         ( _video1_DJI[12]          ) /* pin 1*/ 
);

rpullup pu5(
    .x         ( _video1_DJI[13]          ) /* pin 1*/ 
);

rpullup pu6(
    .x         ( _video1_DJI[14]          ) /* pin 1*/ 
);

rpullup pu7(
    .x         ( _video1_DJI[15]          ) /* pin 1*/ 
);

rpullup pu8(
    .x         ( _video1_DJI[16]          ) /* pin 1*/ 
);

rpullup pu9(
    .x         ( _video1_DJI[17]          ) /* pin 1*/ 
);

