module network (
    input wire clk,
    input wire reset,
    input wire data_enable,
    input wire [55:0] linear_mem1,
    input wire [55:0] linear_mem2,
    input wire [55:0] linear_mem3,
    input wire [55:0] linear_mem4,
    input wire [55:0] linear_mem5,
    input wire [55:0] linear_mem6,
    
    output reg [7:0] symbol1,
    output reg [7:0] symbol2,
    output reg [7:0] symbol3,
    output reg [7:0] symbol4
); 
endmodule 