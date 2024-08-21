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

    //Multiply input by each neuron weight
    genvar i;
    generate 
        for (i=0; i<37; i=i+1) begin : multiplier_gen
            multiplier #(
                .weight(weightsIn[i])
            ) mult_inst (
                .clk(clk),
                .data_in(dataIn[i]),
                .data_out(accumulated_sum[i])
            );
         end 
    endgenerate


    always @(posedge clk) begin 
        if (activated_sum < sumMin) begin 
            //if less than min set 0
        end else if (activated_sum > sumMax) begin 
            //if max set upper bound infinity
        end else begin 
            address_sum = //set address
        end 
    end 

    always @(posedge clk) begin

    end

    sigmoid_IP sigmoid_inst (

    ); 

    assign neuron_output = activated_sum; //set output to sum after activation

endmodule 
