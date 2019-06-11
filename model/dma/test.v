`timescale 1ns/1ps

module test;

reg     rst_n;
reg     clk;
wire    pxl2_cen;
wire    pxl_cen;
wire    [7:0] V;
wire    [7:0] H;
wire    H2O;
wire    HB;
wire    INITEO;
wire    SY_n;
wire    HS;
wire    VS;

wire    ROHVCK;
wire    ROHVS;
wire    [9:0] AD;
wire    AIn = ~H[0];
wire    BIn = ~H[1];
reg     BUSAK_n;
wire    BUSRQn;
wire    DMCS;
wire [3:0]   DMCSn;
wire    [7:0] DM;
wire    HBDn;
wire    VB;

wire    cpu_cen;

initial begin
    rst_n = 1'b0;
    #50 rst_n = 1'b1;
end

initial begin
    clk = 1'b0;
    forever #20 clk = ~clk;
end

integer blanks=0;

always @(posedge VB) begin
    $display("Vertical blank");
    blanks <= blanks+1;
    if(blanks==2) $finish;
end

initial begin
    $dumpfile("test.lxt");
    $dumpvars;
    $dumpon;
end

jtpopeye_cen u_cen (
    .clk     (clk     ),
    .cpu_cen (cpu_cen ),
    .pxl_cen (pxl_cen ),
    .pxl2_cen(pxl2_cen)
);

always @(posedge clk)
    if(cpu_cen) BUSAK_n <= BUSRQn;

pullup p0[9:0]( AD );

dma uut(
    .RESET      ( ~rst_n    ),
    .ROHVCK     ( ROHVCK    ),
    .ROHVS      ( ROHVS     ),
    .AD         ( AD        ),
    .AIn        ( AIn       ),
    .BIn        ( BIn       ),
    .BUSAK_n    ( BUSAK_n   ),
    .BUSRQn     ( BUSRQn    ),
    .DMCS       ( DMCS      ),
    .DMCS0n     ( DMCSn[0]  ),
    .DMCS1n     ( DMCSn[1]  ),
    .DMCS2n     ( DMCSn[2]  ),
    .DMCS3n     ( DMCSn[3]  ),
    .DM         ( DM        ),
    .HBDn       ( HBDn      ),
    .VB         ( VB        )
);

jtpopeye_timing u_timing (
    .rst_n     (rst_n     ),
    .clk       (clk       ),
    .pxl2_cen  (pxl2_cen  ),
    .pxl_cen   (pxl_cen   ),
    .RV_n      (1'b1      ),
    .V         (V         ),
    .H         (H         ),
    .H2O       (H2O       ),
    .HB        (HB        ),
    .HBD_n     (HBDn      ),
    .VB        (VB        ),
    .INITEO    (INITEO    ),
    .SY_n      (SY_n      ),
    .HS        (HS        ),
    .VS        (VS        ),
    .prog_addr (8'd0      ),
    .prom_7j_we(1'b0      ),
    .prom_din  (4'd0      )
);



endmodule