module objcmp;

reg [7:0] v=8'd0;
reg [7:0] y=8'd100;
wire [7:0] ycomp = ~y;
wire [7:0] s;
wire c0,c1,c3;

initial begin
    forever #100 { y, v } = { y, v } + 16'd1;
end 

initial begin
    $dumpfile("test.lxt");
    $dumpvars;
    #(100*256*30) $finish;
end

jt74283 u_3s(
    .a( v[3:0] ),
    .b( y[3:0] ),
    .cin( 1'b0 ),
    .s( s[3:0] ),
    .cout( c0     )
);

jt74283 u_3r(
    .a( v[7:4] ),
    .b( y[7:4] ),
    .cin( c0 ),
    .s( s[7:4] ),
    .cout( c1     )
);

jt74283 u_3t(
    .a( s[7:4] ),
    .b( 4'hf   ),
    .cin( s[3] ),
    .s(        ),
    .cout( c3     )
);


endmodule