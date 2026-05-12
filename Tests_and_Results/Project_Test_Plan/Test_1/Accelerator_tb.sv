`timescale 1ns/1ps

module tb_Systolic_Matrix_Mult;

    parameter int DATA_SIZE = 32;
    parameter int MAX_N     = 20;
    localparam int C_W      = (2*DATA_SIZE + 1);

    logic clk;
    logic reset;
    logic start;
    logic done;

    logic [$clog2(MAX_N):0] N;

    logic [DATA_SIZE-1:0] A [MAX_N][MAX_N];
    logic [DATA_SIZE-1:0] B [MAX_N][MAX_N];
    logic [C_W-1:0]        C [MAX_N][MAX_N];

    Systolic_Matrix_Mult #(
        .DATA_SIZE(DATA_SIZE),
        .MAX_N(MAX_N)
    ) dut (
        .clk(clk),
        .reset(reset),
        .start(start),
        .N(N),
        .A(A),
        .B(B),
        .done(done),
        .C(C)
    );

    // 10ns clock
    always #5 clk = ~clk;

    task automatic init_matrices(input int size);
        int i, j;
        begin
            for (i = 0; i < MAX_N; i++) begin
                for (j = 0; j < MAX_N; j++) begin
                    if (i < size && j < size) begin
                        A[i][j] = i + j + 1;
                        B[i][j] = (i == j) ? 1 : 0; // identity
                    end
                    else begin
                        A[i][j] = '0;
                        B[i][j] = '0;
                    end
                end
            end
        end
    endtask

    task automatic print_result(input int size);
        int i, j;
        begin
            $display("\nResult Matrix C (%0dx%0d) [hex]:", size, size);
            for (i = 0; i < size; i++) begin
                for (j = 0; j < size; j++) begin
                    $write("%0h ", C[i][j]);
                end
                $write("\n");
            end
        end
    endtask

task automatic check_result(input int size);
    int i, j, k;
    logic [C_W-1:0] golden;
    int errors;
    begin
        errors = 0;

        for (i = 0; i < size; i++) begin
            for (j = 0; j < size; j++) begin
                golden = '0;

                for (k = 0; k < size; k++) begin
                    golden = golden + (A[i][k] * B[k][j]);
                end

                if (C[i][j] !== golden) begin
                    $display("MISMATCH C[%0d][%0d]: got=%0h exp=%0h",
                             i, j, C[i][j], golden);
                    errors++;
                end
            end
        end

        if (errors == 0)
            $display("PASS: %0dx%0d", size, size);
        else
            $display("FAIL: %0dx%0d (errors=%0d)", size, size, errors);
    end
endtask


    task automatic soft_reset();
        begin
            reset = 1;
            start = 0;
            @(posedge clk);
            @(posedge clk);
            reset = 0;
            @(posedge clk);
        end
    endtask

    task automatic run_test(input int size);
        int unsigned max_cycles;
        begin
            $display("\nStarting %0dx%0d Test...", size, size);

            soft_reset();

            N = size;
            init_matrices(size);

            // start pulse 1 cycle
            start = 1;
            @(posedge clk);
            start = 0;

            // last useful time is t=3N-3; add margin
            max_cycles = 10*MAX_N + 200;

            fork
                begin : WAIT_DONE
                    wait(done === 1'b1);
                end
                begin : TIMEOUT
                    repeat (max_cycles) @(posedge clk);
                    $fatal(1, "TIMEOUT waiting for done (size=%0d)", size);
                end
            join_any
            disable fork;

            @(posedge clk);

            print_result(size);
            check_result(size);
        end
    endtask

    initial begin
        clk   = 0;
        reset = 1;
        start = 0;
        N     = '0;

        @(posedge clk);
        @(posedge clk);
        reset = 0;

        run_test(5);
        run_test(10);

        $display("\nSimulation Complete");
        $finish;
    end

endmodule

