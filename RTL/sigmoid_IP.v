module sigmoid_IP (
    input  wire [11:0] address,  // 12-bit address input
    input  wire        clock,    // clock input
    output reg  [7:0]  q         // 8-bit data output
);

    // Define the ROM array to store sigmoid values
    reg [7:0] rom [0:4095];

    // Load ROM contents from file and print the first few entries for debugging
    initial begin
        $readmemh("sigmoid_data.hex", rom);  // Load the ROM with the contents of the hex file
        
        // Debugging: Print the first few ROM values
        $display("ROM Initialization:");
        $display("ROM[0] = %h", rom[0]);
        $display("ROM[1] = %h", rom[1]);
        $display("ROM[2] = %h", rom[2]);
        $display("ROM[56] = %h", rom[56]);
        $display("ROM[112] = %h", rom[112]);
        $display("ROM[4095] = %h", rom[4095]);
    end

    // Output the sigmoid value corresponding to the address
    always @(posedge clock) begin
        q <= rom[address];
    end

endmodule
