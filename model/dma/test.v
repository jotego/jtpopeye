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
reg     BUSAK_n;
wire    BUSRQn;
wire    DMCS;
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
    forever #12.4 clk = ~clk;
end

integer blanks=0;

always @(posedge VB) begin
    $display("Vertical blank");
    blanks <= blanks+1;
    if(blanks==2) $finish;
end

`ifdef SIMTIME
real simtime = `SIMTIME;
initial begin
    $display("Simulation will finish after %.1f ms", simtime );
    simtime = simtime * 1000_000;
    #(simtime) $finish;
end
`endif

initial begin
    $dumpfile("test.lxt");
    $dumpvars(0,test.uut);
    $dumpvars(0,test.u_dmanew);    
    $dumpvars(1,test);    
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

wire         DOTCK;
wire   [7:0] DD;
pullup p1[7:0](DD);
pullup p0[9:0]( AD );

wire   CSBWn=1'b1;
wire   DWRBKn=1'b1;
wire   MEMWR0=1'b0;
wire   RVn=1'b1;
    
// Background
wire  [3:0] BAKC;
wire  [28:0] DO;    

dma uut(
    .RESET      ( ~rst_n    ),
    .ROHVCK     ( ROHVCK    ),
    .ROHVS      ( ROHVS     ),
    // from timing
    .H          ( H         ),
    .H2O        ( H2O       ),
    .V          ( V         ),
    .HBDn       ( HBDn      ),
    .HB         ( HB        ),
    .VB         ( VB        ),
    .DOTCK      ( DOTCK     ),
    // from CPU    
    .DD         ( DD        ),
    .AD         ( AD        ),
    .CSBWn      ( CSBWn     ),
    .DWRBKn     ( DWRBKn    ),
    .BUSAK_n    ( BUSAK_n   ),
    .MEMWR0     ( MEMWR0    ),
    .BUSRQn     ( BUSRQn    ),
    .RVn        ( RVn       ),
    
    // Background
    .BAKC       ( BAKC      ),
    .DMCS       ( DMCS      ),
    .DO         ( DO        )
);


wire [9:0] new_AD;
wire [28:0] new_DO;

reg new_busak_n=1'b1;
wire new_busrq_n;
wire new_dmacs;
wire new_ROHVS, new_ROHVCK;
always @(posedge clk)
    if(cpu_cen) new_busak_n <= new_busrq_n;

wire pre_HBDn;

jtpopeye_dma u_dmanew (
    .rst_n  (rst_n  ),
    .clk    (clk    ),
    .pxl_cen(pxl_cen),
    .VB     (VB     ),
    .H      (H[1:0] ),
    .HBD_n  (HBDn   ),
    .pre_HBDn( pre_HBDn ),
    .DD_DMA (new_AD[7:0]  ),
    .busak_n(new_busak_n),
    .ROHVS  (new_ROHVS  ),
    .ROHVCK (new_ROHVCK ),
    .AD_DMA (new_AD ),
    .dma_cs (new_dmacs ),
    .busrq_n(new_busrq_n),
    .DO     (new_DO     )
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
    .pre_HBDn  ( pre_HBDn ),
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
