module matmul_stream_core #(
    parameter int DATA_SIZE = 8,
    parameter int MAX_N     = 10
)(
    input  logic clk,
    input  logic rstn,

    input  logic start_pulse,
    input  logic [$clog2(MAX_N):0] N,
    output logic busy,
    output logic done,

    // AXIS input A
    input  logic        s_axis_a_tvalid,
    output logic        s_axis_a_tready,
    input  logic [31:0] s_axis_a_tdata,
    input  logic        s_axis_a_tlast,

    // AXIS input B
    input  logic        s_axis_b_tvalid,
    output logic        s_axis_b_tready,
    input  logic [31:0] s_axis_b_tdata,
    input  logic        s_axis_b_tlast,

    // AXIS output C
    output logic        m_axis_c_tvalid,
    input  logic        m_axis_c_tready,
    output logic [31:0] m_axis_c_tdata,
    output logic        m_axis_c_tlast
);

    typedef enum logic [2:0] {
        ST_IDLE   = 3'd0,
        ST_LOAD_A = 3'd1,
        ST_LOAD_B = 3'd2,
        ST_COMP   = 3'd3,
        ST_SEND_C = 3'd4,
        ST_DONE   = 3'd5
    } state_t;

    state_t st, st_d;

    logic [DATA_SIZE-1:0] A_buf [MAX_N][MAX_N];
    logic [DATA_SIZE-1:0] B_buf [MAX_N][MAX_N];
    logic [2*DATA_SIZE:0] C_wire [MAX_N][MAX_N];

    logic core_done;
    logic core_start_pulse;

    int unsigned a_count, b_count, c_count;
    int unsigned nn;
    always_comb nn = int'(N) * int'(N);

    function automatic int unsigned row_of(input int unsigned idx);
        row_of = idx / int'(N);
    endfunction

    function automatic int unsigned col_of(input int unsigned idx);
        col_of = idx % int'(N);
    endfunction

    // detect entry into ST_COMP
    always_ff @(posedge clk) begin
        if (!rstn)
            st_d <= ST_IDLE;
        else
            st_d <= st;
    end

    assign core_start_pulse = (st == ST_COMP) && (st_d != ST_COMP);

    Systolic_Matrix_Mult #(
        .DATA_SIZE(DATA_SIZE),
        .MAX_N(MAX_N)
    ) u_core (
        .clk   (clk),
        .reset (~rstn),
        .start (core_start_pulse),
        .N     (N),
        .A     (A_buf),
        .B     (B_buf),
        .done  (core_done),
        .C     (C_wire)
    );

    // defaults
    always_comb begin
        s_axis_a_tready = 1'b0;
        s_axis_b_tready = 1'b0;
        m_axis_c_tvalid = 1'b0;
        m_axis_c_tdata  = 32'h0;
        m_axis_c_tlast  = 1'b0;

        busy = (st != ST_IDLE) && (st != ST_DONE);
        done = (st == ST_DONE);

        if (st == ST_LOAD_A && a_count < nn)
            s_axis_a_tready = 1'b1;

        if (st == ST_LOAD_B && b_count < nn)
            s_axis_b_tready = 1'b1;

        if (st == ST_SEND_C && c_count < nn) begin
            int unsigned r, c;
            r = row_of(c_count);
            c = col_of(c_count);
            m_axis_c_tvalid = 1'b1;
            m_axis_c_tdata  = {{(32-(2*DATA_SIZE+1)){1'b0}}, C_wire[r][c]};
            m_axis_c_tlast  = (c_count == (nn-1));
        end
    end

    always_ff @(posedge clk) begin
        if (!rstn) begin
            st      <= ST_IDLE;
            a_count <= 0;
            b_count <= 0;
            c_count <= 0;
        end else begin
            case (st)
                ST_IDLE: begin
                    a_count <= 0;
                    b_count <= 0;
                    c_count <= 0;
                    if (start_pulse)
                        st <= ST_LOAD_A;
                end

                ST_LOAD_A: begin
                    if (s_axis_a_tvalid && s_axis_a_tready) begin
                        int unsigned r, c;
                        r = row_of(a_count);
                        c = col_of(a_count);
                        A_buf[r][c] <= s_axis_a_tdata[DATA_SIZE-1:0];
                        if (a_count + 1 >= nn)
                            st <= ST_LOAD_B;
                        a_count <= a_count + 1;
                    end
                end

                ST_LOAD_B: begin
                    if (s_axis_b_tvalid && s_axis_b_tready) begin
                        int unsigned r, c;
                        r = row_of(b_count);
                        c = col_of(b_count);
                        B_buf[r][c] <= s_axis_b_tdata[DATA_SIZE-1:0];
                        if (b_count + 1 >= nn)
                            st <= ST_COMP;
                        b_count <= b_count + 1;
                    end
                end

                ST_COMP: begin
                    if (core_done) begin
                        c_count <= 0;
                        st <= ST_SEND_C;
                    end
                end

                ST_SEND_C: begin
                    if (m_axis_c_tvalid && m_axis_c_tready) begin
                        if (c_count + 1 >= nn)
                            st <= ST_DONE;
                        c_count <= c_count + 1;
                    end
                end

                ST_DONE: begin
                    if (start_pulse) begin
                        a_count <= 0;
                        b_count <= 0;
                        c_count <= 0;
                        st <= ST_LOAD_A;
                    end
                end

                default: st <= ST_IDLE;
            endcase
        end
    end

endmodule
