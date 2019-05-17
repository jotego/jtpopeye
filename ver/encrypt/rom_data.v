// Use this module to translate an 8-bit value to the encrypted version
// Define DATA as the value to convert

module rom_data;

    wire [7:0] rom_data = `DATA; // Define DATA as the value to convert
    wire [7:0] rom_good = {
        rom_data[3], // MSB
        rom_data[4],
        rom_data[2],
        rom_data[5],
        rom_data[1],
        rom_data[6],
        rom_data[0],
        rom_data[7]  // LSB
    };

    initial begin
        #10;
        $display("%X -> %X\n", rom_data, rom_good );
    end

endmodule // popeye_romdata