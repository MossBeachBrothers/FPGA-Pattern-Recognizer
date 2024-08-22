module control #(
    parameter DELAYTIME = 7
) (
    input wire clk,
    input wire reset,
    input wire vs_in,
    input wire hs_in,
    input wire de_in,

    output wire vs_out,
    output wire hs_out,
    output wire de_out
);


    reg vertical_delay [DELAYTIME-1:0];
    reg horizontal_delay [DELAYTIME-1:0];
    reg data_delay [DELAYTIME-1:0];

    integer i;



endmodule 


