module linear_memory (
    input wire clk,
    input wire reset,
    input wire write_enable, 
    input wire [7:0] data_in, //8 bit input pixel
    output reg [7:0] data_out //8 bit output pixel
);

//Array for SRAM, 1280 elements, 8 bits wide
reg [7:0] sram [0:1279]; 

//read and write addresses. These are length 11 by convention (log2(1280) = 11)
reg [10:0] write_address, read_address;

always @(posedge clk or posedge reset) begin 
    if (reset) begin 
        //reset everything if reset
    end else if (write_enable) begin 
        //if write, write to memory
        //update addresses
        write_address <= (write_address == 1279) ? 0 : write_address + 1;
        read_address <= (read_address == 1279) ? 0 : read_address + 1;
    end 

end

endmodule 

