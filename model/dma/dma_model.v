jt7432 u_1D1(
    .out8      ( Net__1D1_Pad8_           ) /* pin 8*/ ,
    .in9       ( Net__1D1_Pad9_           ) /* pin 9*/ ,
    .in10      ( Net__1D1_Pad10_          ) /* pin 10*/ ,
    .out11     ( Net__1D1_Pad10_          ) /* pin 11*/ ,
    .in12      ( Net__1D1_Pad12_          ) /* pin 12*/ ,
    .in13      ( ROHVS                    ) /* pin 13*/ 
);

RAM_7063 u_1M1(
    .WEn       ( video1_WEn1              ) /* pin 13*/ ,
    .CEn       ( video1_CEn1              ) /* pin 15*/ ,
    .A         ({ Net__1M1_Pad3_,
                  Net__1M1_Pad2_,
                  Net__1M1_Pad1_,
                  Net__1M1_Pad27_,
                  Net__1M1_Pad26_,
                  Net__1M1_Pad25_}),
    .I         ({ DO[20],
                  DO[19],
                  DO[18],
                  DO[17],
                  DO[16],
                  video1_ROVIalt[2],
                  video1_ROVIalt[1],
                  video1_ROVIalt[0],
                  DO[27]}),
    .O         ({ video1_DJI[8],
                  video1_DJI[7],
                  video1_DJI[6],
                  video1_DJI[5],
                  video1_DJI[4],
                  video1_DJI[3],
                  video1_DJI[2],
                  video1_DJI[1],
                  video1_DJI[0]})
);

RAM_7063 u_1M2(
    .WEn       ( video1_WEn0              ) /* pin 13*/ ,
    .CEn       ( video1_CEn0              ) /* pin 15*/ ,
    .A         ({ video1_ADR0[5],
                  video1_ADR0[4],
                  video1_ADR0[3],
                  video1_ADR0[2],
                  video1_ADR0[1],
                  video1_ADR0[0]}),
    .I         ({ DO[20],
                  DO[19],
                  DO[18],
                  DO[17],
                  DO[16],
                  video1_ROVIalt[2],
                  video1_ROVIalt[1],
                  video1_ROVIalt[0],
                  DO[27]}),
    .O         ({ video1_DJI[8],
                  video1_DJI[7],
                  video1_DJI[6],
                  video1_DJI[5],
                  video1_DJI[4],
                  video1_DJI[3],
                  video1_DJI[2],
                  video1_DJI[1],
                  video1_DJI[0]})
);

