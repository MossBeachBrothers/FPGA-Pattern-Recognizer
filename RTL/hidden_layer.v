// Hidden layer module with 37 neurons
module hidden_layer #(
    parameter integer sumMin = -32768,       // Minimum value for sum range
    parameter integer sumMax = 32767,        // Maximum value for sum range
    parameter integer weightsIn[0:36]      
)(
    input wire clk,                          
    input wire [7:0] dataIn[0:36],           
    output wire [7:0] neuron_output          
);

    // Internal signals
    wire signed [31:0] accumulated_sum[0:36];  // Accumulated sums from multiplications
    reg signed [31:0] sum_1, sum_2, sum_3, sum_4, sum_5, sum_6;  // Intermediate sums
    reg signed [31:0] sum;                     
    reg signed [15:0] final_sum;              

    wire [15:0] address_sum;                   
    wire [7:0] activated_sum; //8 bit sum after activation

    // Generate multipliers for each input neuron and weight
    genvar i;
    generate 
        for (i = 0; i < 37; i = i + 1) begin : multiplier_gen
            multiplier #(
                .weight(weightsIn[i])
            ) mult_inst (
                .clk(clk),
                .input_val(dataIn[i]),
                .output_val(accumulated_sum[i])
            );
        end
    endgenerate

    // Accumulate the sum in stages and add bias
    always @(posedge clk) begin
        sum_1 <= accumulated_sum[0] + accumulated_sum[1] + accumulated_sum[2] + accumulated_sum[3] + accumulated_sum[4] + accumulated_sum[5];
        sum_2 <= accumulated_sum[6] + accumulated_sum[7] + accumulated_sum[8] + accumulated_sum[9] + accumulated_sum[10] + accumulated_sum[11];
        sum_3 <= accumulated_sum[12] + accumulated_sum[13] + accumulated_sum[14] + accumulated_sum[15] + accumulated_sum[16] + accumulated_sum[17];
        sum_4 <= accumulated_sum[18] + accumulated_sum[19] + accumulated_sum[20] + accumulated_sum[21] + accumulated_sum[22] + accumulated_sum[23];
        sum_5 <= accumulated_sum[24] + accumulated_sum[25] + accumulated_sum[26] + accumulated_sum[27] + accumulated_sum[28] + accumulated_sum[29];
        sum_6 <= accumulated_sum[30] + accumulated_sum[31] + accumulated_sum[32] + accumulated_sum[33] + accumulated_sum[34] + accumulated_sum[35] + accumulated_sum[36];
        
        sum <= sum_1 + sum_2 + sum_3 + sum_4 + sum_5 + sum_6;
        final_sum <= sum + weightsIn[36]; // Add the last weight which is bias
    end

    // Limit the final sum to the range of the sigmoid lookup table
    always @(posedge clk) begin 
        if (final_sum < sumMin) begin 
            address_sum <= 16'b0;            // Minimum edge case
        end else if (final_sum > sumMax) begin 
            address_sum <= 16'hFFFF;         // Maximum edge case
        end else begin 
            address_sum <= final_sum + 32768; // Adjust to positive range
        end
    end 

    // Sigmoid activation via lookup table
    sigmoid_IP sigmoid_inst (
        .clock(clk),
        .address(address_sum[15:4]),         // Use 12 MSBs for address
        .q(activated_sum)                    // 8-bit result after activation
    ); 

    // Output the activated sum
    assign neuron_output = activated_sum;

endmodule
