module Proc_Element #(
    parameter DATA_SIZE = 8
)(
    input  logic clk,
    input  logic reset,
    input  logic clear,
    input  logic active,

    input  logic [DATA_SIZE-1:0] in_a,
    input  logic [DATA_SIZE-1:0] in_b,

    output logic [DATA_SIZE-1:0] out_a,
    output logic [DATA_SIZE-1:0] out_b,
    output logic [2*DATA_SIZE:0] out_c
);

    always_ff @(posedge clk) begin
        if (reset) begin
            out_a <= '0;
            out_b <= '0;
            out_c <= '0;
        end
        else if (clear) begin
            out_a <= '0;
            out_b <= '0;
            out_c <= '0;
        end
        else begin
            out_a <= in_a;
            out_b <= in_b;

            if (active)
                out_c <= out_c + in_a * in_b;
        end
    end

endmodule

