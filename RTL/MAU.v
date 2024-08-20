//Memory Access Unit
//7 line memories (shift registers) and constructs a 7x7 grid
module MAU (
    input wire clk,
    input wire reset,
    input wire data_enable,
    input wire [7:0] data_in,

    output reg [7:0] data_out,

    output reg [55:0] linear_mem1,
    output reg [55:0] linear_mem2,
    output reg [55:0] linear_mem3,
    output reg [55:0] linear_mem4,
    output reg [55:0] linear_mem5,
    output reg [55:0] linear_mem6,
    output reg [55:0] linear_mem7,
);

//the center pixel is output pixel that will be manipulated, while 7x7 grid is stored
endmodule 