`timescale 1 ns / 1 ps

module Accelerator_Stream #
(
    parameter integer C_S00_AXI_DATA_WIDTH    = 32,
    parameter integer C_S00_AXI_ADDR_WIDTH    = 4,
    parameter integer C_S00_AXIS_TDATA_WIDTH  = 32,
    parameter integer C_S01_AXIS_TDATA_WIDTH  = 32,
    parameter integer C_M00_AXIS_TDATA_WIDTH  = 32,
    parameter integer C_M00_AXIS_START_COUNT  = 32
)
(
    // AXI-Lite control
    input wire  s00_axi_aclk,
    input wire  s00_axi_aresetn,
    input wire [C_S00_AXI_ADDR_WIDTH-1 : 0] s00_axi_awaddr,
    input wire [2 : 0] s00_axi_awprot,
    input wire  s00_axi_awvalid,
    output wire  s00_axi_awready,
    input wire [C_S00_AXI_DATA_WIDTH-1 : 0] s00_axi_wdata,
    input wire [(C_S00_AXI_DATA_WIDTH/8)-1 : 0] s00_axi_wstrb,
    input wire  s00_axi_wvalid,
    output wire  s00_axi_wready,
    output wire [1 : 0] s00_axi_bresp,
    output wire  s00_axi_bvalid,
    input wire  s00_axi_bready,
    input wire [C_S00_AXI_ADDR_WIDTH-1 : 0] s00_axi_araddr,
    input wire [2 : 0] s00_axi_arprot,
    input wire  s00_axi_arvalid,
    output wire  s00_axi_arready,
    output wire [C_S00_AXI_DATA_WIDTH-1 : 0] s00_axi_rdata,
    output wire [1 : 0] s00_axi_rresp,
    output wire  s00_axi_rvalid,
    input wire  s00_axi_rready,

    // AXIS input A
    input wire  s00_axis_aclk,
    input wire  s00_axis_aresetn,
    output wire  s00_axis_tready,
    input wire [C_S00_AXIS_TDATA_WIDTH-1 : 0] s00_axis_tdata,
    input wire [(C_S00_AXIS_TDATA_WIDTH/8)-1 : 0] s00_axis_tstrb,
    input wire  s00_axis_tlast,
    input wire  s00_axis_tvalid,

    // AXIS input B
    input wire  s01_axis_aclk,
    input wire  s01_axis_aresetn,
    output wire  s01_axis_tready,
    input wire [C_S01_AXIS_TDATA_WIDTH-1 : 0] s01_axis_tdata,
    input wire [(C_S01_AXIS_TDATA_WIDTH/8)-1 : 0] s01_axis_tstrb,
    input wire  s01_axis_tlast,
    input wire  s01_axis_tvalid,

    // AXIS output C
    input wire  m00_axis_aclk,
    input wire  m00_axis_aresetn,
    output wire  m00_axis_tvalid,
    output wire [C_M00_AXIS_TDATA_WIDTH-1 : 0] m00_axis_tdata,
    output wire [(C_M00_AXIS_TDATA_WIDTH/8)-1 : 0] m00_axis_tstrb,
    output wire  m00_axis_tlast,
    input wire  m00_axis_tready
);

    // ------------------------------------------------------------
    // AXI-Lite register wires
    // reg0: control (bit0 = start)
    // reg1: N
    // reg2: status {30'b0, busy, done}
    // reg3: optional debug
    // ------------------------------------------------------------
    wire [31:0] slv_reg0_out;
    wire [31:0] slv_reg1_out;
    wire [31:0] slv_reg2_out;
    wire [31:0] slv_reg3_out;
    wire [31:0] user_status_in;

    // ------------------------------------------------------------
    // Start pulse generation from reg0 bit0
    // ------------------------------------------------------------
    reg start_d;
    wire core_start;

    always @(posedge s00_axi_aclk) begin
        if (!s00_axi_aresetn)
            start_d <= 1'b0;
        else
            start_d <= slv_reg0_out[0];
    end

    assign core_start = slv_reg0_out[0] & ~start_d;

    // ------------------------------------------------------------
    // Core status
    // ------------------------------------------------------------
    wire core_done;
    wire core_busy;

    assign user_status_in = {30'b0, core_busy, core_done};

    // ------------------------------------------------------------
    // AXI-Lite slave
    // ------------------------------------------------------------
    Accelerator_Stream_slave_lite_v1_0_S00_AXI #(
        .C_S_AXI_DATA_WIDTH(C_S00_AXI_DATA_WIDTH),
        .C_S_AXI_ADDR_WIDTH(C_S00_AXI_ADDR_WIDTH)
    ) Accelerator_Stream_slave_lite_v1_0_S00_AXI_inst (
        .S_AXI_ACLK   (s00_axi_aclk),
        .S_AXI_ARESETN(s00_axi_aresetn),
        .S_AXI_AWADDR (s00_axi_awaddr),
        .S_AXI_AWPROT (s00_axi_awprot),
        .S_AXI_AWVALID(s00_axi_awvalid),
        .S_AXI_AWREADY(s00_axi_awready),
        .S_AXI_WDATA  (s00_axi_wdata),
        .S_AXI_WSTRB  (s00_axi_wstrb),
        .S_AXI_WVALID (s00_axi_wvalid),
        .S_AXI_WREADY (s00_axi_wready),
        .S_AXI_BRESP  (s00_axi_bresp),
        .S_AXI_BVALID (s00_axi_bvalid),
        .S_AXI_BREADY (s00_axi_bready),
        .S_AXI_ARADDR (s00_axi_araddr),
        .S_AXI_ARPROT (s00_axi_arprot),
        .S_AXI_ARVALID(s00_axi_arvalid),
        .S_AXI_ARREADY(s00_axi_arready),
        .S_AXI_RDATA  (s00_axi_rdata),
        .S_AXI_RRESP  (s00_axi_rresp),
        .S_AXI_RVALID (s00_axi_rvalid),
        .S_AXI_RREADY (s00_axi_rready),

        .slv_reg0_out (slv_reg0_out),
        .slv_reg1_out (slv_reg1_out),
        .slv_reg2_out (slv_reg2_out),
        .slv_reg3_out (slv_reg3_out),
        .user_status_in(user_status_in)
    );

    // ------------------------------------------------------------
    // Real streaming matrix-multiply core
    // NOTE: connect all AXI/AXIS clocks to the same clock in BD
    // ------------------------------------------------------------
    matmul_stream_core #(
        .DATA_SIZE(8),
        .MAX_N    (10)
    ) u_core (
        .clk            (s00_axi_aclk),
        .rstn           (s00_axi_aresetn),
        .start_pulse    (core_start),
        .N              (slv_reg1_out[3:0]),

        .s_axis_a_tvalid(s00_axis_tvalid),
        .s_axis_a_tready(s00_axis_tready),
        .s_axis_a_tdata (s00_axis_tdata),
        .s_axis_a_tlast (s00_axis_tlast),

        .s_axis_b_tvalid(s01_axis_tvalid),
        .s_axis_b_tready(s01_axis_tready),
        .s_axis_b_tdata (s01_axis_tdata),
        .s_axis_b_tlast (s01_axis_tlast),

        .m_axis_c_tvalid(m00_axis_tvalid),
        .m_axis_c_tready(m00_axis_tready),
        .m_axis_c_tdata (m00_axis_tdata),
        .m_axis_c_tlast (m00_axis_tlast),

        .busy           (core_busy),
        .done           (core_done)
    );

    assign m00_axis_tstrb = {(C_M00_AXIS_TDATA_WIDTH/8){1'b1}};

endmodule