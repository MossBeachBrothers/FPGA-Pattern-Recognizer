module hidden_layer #(
    //min, max indices
    parameter integer sumMin = -32768,
    parameter integer sumMax = 32767,
    parameter integer weightsIn[0:36] //37 weights
)(
    input wire clk,
    input wire [7:0] dataIn[0:36], //8 bit input for each neuron
    output wire [7:0] neuron_output //8 bit output after activation
);    

    wire signed [31:0] accumulated_sum[0:36] //accumulated sum of neuron multiplications
    reg signed [31:0] sum_1, sum_2, sum_3, sum_4, sum_5, sum_6; //intermediate sums
    reg signed [31:0] sum;

    //16 bit sum for sigmoid
    reg signed [15:0] final_sum
    
    wire [15:0] address_sum;
    wire [7:0] activated_sum; //sum after activation
    