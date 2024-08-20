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

    //Value for Cells
    reg [7:0] cell_00, cell_01, cell_02, cell_03, cell_04, cell_05, cell_06;
    reg [7:0] cell_10, cell_11, cell_12, cell_13, cell_14, cell_15, cell_16;
    reg [7:0] cell_20, cell_21, cell_22, cell_23, cell_24, cell_25, cell_26;
    reg [7:0] cell_30, cell_31, cell_32, cell_33, cell_34, cell_35, cell_36;
    reg [7:0] cell_40, cell_41, cell_42, cell_43, cell_44, cell_45, cell_46;
    reg [7:0] cell_50, cell_51, cell_52, cell_53, cell_54, cell_55, cell_56;
    reg [7:0] cell_60, cell_61, cell_62, cell_63, cell_64, cell_65, cell_66;


    //Line Memory (shift registers)
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            //reset cells to zero
        end else if (data_enable) begin 
            //Vertical shifts within columns (shift pixel data through line memories)

            //Horizontal shifts within rows (shift pixels within each line memory)

        end  
    end

    always @(posedge clk) begin

    end  


//the center pixel is output pixel that will be manipulated, while 7x7 grid is stored
endmodule 