module dmainit;

integer x,f0,f1,f2,f3;
reg [7:0] ram0[0:255];
reg [7:0] ram1[0:255];
reg [7:0] ram2[0:255];
reg [7:0] ram3[0:255];

initial begin
    for(x=0; x<256; x=x+1) begin
        ram0[x] = 8'd0;
        ram1[x] = 8'd0;
        ram2[x] = 8'd0;
        ram3[x] = 8'd0;
    end
    // Sprite in the middle of the screen
    ram0[4] = 8'd100;  // Y
    ram1[4] = 8'd140;  // X
    ram2[4] = 8'h1f;   // MSB=hflip, rest = ID
    ram3[4] = 8'h01;   // 4 = sprite bank, 3 = Y LSB, 2:0 = pal

    f0 = $fopen("dma_ram0.hex","w");
    f1 = $fopen("dma_ram1.hex","w");
    f2 = $fopen("dma_ram2.hex","w");
    f3 = $fopen("dma_ram3.hex","w");
    for(x=0; x<256; x=x+1) begin
        $fwrite( f0, "%h\n", ram0[x] );
        $fwrite( f1, "%h\n", ram1[x] );
        $fwrite( f2, "%h\n", ram2[x] );
        $fwrite( f3, "%h\n", ram3[x] );
    end
    $fclose(f0);
    $fclose(f1);
    $fclose(f2);
    $fclose(f3);
end

endmodule