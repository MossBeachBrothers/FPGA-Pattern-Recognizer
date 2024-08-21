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
    output reg [55:0] linear_mem7
);

    //Value for Cells
    reg [7:0] cell_00, cell_01, cell_02, cell_03, cell_04, cell_05, cell_06;
    reg [7:0] cell_10, cell_11, cell_12, cell_13, cell_14, cell_15, cell_16;
    reg [7:0] cell_20, cell_21, cell_22, cell_23, cell_24, cell_25, cell_26;
    reg [7:0] cell_30, cell_31, cell_32, cell_33, cell_34, cell_35, cell_36;
    reg [7:0] cell_40, cell_41, cell_42, cell_43, cell_44, cell_45, cell_46;
    reg [7:0] cell_50, cell_51, cell_52, cell_53, cell_54, cell_55, cell_56;
    reg [7:0] cell_60, cell_61, cell_62, cell_63, cell_64, cell_65, cell_66;
    
    //the center pixel is output pixel that will be manipulated, while 7x7 grid is stored
    wire [7:0] tap_66; //input for bottom-right pixel of grid



    //Line Memory Modules. The first pixel array does not need to be delayed, as it is accessed directly 
    linear_memory mem1 (
        .clk(clk),
        .reset(reset)
        write_enable(data_enable),
        .data_in(tap_66),
        .data_out(cell_56)
    );
    
    linear_memory mem2 (
        .clk(clk),
        .reset(reset)
        write_enable(data_enable),
        .data_in(cell_56),
        .data_out(cell_46)
    );

    linear_memory mem3 (
        .clk(clk),
        .reset(reset)
        write_enable(data_enable),
        .data_in(cell_46),
        .data_out(cell_36)
    );

    linear_memory mem4 (
        .clk(clk),
        .reset(reset)
        write_enable(data_enable),
        .data_in(cell_36),
        .data_out(cell_26)
    );

    linear_memory mem5 (
        .clk(clk),
        .reset(reset)
        write_enable(data_enable),
        .data_in(cell_26),
        .data_out(cell_16)
    );

    linear_memory mem6 (
        .clk(clk),
        .reset(reset)
        write_enable(data_enable),
        .data_in(cell_16),
        .data_out(cell_06)
    );
    

    //Line Memory (shift registers)
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            //reset cells to zero
            cell_00 <= 8'b0; cell_01 <= 8'b0; cell_02 <= 8'b0; cell_03 <= 8'b0; cell_04 <= 8'b0; cell_05 <= 8'b0; cell_06 <= 8'b0;
            cell_10 <= 8'b0; cell_11 <= 8'b0; cell_12 <= 8'b0; cell_13 <= 8'b0; cell_14 <= 8'b0; cell_15 <= 8'b0; cell_16 <= 8'b0;
            cell_20 <= 8'b0; cell_21 <= 8'b0; cell_22 <= 8'b0; cell_23 <= 8'b0; cell_24 <= 8'b0; cell_25 <= 8'b0; cell_26 <= 8'b0;
            cell_30 <= 8'b0; cell_31 <= 8'b0; cell_32 <= 8'b0; cell_33 <= 8'b0; cell_34 <= 8'b0; cell_35 <= 8'b0; cell_36 <= 8'b0;
            cell_40 <= 8'b0; cell_41 <= 8'b0; cell_42 <= 8'b0; cell_43 <= 8'b0; cell_44 <= 8'b0; cell_45 <= 8'b0; cell_46 <= 8'b0;
            cell_50 <= 8'b0; cell_51 <= 8'b0; cell_52 <= 8'b0; cell_53 <= 8'b0; cell_54 <= 8'b0; cell_55 <= 8'b0; cell_56 <= 8'b0;
            cell_60 <= 8'b0; cell_61 <= 8'b0; cell_62 <= 8'b0; cell_63 <= 8'b0;
        end else if (data_enable) begin 
            //Shift pixels between lines
            cell_05 <= cell_06; cell_04 <= cell_05; cell_03 <= cell_04; cell_02 <= cell_03; cell_01 <= cell_02; cell_00 <= cell_01;
            cell_15 <= cell_16; cell_14 <= cell_15; cell_13 <= cell_14; cell_12 <= cell_13; cell_11 <= cell_12; cell_10 <= cell_11;
            cell_25 <= cell_26; cell_24 <= cell_25; cell_23 <= cell_24; cell_22 <= cell_23; cell_21 <= cell_22; cell_20 <= cell_21;
            cell_35 <= cell_36; cell_34 <= cell_35; cell_33 <= cell_34; cell_32 <= cell_33; cell_31 <= cell_32; cell_30 <= cell_31;
            cell_45 <= cell_46; cell_44 <= cell_45; cell_43 <= cell_44; cell_42 <= cell_43; cell_41 <= cell_42; cell_40 <= cell_41;
            cell_55 <= cell_56; cell_54 <= cell_55; cell_53 <= cell_54; cell_52 <= cell_53; cell_51 <= cell_52; cell_50 <= cell_51;
            cell_65 <= cell_66; cell_64 <= cell_65; cell_63 <= cell_64; cell_62 <= cell_63; cell_61 <= cell_62; cell_60 <= cell_61;

        end  
    end

    always @(posedge clk) begin
        //assign cell values to line memory outputs
        linear_mem1 <= {cell_00, cell_01, cell_02, cell_03, cell_04, cell_05, cell_06};
        linear_mem2 <= {cell_10, cell_11, cell_12, cell_13, cell_14, cell_15, cell_16};
        linear_mem3 <= {cell_20, cell_21, cell_22, cell_23, cell_24, cell_25, cell_26};
        linear_mem4 <= {cell_30, cell_31, cell_32, cell_33, cell_34, cell_35, cell_36};
        linear_mem5 <= {cell_40, cell_41, cell_42, cell_43, cell_44, cell_45, cell_46};
        linear_mem6 <= {cell_50, cell_51, cell_52, cell_53, cell_54, cell_55, cell_56};
        linear_mem7 <= {cell_60, cell_61, cell_62, cell_63, cell_64, cell_65, cell_66};

        //assign output from center
        data_out <= cell_33;
    end  


endmodule 