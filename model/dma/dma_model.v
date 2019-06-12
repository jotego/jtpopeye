wire AIn;
wire BIn;
wire BUSAK;
wire BUSRQ;
wire DMEND;
wire DMclr_n;
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
wire Net__U1E1_Pad6_;
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
wire Net__U1F1_Pad9_;
wire Net__U1L1_Pad1_;
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
wire Net__U3E1_Pad1_;
wire Net__U3H1_Pad10_;
wire Net__U3H1_Pad1_;
wire Net__U3H1_Pad2_;
wire Net__U3H1_Pad3_;
wire Net__U3H1_Pad4_;
wire Net__U3H1_Pad5_;
wire Net__U3H1_Pad6_;
wire Net__U3H1_Pad7_;
wire Net__U3H1_Pad9_;
wire Net__U4E1_Pad5_;
wire VBn;

jt7404 U1(
    .in1       ( BIn                      ),
    .out2      ( BI                       ),
    .in3       ( AIn                      ),
    .out4      ( AI                       ),
    .VSS       ( 1'b0                     ),
    .VDD       ( 1'b1                     )
);

jt7400 U1B1(
    .in1       ( BI                       ),
    .in2       ( BI                       ),
    .out3      ( Net__U1B1_Pad3_          ),
    .in4       ( AI                       ),
    .in5       ( AI                       ),
    .out6      ( Net__U1B1_Pad6_          ),
    .VSS       ( 1'b0                     ),
    .out8      ( ROHVS                    ),
    .in9       ( DMclr_n                  ),
    .in10      ( Net__U1B1_Pad10_         ),
    .out11     ( ROHVCK                   ),
    .in12      ( Net__U1B1_Pad12_         ),
    .in13      ( BI                       ),
    .VDD       ( 1'b1                     )
);

jt7400 U1D1(
    .in1       ( Net__U1D1_Pad1_          ),
    .in2       ( HBDn                     ),
    .out3      ( Net__U1D1_Pad3_          ),
    .in4       ( Net__U1D1_Pad4_          ),
    .in5       ( Net__U1D1_Pad5_          ),
    .out6      ( Net__U1D1_Pad6_          ),
    .VSS       ( 1'b0                     ),
    .out8      ( Net__U1D1_Pad8_          ),
    .in9       ( Net__U1D1_Pad1_          ),
    .in10      ( BUSRQ                    ),
    .VDD       ( 1'b1                     )
);

jt74138 U1E1(
    .e1_b      ( Net__U1D1_Pad1_          ),
    .e2_b      ( DMEND                    ),
    .e3        ( Net__U1E1_Pad6_          ),
    .VSS       ( 1'b0                     ),
    .VDD       ( 1'b1                     ),
    .a         ({ 1'b0,
                  Net__U1E1_Pad2_,
                  Net__U1E1_Pad1_}),
    .y_b       ({ Net__U1E1_Pad7_,
                  Net__U1E1_Pad9_,
                  Net__U1E1_Pad10_,
                  Net__U1E1_Pad11_,
                  DMCS3n,
                  DMCS2n,
                  DMCS1n,
                  DMCS0n})
);

jt74161 U1F1(
    .cl_b      ( DMclr_n                  ),
    .clk       ( Net__U1B1_Pad6_          ),
    .cep       ( Net__U1D1_Pad6_          ),
    .VSS       ( 1'b0                     ),
    .ld_b      ( 1'b1                     ),
    .cet       ( Net__U1D1_Pad6_          ),
    .ca        ( Net__U1F1_Pad15_         ),
    .VDD       ( 1'b1                     ),
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
    .cl1_b     ( Net__U1L1_Pad1_          ),
    .d1        ( 1'b1                     ),
    .clk1      ( Net__U1L1_Pad3_          ),
    .pr1_b     ( 1'b1                     ),
    .q1        ( BUSRQ                    ),
    .q1_b      ( BUSRQn                   ),
    .VSS       ( 1'b0                     ),
    .VDD       ( 1'b1                     )
);

jt7474 U2(
    .cl1_b     ( Net__U1D1_Pad8_          ),
    .d1        ( Net__U1D1_Pad3_          ),
    .clk1      ( Net__U1D1_Pad5_          ),
    .pr1_b     ( 1'b1                     ),
    .q1        ( Net__U2_Pad5_            ),
    .q1_b      ( Net__U2_Pad6_            ),
    .VSS       ( 1'b0                     ),
    .q2_b      ( Net__U1B1_Pad12_         ),
    .q2        ( Net__U1B1_Pad10_         ),
    .pr2_b     ( 1'b1                     ),
    .clk2      ( AI                       ),
    .d2        ( DMclr_n                  ),
    .cl2_b     ( 1'b1                     ),
    .VDD       ( 1'b1                     )
);

jt7474 U2D1(
    .cl1_b     ( 1'b1                     ),
    .d1        ( BI                       ),
    .clk1      ( AI                       ),
    .pr1_b     ( 1'b1                     ),
    .q1        ( Net__U1D1_Pad5_          ),
    .q1_b      ( Net__U2D1_Pad6_          ),
    .VSS       ( 1'b0                     ),
    .q2_b      ( Net__U1D1_Pad1_          ),
    .q2        ( Net__U1D1_Pad4_          ),
    .pr2_b     ( 1'b1                     ),
    .clk2      ( Net__U1B1_Pad3_          ),
    .d2        ( BUSAK                    ),
    .cl2_b     ( 1'b1                     ),
    .VDD       ( 1'b1                     )
);

jt74161 U2E1(
    .cl_b      ( DMclr_n                  ),
    .clk       ( Net__U1B1_Pad6_          ),
    .cep       ( 1'b1                     ),
    .VSS       ( 1'b0                     ),
    .ld_b      ( 1'b1                     ),
    .cet       ( Net__U2E1_Pad10_         ),
    .ca        ( Net__U2E1_Pad15_         ),
    .VDD       ( 1'b1                     ),
    .d         ({ Net__U2E1_Pad6_,
                  Net__U2E1_Pad5_,
                  Net__U2E1_Pad4_,
                  Net__U2E1_Pad3_}),
    .q         ({ Net__U2E1_Pad11_,
                  DMEND,
                  Net__U1E1_Pad2_,
                  Net__U1E1_Pad1_})
);

jt74161 U2F1(
    .cl_b      ( DMclr_n                  ),
    .clk       ( Net__U1B1_Pad6_          ),
    .cep       ( 1'b1                     ),
    .VSS       ( 1'b0                     ),
    .ld_b      ( 1'b1                     ),
    .cet       ( Net__U1F1_Pad15_         ),
    .ca        ( Net__U2E1_Pad10_         ),
    .VDD       ( 1'b1                     ),
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
    .oe1_b     ( 1'b0                     ),
    .VSS       ( 1'b0                     ),
    .oe2_b     ( 1'b0                     ),
    .VDD       ( 1'b1                     ),
    .A         ({ Net__U2F1_Pad14_,
                  Net__U1F1_Pad13_,
                  Net__U1F1_Pad11_,
                  Net__U1F1_Pad14_,
                  Net__U2F1_Pad13_,
                  Net__U1F1_Pad12_}),
    .Y         ({ DM[4],
                  DM[1],
                  DM[3],
                  DM[0],
                  DM[5],
                  DM[2]})
);

jt7402 U2K1(
    .out1      ( Net__U1L1_Pad3_          ),
    .in2       ( VBn                      ),
    .in3       ( VBn                      ),
    .out4      ( Net__U1L1_Pad1_          ),
    .in5       ( RESET                    ),
    .in6       ( DMEND                    ),
    .VSS       ( 1'b0                     ),
    .VDD       ( 1'b1                     )
);

jt7400 U3(
    .in1       ( Net__U1D1_Pad3_          ),
    .in2       ( Net__U2_Pad6_            ),
    .out3      ( DMclr_n                  ),
    .VSS       ( 1'b0                     ),
    .VDD       ( 1'b1                     )
);

jt74367 U3E1(
    .oe1_b     ( DMCSpullup               ),
    .VSS       ( 1'b0                     ),
    .oe2_b     ( DMCSpullup               ),
    .VDD       ( 1'b1                     ),
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
    .oe1_b     ( Net__U3H1_Pad1_          ),
    .VSS       ( 1'b0                     ),
    .oe2_b     ( 1'b0                     ),
    .VDD       ( 1'b1                     ),
    .A         ({ Net__U2F1_Pad11_,
                  Net__U2F1_Pad12_,
                  Net__U3H1_Pad10_,
                  Net__U3H1_Pad6_,
                  Net__U3H1_Pad4_,
                  Net__U3H1_Pad2_}),
    .Y         ({ DM[7],
                  DM[6],
                  Net__U3H1_Pad9_,
                  Net__U3H1_Pad7_,
                  Net__U3H1_Pad5_,
                  Net__U3H1_Pad3_})
);

jt7437 U4(
    .in1       ( BUSAK_n                  ),
    .in2       ( BUSAK_n                  ),
    .out3      ( BUSAK                    ),
    .VSS       ( 1'b0                     ),
    .VDD       ( 1'b1                     )
);

jt74365 U4E1(
    .oe1_b     ( Net__U1D1_Pad1_          ),
    .VSS       ( 1'b0                     ),
    .oe2_b     ( DMEND                    ),
    .VDD       ( 1'b1                     ),
    .A         ({ 1'b0,
                  1'b0,
                  Net__U1F1_Pad13_,
                  Net__U2F1_Pad14_,
                  Net__U2F1_Pad13_,
                  Net__U2F1_Pad12_}),
    .Y         ({ DMCSpullup,
                  Net__U4E1_Pad5_,
                  AD[6],
                  AD[7],
                  AD[8],
                  AD[9]})
);

jt7402 U6C1(
    .out1      ( DMCS                     ),
    .in2       ( DMCSpullup               ),
    .in3       ( DMCSpullup               ),
    .VSS       ( 1'b0                     ),
    .VDD       ( 1'b1                     )
);

