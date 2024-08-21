module multiplier #(
    parameter weight = 1, //Weight param
    parameter outputMin = -32768, //output min max for ROM 
    parameter outputMax = 32768
)(
    input wire clk,
    input wire [7:0] data_in, //8 bit input
    output reg signed [31:0] data_out  //signed output 
); 

    always @(posedge clk) begin 
        
    end 
endmodule 