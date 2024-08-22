//Module for input layer with 49 neurons

module input_layer #(
    parameter integer sumMin = -32768,
    parameter integer sumMax = 32767,
    parameter integer weightsIn[0:48]
) (

    input wire clk,
    input wire [7:0] dataIn
    output wire [7:0] neuron_output //8 bit neuron output after activation
);