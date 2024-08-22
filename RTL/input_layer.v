//Module for input layer with 49 neurons

module input_layer #(
    parameter integer sumMin = -32768,
    parameter integer sumMax = 32767,
    parameter integer weightsIn[0:48] //weights for each input
) (

    input wire clk,
    input wire [7:0] dataIn[0:48],
    output wire [7:0] neuron_output //8 bit neuron output after activation
);


    wire signed [31:0] accumulated_sum[0:48]; //accumulated sum
    reg signed [31:0]  sum_1, sum_2, sum_3, sum_4, sum_5, sum_6, sum_7;
    reg signed [31:0] sum;
    reg signed [15:0] final_sum; //16 bit sum for activation

    wire [15:0] address_sum; 
    wire [7:0] activated_sum;

    


endmodule 