RAM_5501 u_1R1(
    .WEn       ( dma_DMCSn[2]             ) /* pin 20*/ ,
    .A         ({ Net__1R1_Pad7_,
                  Net__1R1_Pad6_,
                  Net__1R1_Pad5_,
                  Net__1R1_Pad21_,
                  Net__1R1_Pad1_,
                  Net__1R1_Pad2_,
                  Net__1R1_Pad3_,
                  Net__1R1_Pad4_}),
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
    .WEn       ( dma_DMCSn[1]             ) /* pin 20*/ ,
    .A         ({ Net__1S1_Pad7_,
                  Net__1S1_Pad6_,
                  Net__1S1_Pad5_,
                  Net__1S1_Pad21_,
                  Net__1S1_Pad1_,
                  Net__1S1_Pad2_,
                  Net__1S1_Pad3_,
                  Net__1S1_Pad4_}),
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
    .WEn       ( dma_DMCSn[0]             ) /* pin 20*/ ,
    .A         ({ Net__1T1_Pad7_,
                  Net__1T1_Pad6_,
                  Net__1T1_Pad5_,
                  Net__1T1_Pad21_,
                  Net__1T1_Pad1_,
                  Net__1T1_Pad2_,
                  Net__1T1_Pad3_,
                  Net__1T1_Pad4_}),
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
    .WEn       ( dma_DMCSn[3]             ) /* pin 20*/ ,
    .A         ({ Net__1U1_Pad7_,
                  Net__1U1_Pad6_,
                  Net__1U1_Pad5_,
                  Net__1U1_Pad21_,
                  Net__1U1_Pad1_,
                  Net__1U1_Pad2_,
                  Net__1U1_Pad3_,
                  Net__1U1_Pad4_}),
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
    .in1       ( video1_RV                ) /* pin 1*/ ,
    .in2       ( Net__2A1_Pad10_          ) /* pin 2*/ ,
    .out3      ( Net__2A1_Pad3_           ) /* pin 3*/ ,
    .in4       ( ROVI[0]                  ) /* pin 4*/ ,
    .in5       ( Net__2A1_Pad10_          ) /* pin 5*/ ,
    .out6      ( video1_ROVIalt[0]        ) /* pin 6*/ ,
    .out8      ( video1_ROVIalt[1]        ) /* pin 8*/ ,
    .in9       ( ROVI[1]                  ) /* pin 9*/ ,
    .in10      ( Net__2A1_Pad10_          ) /* pin 10*/ ,
    .out11     ( video1_ROVIalt[2]        ) /* pin 11*/ ,
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
    .out11     ( Net__1D1_Pad12_          ) /* pin 11*/ ,
    .in12      ( AIn                      ) /* pin 12*/ ,
    .in13      ( video1_H0ln              ) /* pin 13*/ 
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

RAM_5501 u_2R1(
    .WEn       ( dma_DMCSn[2]             ) /* pin 20*/ ,
    .A         ({ Net__2R1_Pad7_,
                  Net__2R1_Pad6_,
                  Net__2R1_Pad5_,
                  Net__2R1_Pad21_,
                  Net__2R1_Pad1_,
                  Net__2R1_Pad2_,
                  Net__2R1_Pad3_,
                  Net__2R1_Pad4_}),
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
    .WEn       ( dma_DMCSn[1]             ) /* pin 20*/ ,
    .A         ({ Net__2S1_Pad7_,
                  Net__2S1_Pad6_,
                  Net__2S1_Pad5_,
                  Net__2S1_Pad21_,
                  Net__2S1_Pad1_,
                  Net__2S1_Pad2_,
                  Net__2S1_Pad3_,
                  Net__2S1_Pad4_}),
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
    .WEn       ( dma_DMCSn[0]             ) /* pin 20*/ ,
    .A         ({ Net__2T1_Pad7_,
                  Net__2T1_Pad6_,
                  Net__2T1_Pad5_,
                  Net__2T1_Pad21_,
                  Net__2T1_Pad1_,
                  Net__2T1_Pad2_,
                  Net__2T1_Pad3_,
                  Net__2T1_Pad4_}),
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
    .WEn       ( dma_DMCSn[3]             ) /* pin 20*/ ,
    .A         ({ Net__2U1_Pad7_,
                  Net__2U1_Pad6_,
                  Net__2U1_Pad5_,
                  Net__2U1_Pad21_,
                  Net__2U1_Pad1_,
                  Net__2U1_Pad2_,
                  Net__2U1_Pad3_,
                  Net__2U1_Pad4_}),
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
    .in2       ( Net__3A1_Pad2_           ) /* pin 2*/ ,
    .out3      ( Net__3A1_Pad3_           ) /* pin 3*/ ,
    .out8      ( Net__3A1_Pad8_           ) /* pin 8*/ ,
    .in9       ( Net__3A1_Pad10_          ) /* pin 9*/ ,
    .in10      ( Net__3A1_Pad10_          ) /* pin 10*/ 
);

jt7400 u_3A2(
    .in1       ( H[0]                     ) /* pin 1*/ ,
    .in2       ( Net__3A2_Pad2_           ) /* pin 2*/ ,
    .out3      ( Net__3A2_Pad3_           ) /* pin 3*/ 
);

RAM_7063 u_3M1(
    .WEn       ( video1_WEn1              ) /* pin 13*/ ,
    .CEn       ( video1_CEn1              ) /* pin 15*/ ,
    .A         ({ Net__3M1_Pad3_,
                  Net__3M1_Pad2_,
                  Net__3M1_Pad1_,
                  Net__3M1_Pad27_,
                  Net__3M1_Pad26_,
                  Net__3M1_Pad25_}),
    .I         ({ DO[28],
                  Net__2C1_Pad8_,
                  Net__2C1_Pad6_,
                  Net__2C1_Pad3_,
                  DO[1],
                  DO[0],
                  DO[23],
                  DO[22],
                  DO[21]}),
    .O         ({ video1_DJI[17],
                  video1_DJI[16],
                  video1_DJI[15],
                  video1_DJI[14],
                  video1_DJI[13],
                  video1_DJI[12],
                  video1_DJI[11],
                  video1_DJI[10],
                  video1_DJI[9]})
);

RAM_7063 u_3M2(
    .WEn       ( video1_WEn0              ) /* pin 13*/ ,
    .CEn       ( video1_CEn0              ) /* pin 15*/ ,
    .A         ({ video1_ADR0[5],
                  video1_ADR0[4],
                  video1_ADR0[3],
                  video1_ADR0[2],
                  video1_ADR0[1],
                  video1_ADR0[0]}),
    .I         ({ DO[28],
                  Net__2D1_Pad8_,
                  Net__2D1_Pad6_,
                  Net__2D1_Pad3_,
                  DO[1],
                  DO[0],
                  DO[23],
                  DO[22],
                  DO[21]}),
    .O         ({ video1_DJI[17],
                  video1_DJI[16],
                  video1_DJI[15],
                  video1_DJI[14],
                  video1_DJI[13],
                  video1_DJI[12],
                  video1_DJI[11],
                  video1_DJI[10],
                  video1_DJI[9]})
);

jt7411 u_4A1(
    .in1       ( H[2]                     ) /* pin 1*/ ,
    .in2       ( H[1]                     ) /* pin 2*/ ,
    .in3       ( Net__3A1_Pad2_           ) /* pin 3*/ ,
    .in4       ( H[1]                     ) /* pin 4*/ ,
    .in5       ( Net__3A2_Pad3_           ) /* pin 5*/ ,
    .out6      ( Net__3A1_Pad10_          ) /* pin 6*/ ,
    .out8      ( Net__4A1_Pad8_           ) /* pin 8*/ ,
    .in9       ( video1_H0ln              ) /* pin 9*/ ,
    .in10      ( H[0]                     ) /* pin 10*/ ,
    .in11      ( Net__4A1_Pad11_          ) /* pin 11*/ ,
    .out12     ( Net__3A1_Pad1_           ) /* pin 12*/ ,
    .in13      ( H[0]                     ) /* pin 13*/ 
);

jt7474 u_4B1(
    .cl1_b     ( 1'b1                     ) /* pin 1*/ ,
    .d1        ( H[0]                     ) /* pin 2*/ ,
    .clk1      ( DOTCK                    ) /* pin 3*/ ,
    .pr1_b     ( 1'b1                     ) /* pin 4*/ ,
    .q1        ( Net__3A2_Pad2_           ) /* pin 5*/ ,
    .q1_b      ( video1_H0ln              ) /* pin 6*/ ,
    .q2_b      ( TXTCL                    ) /* pin 8*/ ,
    .q2        ( Net__4B1_Pad9_           ) /* pin 9*/ ,
    .pr2_b     ( 1'b1                     ) /* pin 10*/ ,
    .clk2      ( DOTCK                    ) /* pin 11*/ ,
    .d2        ( Net__3A1_Pad3_           ) /* pin 12*/ ,
    .cl2_b     ( 1'b1                     ) /* pin 13*/ 
);

jt74157 u_4M1(
    .S         ( V[0]                     ) /* pin 1*/ ,
    .VSS       ( 1'b0                     ) /* pin 8*/ ,
    .Gn        ( 1'b0                     ) /* pin 15*/ ,
    .VDD       ( 1'b1                     ) /* pin 16*/ ,
    .A         ({ H[5],
                  H[4],
                  H[3],
                  H2O}),
    .B         ({ DO[5],
                  DO[4],
                  DO[3],
                  DO[2]}),
    .Y         ({ video1_ADR0[3],
                  video1_ADR0[2],
                  video1_ADR0[1],
                  video1_ADR0[0]})
);

jt74157 u_4N1(
    .S         ( V[0]                     ) /* pin 1*/ ,
    .VSS       ( 1'b0                     ) /* pin 8*/ ,
    .Gn        ( 1'b0                     ) /* pin 15*/ ,
    .VDD       ( 1'b1                     ) /* pin 16*/ ,
    .A         ({ DO[7],
                  DO[6],
                  H[7],
                  H[6]}),
    .B         ({ H[7],
                  H[6],
                  DO[6],
                  DO[7]}),
    .Y         ({ video1_ADR1[5],
                  video1_ADR1[4],
                  video1_ADR0[5],
                  video1_ADR0[4]})
);

jt74157 u_4P1(
    .S         ( V[0]                     ) /* pin 1*/ ,
    .VSS       ( 1'b0                     ) /* pin 8*/ ,
    .Gn        ( 1'b0                     ) /* pin 15*/ ,
    .VDD       ( 1'b1                     ) /* pin 16*/ ,
    .A         ({ DO[5],
                  DO[4],
                  DO[3],
                  DO[2]}),
    .B         ({ H[5],
                  H[4],
                  H[3],
                  H2O}),
    .Y         ({ video1_ADR1[3],
                  video1_ADR1[2],
                  video1_ADR1[1],
                  video1_ADR1[0]})
);

jt74157 u_4P2(
    .S         ( V[0]                     ) /* pin 1*/ ,
    .VSS       ( 1'b0                     ) /* pin 8*/ ,
    .Gn        ( 1'b0                     ) /* pin 15*/ ,
    .VDD       ( 1'b1                     ) /* pin 16*/ ,
    .A         ({ Net__4P2_Pad10_,
                  Net__3A1_Pad8_,
                  Net__1D1_Pad8_,
                  1'b0}),
    .B         ({ Net__3A1_Pad8_,
                  Net__4P2_Pad10_,
                  1'b0,
                  Net__1D1_Pad8_}),
    .Y         ({ video1_WEn1,
                  video1_WEn0,
                  video1_CEn1,
                  video1_CEn0})
);

jt7404 u_5A1(
    .in1       ( H[0]                     ) /* pin 1*/ ,
    .out2      ( AIn                      ) /* pin 2*/ ,
    .in5       ( HB                       ) /* pin 5*/ ,
    .out6      ( Net__3A1_Pad2_           ) /* pin 6*/ ,
    .out8      ( Net__2C1_Pad1_           ) /* pin 8*/ ,
    .in9       ( V[0]                     ) /* pin 9*/ ,
    .out10     ( BIn                      ) /* pin 10*/ ,
    .in11      ( H[1]                     ) /* pin 11*/ ,
    .out12     ( Net__4A1_Pad11_          ) /* pin 12*/ ,
    .in13      ( H[1]                     ) /* pin 13*/ 
);

jt7404 u_5L1(
    .in1       ( ROHVCK                   ) /* pin 1*/ ,
    .out2      ( Net__5L1_Pad2_           ) /* pin 2*/ ,
    .in3       ( Net__5L1_Pad2_           ) /* pin 3*/ ,
    .out4      ( Net__2A1_Pad10_          ) /* pin 4*/ ,
    .out8      ( Net__5L1_Pad8_           ) /* pin 8*/ ,
    .in9       ( ROHVCK                   ) /* pin 9*/ ,
    .out12     ( video1_RV                ) /* pin 12*/ ,
    .in13      ( RVn                      ) /* pin 13*/ 
);

jt7404 u_5U1(
    .in1       ( AD[5]                    ) /* pin 1*/ ,
    .out2      ( video3_ADx[5]            ) /* pin 2*/ ,
    .in3       ( AD[0]                    ) /* pin 3*/ ,
    .out4      ( video3_ADx[0]            ) /* pin 4*/ ,
    .in5       ( AD[3]                    ) /* pin 5*/ ,
    .out6      ( video3_ADx[3]            ) /* pin 6*/ ,
    .out8      ( video3_ADx[4]            ) /* pin 8*/ ,
    .in9       ( AD[4]                    ) /* pin 9*/ ,
    .out10     ( video3_ADx[1]            ) /* pin 10*/ ,
    .in11      ( AD[1]                    ) /* pin 11*/ ,
    .out12     ( video3_ADx[2]            ) /* pin 12*/ ,
    .in13      ( AD[2]                    ) /* pin 13*/ 
);

jt7404 u_6T1(
    .in1       ( video3_AT[11]            ) /* pin 1*/ ,
    .out2      ( video3_AT11n             ) /* pin 2*/ ,
    .in3       ( DWRBKn                   ) /* pin 3*/ ,
    .out4      ( Net__6T1_Pad4_           ) /* pin 4*/ ,
    .in5       ( Net__6T1_Pad4_           ) /* pin 5*/ ,
    .out6      ( Net__6T1_Pad6_           ) /* pin 6*/ ,
    .out8      ( Net__6T1_Pad8_           ) /* pin 8*/ ,
    .in9       ( ROVI[8]                  ) /* pin 9*/ ,
    .out10     ( Net__6T1_Pad10_          ) /* pin 10*/ ,
    .in11      ( video3_AD[12]            ) /* pin 11*/ 
);

jt74157 u_6U1(
    .S         ( CSBWn                    ) /* pin 1*/ ,
    .VSS       ( 1'b0                     ) /* pin 8*/ ,
    .Gn        ( 1'b0                     ) /* pin 15*/ ,
    .VDD       ( 1'b1                     ) /* pin 16*/ ,
    .A         ({ Net__6U1_Pad14_,
                  Net__6U1_Pad11_,
                  Net__6T1_Pad10_,
                  MEMWR0}),
    .B         ({ Net__6U1_Pad13_,
                  Net__6U1_Pad10_,
                  video3_ROV[7],
                  Net__6U1_Pad3_}),
    .Y         ({ Net__6U1_Pad12_,
                  Net__6U1_Pad9_,
                  Net__6U1_Pad7_,
                  video3_BAKCK})
);

jt7400 u_7L1(
    .out11     ( Net__7L1_Pad11_          ) /* pin 11*/ ,
    .in12      ( video3_ROH[1]            ) /* pin 12*/ ,
    .in13      ( video3_ROH[0]            ) /* pin 13*/ 
);

jt74161 u_7M1(
    .cl_b      ( 1'b1                     ) /* pin 1*/ ,
    .clk       ( DOTCK                    ) /* pin 2*/ ,
    .cep       ( 1'b1                     ) /* pin 7*/ ,
    .VSS       ( 1'b0                     ) /* pin 8*/ ,
    .ld_b      ( ROHVCK                   ) /* pin 9*/ ,
    .cet       ( Net__7M1_Pad10_          ) /* pin 10*/ ,
    .ca        ( Net__7M1_Pad15_          ) /* pin 15*/ ,
    .VDD       ( 1'b1                     ) /* pin 16*/ ,
    .d         ({ DO[7],
                  DO[6],
                  DO[5],
                  DO[4]}),
    .q         ({ video3_ROH[7],
                  video3_ROH[6],
                  video3_ROH[5],
                  video3_ROH[4]})
);

jt74161 u_7N1(
    .cl_b      ( 1'b1                     ) /* pin 1*/ ,
    .clk       ( DOTCK                    ) /* pin 2*/ ,
    .cep       ( 1'b1                     ) /* pin 7*/ ,
    .VSS       ( 1'b0                     ) /* pin 8*/ ,
    .ld_b      ( ROHVCK                   ) /* pin 9*/ ,
    .cet       ( 1'b1                     ) /* pin 10*/ ,
    .ca        ( Net__7M1_Pad10_          ) /* pin 15*/ ,
    .VDD       ( 1'b1                     ) /* pin 16*/ ,
    .d         ({ DO[3],
                  DO[2],
                  DO[1],
                  DO[0]}),
    .q         ({ video3_ROH[3],
                  video3_ROH[2],
                  video3_ROH[1],
                  video3_ROH[0]})
);

jt74157 u_7P1(
    .S         ( CSBWn                    ) /* pin 1*/ ,
    .VSS       ( 1'b0                     ) /* pin 8*/ ,
    .Gn        ( video3_ROV[8]            ) /* pin 15*/ ,
    .VDD       ( 1'b1                     ) /* pin 16*/ ,
    .A         ({ AD[6],
                  video3_ADx[2],
                  video3_ADx[1],
                  video3_ADx[0]}),
    .B         ({ video3_ROH[5],
                  video3_ROH[4],
                  video3_ROH[3],
                  video3_ROH[2]}),
    .Y         ({ video3_AT[3],
                  video3_AT[2],
                  video3_AT[1],
                  video3_AT[0]})
);

jt74157 u_7R1(
    .S         ( CSBWn                    ) /* pin 1*/ ,
    .VSS       ( 1'b0                     ) /* pin 8*/ ,
    .Gn        ( video3_ROV[8]            ) /* pin 15*/ ,
    .VDD       ( 1'b1                     ) /* pin 16*/ ,
    .A         ({ AD[8],
                  AD[7],
                  video3_ADx[4],
                  video3_ADx[3]}),
    .B         ({ video3_ROV[2],
                  video3_ROV[1],
                  video3_ROH[7],
                  video3_ROH[6]}),
    .Y         ({ video3_AT[7],
                  video3_AT[6],
                  video3_AT[5],
                  video3_AT[4]})
);

jt74157 u_7S1(
    .S         ( CSBWn                    ) /* pin 1*/ ,
    .VSS       ( 1'b0                     ) /* pin 8*/ ,
    .Gn        ( video3_ROV[8]            ) /* pin 15*/ ,
    .VDD       ( 1'b1                     ) /* pin 16*/ ,
    .A         ({ video3_AD[11],
                  video3_AD[10],
                  video3_ADx[5],
                  video3_AD[9]}),
    .B         ({ video3_ROV[6],
                  video3_ROV[5],
                  video3_ROV[4],
                  video3_ROV[3]}),
    .Y         ({ video3_AT[11],
                  video3_AT[10],
                  video3_AT[9],
                  video3_AT[8]})
);

jt74257 u_7T1(
    .sel       ( Net__6T1_Pad10_          ) /* pin 1*/ ,
    .VSS       ( 1'b0                     ) /* pin 8*/ ,
    .en_b      ( Net__6T1_Pad6_           ) /* pin 15*/ ,
    .VDD       ( 1'b1                     ) /* pin 16*/ ,
    .a         ({ BAKC[3],
                  BAKC[2],
                  BAKC[1],
                  BAKC[0]}),
    .b         ({ DD[3],
                  DD[2],
                  DD[1],
                  DD[0]}),
    .y         ({ video3_BK[3],
                  video3_BK[2],
                  video3_BK[1],
                  video3_BK[0]})
);

jt74257 u_7U1(
    .sel       ( Net__6T1_Pad10_          ) /* pin 1*/ ,
    .VSS       ( 1'b0                     ) /* pin 8*/ ,
    .en_b      ( Net__6T1_Pad6_           ) /* pin 15*/ ,
    .VDD       ( 1'b1                     ) /* pin 16*/ ,
    .a         ({ DD[3],
                  DD[2],
                  DD[1],
                  DD[0]}),
    .b         ({ BAKC[3],
                  BAKC[2],
                  BAKC[1],
                  BAKC[0]}),
    .y         ({ video3_BK[7],
                  video3_BK[6],
                  video3_BK[5],
                  video3_BK[4]})
);

jt7404 u_8L1(
    .in1       ( Net__3A2_Pad3_           ) /* pin 1*/ ,
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
    .out2      ( Net__4P2_Pad10_          ) /* pin 2*/ 
);

RAM_2016 u_8P1(
    .CEn       ( video3_AT11n             ) /* pin 18*/ ,
    .A         ({ video3_AT[10],
                  video3_AT[9],
                  video3_AT[8],
                  video3_AT[7],
                  video3_AT[6],
                  video3_AT[5],
                  video3_AT[4],
                  video3_AT[3],
                  video3_AT[2],
                  video3_AT[1],
                  video3_AT[0]}),
    .D         ({ video3_BK[7],
                  video3_BK[6],
                  video3_BK[5],
                  video3_BK[4],
                  video3_BK[3],
                  video3_BK[2],
                  video3_BK[1],
                  video3_BK[0]})
);

RAM_2016 u_8S1(
    .CEn       ( DWRBKn                   ) /* pin 18*/ ,
    .A         ({ video3_AT[10],
                  video3_AT[9],
                  video3_AT[8],
                  video3_AT[7],
                  video3_AT[6],
                  video3_AT[5],
                  video3_AT[4],
                  video3_AT[3],
                  video3_AT[2],
                  video3_AT[1],
                  video3_AT[0]}),
    .D         ({ video3_BK[7],
                  video3_BK[6],
                  video3_BK[5],
                  video3_BK[4],
                  video3_BK[3],
                  video3_BK[2],
                  video3_BK[1],
                  video3_BK[0]})
);

jt74157 u_8T1(
    .S         ( Net__6U1_Pad7_           ) /* pin 1*/ ,
    .VSS       ( 1'b0                     ) /* pin 8*/ ,
    .Gn        ( 1'b0                     ) /* pin 15*/ ,
    .VDD       ( 1'b1                     ) /* pin 16*/ ,
    .A         ({ video3_BK[3],
                  video3_BK[2],
                  video3_BK[1],
                  video3_BK[0]}),
    .B         ({ video3_BK[7],
                  video3_BK[6],
                  video3_BK[5],
                  video3_BK[4]}),
    .Y         ({ Net__8T1_Pad12_,
                  Net__8T1_Pad9_,
                  Net__8T1_Pad7_,
                  Net__8T1_Pad4_})
);

jt74174 u_8U1(
    .clk       ( 1'b1                     ) /* pin 1*/ ,
    .VSS       ( 1'b0                     ) /* pin 8*/ ,
    .cl_b      ( video3_BAKCK             ) /* pin 9*/ ,
    .VDD       ( 1'b1                     ) /* pin 16*/ ,
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

jt7404 U1(
    .in1       ( BIn                      ) /* pin 1*/ ,
    .out2      ( dma_BI                   ) /* pin 2*/ ,
    .in3       ( AIn                      ) /* pin 3*/ ,
    .out4      ( dma_AI                   ) /* pin 4*/ ,
    .VSS       ( 1'b0                     ) /* pin 7*/ ,
    .VDD       ( 1'b1                     ) /* pin 14*/ 
);

jt7400 U1B1(
    .in1       ( dma_BI                   ) /* pin 1*/ ,
    .in2       ( dma_BI                   ) /* pin 2*/ ,
    .out3      ( Net__U1B1_Pad3_          ) /* pin 3*/ ,
    .in4       ( dma_AI                   ) /* pin 4*/ ,
    .in5       ( dma_AI                   ) /* pin 5*/ ,
    .out6      ( Net__U1B1_Pad6_          ) /* pin 6*/ ,
    .VSS       ( 1'b0                     ) /* pin 7*/ ,
    .out8      ( ROHVS                    ) /* pin 8*/ ,
    .in9       ( dma_DMclr_n              ) /* pin 9*/ ,
    .in10      ( Net__U1B1_Pad10_         ) /* pin 10*/ ,
    .out11     ( ROHVCK                   ) /* pin 11*/ ,
    .in12      ( Net__U1B1_Pad12_         ) /* pin 12*/ ,
    .in13      ( dma_BI                   ) /* pin 13*/ ,
    .VDD       ( 1'b1                     ) /* pin 14*/ 
);

jt7400 U1D1(
    .in1       ( Net__U1D1_Pad1_          ) /* pin 1*/ ,
    .in2       ( HBDn                     ) /* pin 2*/ ,
    .out3      ( Net__U1D1_Pad3_          ) /* pin 3*/ ,
    .in4       ( Net__U1D1_Pad4_          ) /* pin 4*/ ,
    .in5       ( Net__U1D1_Pad5_          ) /* pin 5*/ ,
    .out6      ( Net__U1D1_Pad6_          ) /* pin 6*/ ,
    .VSS       ( 1'b0                     ) /* pin 7*/ ,
    .out8      ( Net__U1D1_Pad8_          ) /* pin 8*/ ,
    .in9       ( Net__U1D1_Pad1_          ) /* pin 9*/ ,
    .in10      ( dma_BUSRQ                ) /* pin 10*/ ,
    .VDD       ( 1'b1                     ) /* pin 14*/ 
);

jt74138 U1E1(
    .e1_b      ( Net__U1D1_Pad1_          ) /* pin 4*/ ,
    .e2_b      ( dma_DMEND                ) /* pin 5*/ ,
    .e3        ( Net__U1B1_Pad3_          ) /* pin 6*/ ,
    .VSS       ( 1'b0                     ) /* pin 8*/ ,
    .VDD       ( 1'b1                     ) /* pin 16*/ ,
    .a         ({ 1'b0,
                  Net__U1E1_Pad2_,
                  Net__U1E1_Pad1_}),
    .y_b       ({ Net__U1E1_Pad7_,
                  Net__U1E1_Pad9_,
                  Net__U1E1_Pad10_,
                  Net__U1E1_Pad11_,
                  dma_DMCSn[3],
                  dma_DMCSn[2],
                  dma_DMCSn[1],
                  dma_DMCSn[0]})
);

jt74161 U1F1(
    .cl_b      ( dma_DMclr_n              ) /* pin 1*/ ,
    .clk       ( Net__U1B1_Pad6_          ) /* pin 2*/ ,
    .cep       ( Net__U1D1_Pad6_          ) /* pin 7*/ ,
    .VSS       ( 1'b0                     ) /* pin 8*/ ,
    .ld_b      ( 1'b1                     ) /* pin 9*/ ,
    .cet       ( Net__U1D1_Pad6_          ) /* pin 10*/ ,
    .ca        ( Net__U1F1_Pad15_         ) /* pin 15*/ ,
    .VDD       ( 1'b1                     ) /* pin 16*/ ,
    .d         ({ Net__U1F1_Pad6_,
                  Net__U1F1_Pad5_,
                  Net__U1F1_Pad4_,
                  Net__U1F1_Pad3_}),
    .q         ({ Net__U1F1_Pad11_,
                  Net__U1F1_Pad12_,
                  Net__U1F1_Pad13_,
                  Net__U1F1_Pad14_})
);

jt7474 U1L1(
    .cl1_b     ( Net__U1L1_Pad1_          ) /* pin 1*/ ,
    .d1        ( 1'b1                     ) /* pin 2*/ ,
    .clk1      ( Net__U1L1_Pad3_          ) /* pin 3*/ ,
    .pr1_b     ( 1'b1                     ) /* pin 4*/ ,
    .q1        ( dma_BUSRQ                ) /* pin 5*/ ,
    .q1_b      ( BUSRQn                   ) /* pin 6*/ ,
    .VSS       ( 1'b0                     ) /* pin 7*/ ,
    .VDD       ( 1'b1                     ) /* pin 14*/ 
);

jt7474 U2(
    .cl1_b     ( Net__U1D1_Pad8_          ) /* pin 1*/ ,
    .d1        ( Net__U1D1_Pad3_          ) /* pin 2*/ ,
    .clk1      ( Net__U1D1_Pad5_          ) /* pin 3*/ ,
    .pr1_b     ( 1'b1                     ) /* pin 4*/ ,
    .q1        ( Net__U2_Pad5_            ) /* pin 5*/ ,
    .q1_b      ( Net__U2_Pad6_            ) /* pin 6*/ ,
    .VSS       ( 1'b0                     ) /* pin 7*/ ,
    .q2_b      ( Net__U1B1_Pad12_         ) /* pin 8*/ ,
    .q2        ( Net__U1B1_Pad10_         ) /* pin 9*/ ,
    .pr2_b     ( 1'b1                     ) /* pin 10*/ ,
    .clk2      ( dma_AI                   ) /* pin 11*/ ,
    .d2        ( dma_DMclr_n              ) /* pin 12*/ ,
    .cl2_b     ( 1'b1                     ) /* pin 13*/ ,
    .VDD       ( 1'b1                     ) /* pin 14*/ 
);

jt7474 U2D1(
    .cl1_b     ( 1'b1                     ) /* pin 1*/ ,
    .d1        ( dma_BI                   ) /* pin 2*/ ,
    .clk1      ( dma_AI                   ) /* pin 3*/ ,
    .pr1_b     ( 1'b1                     ) /* pin 4*/ ,
    .q1        ( Net__U1D1_Pad5_          ) /* pin 5*/ ,
    .q1_b      ( Net__U2D1_Pad6_          ) /* pin 6*/ ,
    .VSS       ( 1'b0                     ) /* pin 7*/ ,
    .q2_b      ( Net__U1D1_Pad1_          ) /* pin 8*/ ,
    .q2        ( Net__U1D1_Pad4_          ) /* pin 9*/ ,
    .pr2_b     ( 1'b1                     ) /* pin 10*/ ,
    .clk2      ( Net__U1B1_Pad3_          ) /* pin 11*/ ,
    .d2        ( dma_BUSAK                ) /* pin 12*/ ,
    .cl2_b     ( 1'b1                     ) /* pin 13*/ ,
    .VDD       ( 1'b1                     ) /* pin 14*/ 
);

jt74161 U2E1(
    .cl_b      ( dma_DMclr_n              ) /* pin 1*/ ,
    .clk       ( Net__U1B1_Pad6_          ) /* pin 2*/ ,
    .cep       ( 1'b1                     ) /* pin 7*/ ,
    .VSS       ( 1'b0                     ) /* pin 8*/ ,
    .ld_b      ( 1'b1                     ) /* pin 9*/ ,
    .cet       ( Net__U2E1_Pad10_         ) /* pin 10*/ ,
    .ca        ( Net__U2E1_Pad15_         ) /* pin 15*/ ,
    .VDD       ( 1'b1                     ) /* pin 16*/ ,
    .d         ({ Net__U2E1_Pad6_,
                  Net__U2E1_Pad5_,
                  Net__U2E1_Pad4_,
                  Net__U2E1_Pad3_}),
    .q         ({ Net__U2E1_Pad11_,
                  dma_DMEND,
                  Net__U1E1_Pad2_,
                  Net__U1E1_Pad1_})
);

jt74161 U2F1(
    .cl_b      ( dma_DMclr_n              ) /* pin 1*/ ,
    .clk       ( Net__U1B1_Pad6_          ) /* pin 2*/ ,
    .cep       ( 1'b1                     ) /* pin 7*/ ,
    .VSS       ( 1'b0                     ) /* pin 8*/ ,
    .ld_b      ( 1'b1                     ) /* pin 9*/ ,
    .cet       ( Net__U1F1_Pad15_         ) /* pin 10*/ ,
    .ca        ( Net__U2E1_Pad10_         ) /* pin 15*/ ,
    .VDD       ( 1'b1                     ) /* pin 16*/ ,
    .d         ({ Net__U2F1_Pad6_,
                  Net__U2F1_Pad5_,
                  Net__U2F1_Pad4_,
                  Net__U2F1_Pad3_}),
    .q         ({ Net__U2F1_Pad11_,
                  Net__U2F1_Pad12_,
                  Net__U2F1_Pad13_,
                  Net__U2F1_Pad14_})
);

jt74367 U2H1(
    .oe1_b     ( 1'b0                     ) /* pin 1*/ ,
    .VSS       ( 1'b0                     ) /* pin 8*/ ,
    .oe2_b     ( 1'b0                     ) /* pin 15*/ ,
    .VDD       ( 1'b1                     ) /* pin 16*/ ,
    .A         ({ Net__U2F1_Pad14_,
                  Net__U1F1_Pad13_,
                  Net__U1F1_Pad11_,
                  Net__U1F1_Pad14_,
                  Net__U2F1_Pad13_,
                  Net__U1F1_Pad12_}),
    .Y         ({ dma_DM[4],
                  dma_DM[1],
                  dma_DM[3],
                  dma_DM[0],
                  dma_DM[5],
                  dma_DM[2]})
);

jt7402 U2K1(
    .out1      ( Net__U1L1_Pad3_          ) /* pin 1*/ ,
    .in2       ( VBn                      ) /* pin 2*/ ,
    .in3       ( VBn                      ) /* pin 3*/ ,
    .out4      ( Net__U1L1_Pad1_          ) /* pin 4*/ ,
    .in5       ( RESET                    ) /* pin 5*/ ,
    .in6       ( dma_DMEND                ) /* pin 6*/ ,
    .VSS       ( 1'b0                     ) /* pin 7*/ ,
    .VDD       ( 1'b1                     ) /* pin 14*/ 
);

jt7400 U3(
    .in1       ( Net__U1D1_Pad3_          ) /* pin 1*/ ,
    .in2       ( Net__U2_Pad6_            ) /* pin 2*/ ,
    .out3      ( dma_DMclr_n              ) /* pin 3*/ ,
    .VSS       ( 1'b0                     ) /* pin 7*/ ,
    .VDD       ( 1'b1                     ) /* pin 14*/ 
);

jt74367 U3E1(
    .oe1_b     ( dma_DMCSpullup           ) /* pin 1*/ ,
    .VSS       ( 1'b0                     ) /* pin 8*/ ,
    .oe2_b     ( dma_DMCSpullup           ) /* pin 15*/ ,
    .VDD       ( 1'b1                     ) /* pin 16*/ ,
    .A         ({ Net__U1E1_Pad2_,
                  Net__U2F1_Pad11_,
                  Net__U1E1_Pad1_,
                  Net__U1F1_Pad12_,
                  Net__U1F1_Pad11_,
                  Net__U1F1_Pad14_}),
    .Y         ({ AD[1],
                  AD[5],
                  AD[0],
                  AD[3],
                  AD[4],
                  AD[2]})
);

jt74367 U3H1(
    .oe1_b     ( Net__U3H1_Pad1_          ) /* pin 1*/ ,
    .VSS       ( 1'b0                     ) /* pin 8*/ ,
    .oe2_b     ( 1'b0                     ) /* pin 15*/ ,
    .VDD       ( 1'b1                     ) /* pin 16*/ ,
    .A         ({ Net__U2F1_Pad11_,
                  Net__U2F1_Pad12_,
                  Net__U3H1_Pad10_,
                  Net__U3H1_Pad6_,
                  Net__U3H1_Pad4_,
                  Net__U3H1_Pad2_}),
    .Y         ({ dma_DM[7],
                  dma_DM[6],
                  Net__U3H1_Pad9_,
                  Net__U3H1_Pad7_,
                  Net__U3H1_Pad5_,
                  Net__U3H1_Pad3_})
);

jt74283 U3R1(
    .cin       ( Net__U3R1_Pad7_          ) /* pin 7*/ ,
    .VSS       ( 1'b0                     ) /* pin 8*/ ,
    .cout      ( ROVI[8]                  ) /* pin 9*/ ,
    .VDD       ( 1'b1                     ) /* pin 16*/ ,
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
    .VSS       ( 1'b0                     ) /* pin 8*/ ,
    .cout      ( Net__U3R1_Pad7_          ) /* pin 9*/ ,
    .VDD       ( 1'b1                     ) /* pin 16*/ ,
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
    .VSS       ( 1'b0                     ) /* pin 8*/ ,
    .cout      ( Net__1D1_Pad9_           ) /* pin 9*/ ,
    .VDD       ( 1'b1                     ) /* pin 16*/ ,
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

jt7437 U4(
    .in1       ( BUSAK_n                  ) /* pin 1*/ ,
    .in2       ( BUSAK_n                  ) /* pin 2*/ ,
    .out3      ( dma_BUSAK                ) /* pin 3*/ ,
    .VSS       ( 1'b0                     ) /* pin 7*/ ,
    .VDD       ( 1'b1                     ) /* pin 14*/ 
);

jt74365 U4E1(
    .oe1_b     ( Net__U1D1_Pad1_          ) /* pin 1*/ ,
    .VSS       ( 1'b0                     ) /* pin 8*/ ,
    .oe2_b     ( dma_DMEND                ) /* pin 15*/ ,
    .VDD       ( 1'b1                     ) /* pin 16*/ ,
    .A         ({ 1'b0,
                  1'b0,
                  Net__U1F1_Pad13_,
                  Net__U2F1_Pad14_,
                  Net__U2F1_Pad13_,
                  Net__U2F1_Pad12_}),
    .Y         ({ dma_DMCSpullup,
                  Net__U4E1_Pad5_,
                  AD[6],
                  AD[7],
                  AD[8],
                  AD[9]})
);

jt74174 U5(
    .clk       ( 1'b1                     ) /* pin 1*/ ,
    .VSS       ( 1'b0                     ) /* pin 8*/ ,
    .cl_b      ( Net__4A1_Pad8_           ) /* pin 9*/ ,
    .VDD       ( 1'b1                     ) /* pin 16*/ ,
    .d         ({ video1_DJI[5],
                  video1_DJI[4],
                  video1_DJI[3],
                  video1_DJI[2],
                  video1_DJI[1],
                  video1_DJI[0]}),
    .q         ({ DJ[5],
                  DJ[4],
                  DJ[3],
                  DJ[2],
                  DJ[1],
                  DJ[0]})
);

jt74174 U6(
    .clk       ( 1'b1                     ) /* pin 1*/ ,
    .VSS       ( 1'b0                     ) /* pin 8*/ ,
    .cl_b      ( Net__4A1_Pad8_           ) /* pin 9*/ ,
    .VDD       ( 1'b1                     ) /* pin 16*/ ,
    .d         ({ video1_DJI[11],
                  video1_DJI[10],
                  video1_DJI[9],
                  video1_DJI[8],
                  video1_DJI[7],
                  video1_DJI[6]}),
    .q         ({ DJ[11],
                  DJ[10],
                  DJ[9],
                  DJ[8],
                  DJ[7],
                  DJ[6]})
);

jt7402 U6C1(
    .out1      ( DMCS                     ) /* pin 1*/ ,
    .in2       ( dma_DMCSpullup           ) /* pin 2*/ ,
    .in3       ( dma_DMCSpullup           ) /* pin 3*/ ,
    .VSS       ( 1'b0                     ) /* pin 7*/ ,
    .VDD       ( 1'b1                     ) /* pin 14*/ 
);

jt74174 U7(
    .clk       ( 1'b1                     ) /* pin 1*/ ,
    .VSS       ( 1'b0                     ) /* pin 8*/ ,
    .cl_b      ( Net__4A1_Pad8_           ) /* pin 9*/ ,
    .VDD       ( 1'b1                     ) /* pin 16*/ ,
    .d         ({ video1_DJI[17],
                  video1_DJI[16],
                  video1_DJI[15],
                  video1_DJI[14],
                  video1_DJI[13],
                  video1_DJI[12]}),
    .q         ({ DJ[17],
                  DJ[16],
                  DJ[15],
                  DJ[14],
                  DJ[13],
                  DJ[12]})
);

jt74273 U8(
    .cl_b      ( CSBWn                    ) /* pin 1*/ ,
    .VSS       ( 1'b0                     ) /* pin 10*/ ,
    .clk       ( ROHVCK                   ) /* pin 11*/ ,
    .VDD       ( 1'b1                     ) /* pin 20*/ ,
    .d         ({ Net__6T1_Pad8_,
                  ROVI[7],
                  ROVI[6],
                  ROVI[5],
                  ROVI[4],
                  ROVI[3],
                  ROVI[2],
                  ROVI[1]}),
    .q         ({ video3_ROV[8],
                  video3_ROV[7],
                  video3_ROV[6],
                  video3_ROV[5],
                  video3_ROV[4],
                  video3_ROV[3],
                  video3_ROV[2],
                  video3_ROV[1]})
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
    .x         ( video1_DJI[9]            ) /* pin 1*/ 
);

rpullup pu10(
    .x         ( video1_DJI[0]            ) /* pin 1*/ 
);

rpullup pu11(
    .x         ( video1_DJI[1]            ) /* pin 1*/ 
);

rpullup pu12(
    .x         ( video1_DJI[2]            ) /* pin 1*/ 
);

rpullup pu13(
    .x         ( video1_DJI[3]            ) /* pin 1*/ 
);

rpullup pu14(
    .x         ( video1_DJI[4]            ) /* pin 1*/ 
);

rpullup pu15(
    .x         ( video1_DJI[5]            ) /* pin 1*/ 
);

rpullup pu16(
    .x         ( video1_DJI[6]            ) /* pin 1*/ 
);

rpullup pu17(
    .x         ( video1_DJI[7]            ) /* pin 1*/ 
);

rpullup pu18(
    .x         ( video1_DJI[8]            ) /* pin 1*/ 
);

rpullup pu2(
    .x         ( video1_DJI[10]           ) /* pin 1*/ 
);

rpullup pu3(
    .x         ( video1_DJI[11]           ) /* pin 1*/ 
);

rpullup pu4(
    .x         ( video1_DJI[12]           ) /* pin 1*/ 
);

rpullup pu5(
    .x         ( video1_DJI[13]           ) /* pin 1*/ 
);

rpullup pu6(
    .x         ( video1_DJI[14]           ) /* pin 1*/ 
);

rpullup pu7(
    .x         ( video1_DJI[15]           ) /* pin 1*/ 
);

rpullup pu8(
    .x         ( video1_DJI[16]           ) /* pin 1*/ 
);

rpullup pu9(
    .x         ( video1_DJI[17]           ) /* pin 1*/ 
);

