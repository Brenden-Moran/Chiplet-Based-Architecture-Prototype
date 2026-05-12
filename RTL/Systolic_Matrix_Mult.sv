// ============================================================
// Systolic_Matrix_Mult.sv
// Cleaned control: separate clear pulse from start
// ============================================================
module Systolic_Matrix_Mult #(
    parameter int DATA_SIZE = 8,
    parameter int MAX_N     = 10
)(
    input  logic clk,
    input  logic reset,
    input  logic start,
    input  logic [$clog2(MAX_N):0] N,

    input  logic [DATA_SIZE-1:0] A [MAX_N][MAX_N],
    input  logic [DATA_SIZE-1:0] B [MAX_N][MAX_N],

    output logic done,
    output logic [2*DATA_SIZE:0] C [MAX_N][MAX_N]
);

    logic running;
    logic clear_pe;

    // cycle_counter is systolic time t
    logic [$clog2(3*MAX_N):0] cycle_counter;

    logic [DATA_SIZE-1:0] a_bus [MAX_N][MAX_N];
    logic [DATA_SIZE-1:0] b_bus [MAX_N][MAX_N];

    int unsigned t;
    always_comb t = int'(cycle_counter);

    //-------------------------------------------------
    // Control
    //
    // On start:
    //   cycle 1: clear_pe = 1, cycle_counter = 0, running = 0
    //   cycle 2+: clear_pe = 0, running = 1, begin compute at t=0
    //
    // This guarantees:
    //   - PE accumulators cleared exactly once
    //   - t=0 is used exactly once
    //   - no double-count of first product
    //-------------------------------------------------
    always_ff @(posedge clk) begin
        if (reset) begin
            running       <= 1'b0;
            clear_pe      <= 1'b0;
            done          <= 1'b0;
            cycle_counter <= '0;
        end
        else begin
            // default
            done <= 1'b0;

            if (start) begin
                running       <= 1'b0;
                clear_pe      <= 1'b1;
                cycle_counter <= '0;
                done          <= 1'b0;
            end
            else if (clear_pe) begin
                // one cycle after clear, begin computation at t=0
                clear_pe      <= 1'b0;
                running       <= 1'b1;
                cycle_counter <= '0;
            end
            else if (running) begin
                // last useful compute time is t = 3N - 3
                if (cycle_counter == (3*N - 3)) begin
                    running <= 1'b0;
                    done    <= 1'b1;
                end
                else begin
                    cycle_counter <= cycle_counter + 1'b1;
                end
            end
        end
    end

    //-------------------------------------------------
    // Generate systolic array
    //
    // At time t:
    //   Row i injects A[i][k] into col0 when t = i + k
    //   Col j injects B[k][j] into row0 when t = j + k
    //   PE(i,j) computes k when t = i + j + k
    //-------------------------------------------------
    genvar i, j;
    generate
        for (i = 0; i < MAX_N; i++) begin : ROW
            for (j = 0; j < MAX_N; j++) begin : COL

                localparam int I = i;
                localparam int J = j;

                logic a_in_valid, b_in_valid, pe_valid;

                int signed k_left;
                int signed k_top;
                int signed k_pe;

                always_comb begin
                    k_left = int'(t) - I;
                    k_top  = int'(t) - J;
                    k_pe   = int'(t) - I - J;

                    a_in_valid = running && (J == 0) &&
                                 (I < int'(N)) &&
                                 (k_left >= 0) && (k_left < int'(N));

                    b_in_valid = running && (I == 0) &&
                                 (J < int'(N)) &&
                                 (k_top >= 0)  && (k_top < int'(N));

                    pe_valid   = running &&
                                 (I < int'(N)) && (J < int'(N)) &&
                                 (k_pe >= 0)   && (k_pe < int'(N));
                end

                Proc_Element #(.DATA_SIZE(DATA_SIZE)) pe_inst (
                    .clk   (clk),
                    .reset (reset),
                    .clear (clear_pe),
                    .active(pe_valid),

                    .in_a(
                        (J == 0) ? (a_in_valid ? A[I][k_left] : '0)
                                 : a_bus[I][J-1]
                    ),

                    .in_b(
                        (I == 0) ? (b_in_valid ? B[k_top][J] : '0)
                                 : b_bus[I-1][J]
                    ),

                    .out_a(a_bus[I][J]),
                    .out_b(b_bus[I][J]),
                    .out_c(C[I][J])
                );

            end
        end
    endgenerate

endmodule

