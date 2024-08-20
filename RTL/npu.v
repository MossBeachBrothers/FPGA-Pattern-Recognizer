module npu(
    input wire clk,
    input wire reset,
    input wire data_enable, //data in enable
    input wire [7:0] data_in, //input data, 8 bit
    
    output reg [7:0] r_out, 
    output reg [7:0] g_out,
    output reg [7:0] b_out,
);

//Line Memory: Line of 7 pixels, 8 bits each (56 bit wide data for each line in 7 lines of 7)
reg [55:0] linear_mem1, linear_mem2, linear_mem3, linear_mem4, linear_mem5, linear_mem6, linear_mem7; 

reg [7:0] current_pixel; //current pixel, output of memory unit
reg [7:0] delayed_pixel; //delayed value of pixel, held back to align with classification result 

reg [7:0] symbol1, symbol2, symbol3, symbol4; //signals for output probability distribution of NN for each pixel




MAU memory_inst (
    .clk(clk),
    .reset(reset),
    .data_enable(data_enable),
    .data_in(data_in),
    .data_out(pixel_0), //center of 7x7 grid
    //line memories
    .linear_mem1(linear_mem1),
    .linear_mem2(linear_mem2),
    .linear_mem3(linear_mem3),
    .linear_mem4(linear_mem4),
    .linear_mem5(linear_mem5),
    .linear_mem6(linear_mem6),
    .linear_mem7(linear_mem7) 
 
);

network nn_inst (
    .clk(clk),
    .reset(reset),
    .data_enable(data_enable),
    .linear_mem1(linear_mem1),
    .linear_mem2(linear_mem2),
    .linear_mem3(linear_mem3),
    .linear_mem4(linear_mem4),
    .linear_mem5(linear_mem5),
    .linear_mem6(linear_mem6),
    .symbol1(symbol1),
    .symbol2(symbol2),
    .symbol3(symbol3) 
);

//delay pixel output until neural network is done with classification
pixel_control  #(.delay(16)) pixel_delay ( 
    .clk(clk),
    .input_pixel(current_pixel),
    .output_pixel(delayed_pixel)
);

display_mux mux_inst (
    .clk(clk),
    .data_enable(current_pixel),
    .symbol1(symbol1),
    .symbol2(symbol2),
    .symbol3(symbol3),
    .rout(r_out), //RGB pixel output color
    .gout(g_out),
    .bout(b_out)
);
    

endmodule 