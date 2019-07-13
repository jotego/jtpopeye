module objtest;

integer x;
initial begin
    // Bank, palette, X count, V
    // 0-3
    $display("%h", 18'b0_010_00_0_10001000_000);
    $display("%h", 18'b0_010_00_0_10001001_000);
    $display("%h", 18'b0_010_00_0_10001010_000);
    $display("%h", 18'b0_010_00_0_10001011_000);


    for(x=8; x<64; x=x+1)
        $display("%h", 18'b0);
        
    // 4-7
    $display("%h", 18'b0_010_00_0_10001100_000);
    $display("%h", 18'b0_010_00_0_10001101_000);
    $display("%h", 18'b0_010_00_0_10001110_000);
    $display("%h", 18'b0_010_00_0_10001111_000);
end

endmodule