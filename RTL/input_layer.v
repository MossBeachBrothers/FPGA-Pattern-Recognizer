// Module for input layer with 49 neurons
module input_layer #(
    parameter integer sumMin = -32768,
    parameter integer sumMax = 32767,
    parameter integer weightsIn[0:48]  // Weights for each input
) (
    input wire clk,
    input wire [7:0] dataIn[0:48],     
    output wire [7:0] neuron_output     
);

    wire signed [31:0] accumulated_sum[0:48]; 
    reg signed [31:0] sum_1, sum_2, sum_3, sum_4, sum_5, sum_6, sum_7;
    reg signed [31:0] sum;
    reg signed [15:0] final_sum; // 16-bit sum for activation

    wire [15:0] address_sum; 
    wire [7:0] activated_sum;

    
    genvar i;
    generate 
        for (i = 0; i < 49; i = i + 1) begin : multiplier_gen
            multiplier #(
                .weight(weightsIn[i])
            ) mult_inst (
                .clk(clk),
                .input_val(dataIn[i]),
                .output_val(accumulated_sum[i])
            );
        end
    endgenerate

    
    always @(posedge clk) begin 
        sum_1 <= accumulated_sum[0] + accumulated_sum[1] + accumulated_sum[2] + accumulated_sum[3] + accumulated_sum[4] + accumulated_sum[5] + accumulated_sum[6];
        sum_2 <= accumulated_sum[7] + accumulated_sum[8] + accumulated_sum[9] + accumulated_sum[10] + accumulated_sum[11] + accumulated_sum[12] + accumulated_sum[13];
        sum_3 <= accumulated_sum[14] + accumulated_sum[15] + accumulated_sum[16] + accumulated_sum[17] + accumulated_sum[18] + accumulated_sum[19] + accumulated_sum[20];
        sum_4 <= accumulated_sum[21] + accumulated_sum[22] + accumulated_sum[23] + accumulated_sum[24] + accumulated_sum[25] + accumulated_sum[26] + accumulated_sum[27];
        sum_5 <= accumulated_sum[28] + accumulated_sum[29] + accumulated_sum[30] + accumulated_sum[31] + accumulated_sum[32] + accumulated_sum[33] + accumulated_sum[34];
        sum_6 <= accumulated_sum[35] + accumulated_sum[36] + accumulated_sum[37] + accumulated_sum[38] + accumulated_sum[39] + accumulated_sum[40] + accumulated_sum[41];
        sum_7 <= accumulated_sum[42] + accumulated_sum[43] + accumulated_sum[44] + accumulated_sum[45] + accumulated_sum[46] + accumulated_sum[47] + accumulated_sum[48];
        
        sum <= sum_1 + sum_2 + sum_3 + sum_4 + sum_5 + sum_6 + sum_7;
        final_sum <= sum + weightsIn[48]; // Add bias to sum
    end 

    
    always @(posedge clk) begin 
        if (final_sum < sumMin) begin 
            // Min edge case
            address_sum <= 16'b0;
        end else if (final_sum > sumMax) begin 
            // Max edge case
            address_sum <= 16'hFFFF;
        end else begin 
            address_sum <= final_sum + 32768;
        end
    end 

    
    sigmoid_IP sigmoid_inst (
        .clock(clk),
        .address(address_sum[15:4]),  
        .q(activated_sum)
    );

    
    assign neuron_output = activated_sum;

endmodule
