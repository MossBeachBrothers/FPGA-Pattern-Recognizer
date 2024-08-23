module top_module (
    input wire clk,
    input wire reset_n, // active low reset
    input wire [2:0] enable_in, // three slide switches to determine features

    // video in
    input wire sync_vertical_in, // vertical sync
    input wire sync_horizontal_in, // horizontal sync
    input wire data_sync_in, // data enable

    // RGB
    input wire [7:0] Rin,
    input wire [7:0] Gin,
    input wire [7:0] Bin,

    // video out
    output reg vs_out,
    output reg hs_out,
    output reg de_out,

    output reg [7:0] Rout,
    output reg [7:0] Gout,
    output reg [7:0] Bout,

    output wire clk_o, // output clock
    output wire clk_n_o, // inverted output clock
    output wire [2:0] led 
); 

    wire reset;
    wire [2:0] enable;
    reg vs_0, hs_0, de_0;
    reg [7:0] r_0, g_0, b_0;
    reg [7:0] result_to_luminance; // luminance score from RGB
    wire vs_1, hs_1, de_1; // delayed signals
    wire [7:0] npu_r, npu_g, npu_b; // NPU outputs

    reg [31:0] result; // for intermediate calculations

    always @(posedge clk) begin 
        vs_0 <= sync_vertical_in;
        hs_0 <= sync_horizontal_in;
        de_0 <= data_sync_in;
        r_0 <= Rin;
        g_0 <= Gin;
        b_0 <= Bin;

        // Convert RGB to luminance: Y = (5*R + 9*G + 2*B)/16
        result = (5 * r_0 + 9 * g_0 + 2 * b_0) / 16;
        result_to_luminance <= result[7:0];
    end 

    npu npu_inst (
        .clk(clk),
        .reset(reset),
        .data_enable(de_0),
        .data_in(result_to_luminance),
        .Rout(npu_r),
        .Gout(npu_g),
        .Bout(npu_b)
    );

    control #(
        .delay(21)
    ) control_inst (
        .clk(clk),
        .reset(reset),
        .vs_in(vs_0),
        .hs_in(hs_0),
        .de_in(de_0),
        .vs_out(vs_1),
        .hs_out(hs_1),
        .de_out(de_1)
    );

    //Output RGB values
    always @(posedge clk) begin 
        vs_out <= vs_1;
        hs_out <= hs_1;
        de_out <= de_1; 

        if (de_1) begin 
            Rout <= npu_r;
            Gout <= npu_g;
            Bout <= npu_b;
        end else begin 
            Rout <= 8'b0;
            Gout <= 8'b0;
            Bout <= 8'b0;
        end 
    end 

    assign clk_o = clk;
    assign clk_n_o = 1'b0;
    assign led = 3'b000;

    assign reset = ~reset_n;

endmodule
