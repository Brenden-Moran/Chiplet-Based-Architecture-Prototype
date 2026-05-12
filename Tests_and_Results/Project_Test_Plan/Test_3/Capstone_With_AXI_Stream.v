//Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
//Copyright 2022-2025 Advanced Micro Devices, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2025.1 (win64) Build 6140274 Thu May 22 00:12:29 MDT 2025
//Date        : Sat Mar 21 15:12:26 2026
//Host        : Brenden-Laptop running 64-bit major release  (build 9200)
//Command     : generate_target Capstone_With_AXI_Stream.bd
//Design      : Capstone_With_AXI_Stream
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CORE_GENERATION_INFO = "Capstone_With_AXI_Stream,IP_Integrator,{x_ipVendor=xilinx.com,x_ipLibrary=BlockDiagram,x_ipName=Capstone_With_AXI_Stream,x_ipVersion=1.00.a,x_ipLanguage=VERILOG,numBlks=19,numReposBlks=18,numNonXlnxBlks=0,numHierBlks=1,maxHierDepth=1,numSysgenBlks=0,numHlsBlks=0,numHdlrefBlks=0,numPkgbdBlks=0,bdsource=USER,da_axi4_cnt=15,da_clkrst_cnt=3,synth_mode=Hierarchical}" *) (* HW_HANDOFF = "Capstone_With_AXI_Stream.hwdef" *) 
module Capstone_With_AXI_Stream
   (ddr2_sdram_addr,
    ddr2_sdram_ba,
    ddr2_sdram_cas_n,
    ddr2_sdram_ck_n,
    ddr2_sdram_ck_p,
    ddr2_sdram_cke,
    ddr2_sdram_cs_n,
    ddr2_sdram_dm,
    ddr2_sdram_dq,
    ddr2_sdram_dqs_n,
    ddr2_sdram_dqs_p,
    ddr2_sdram_odt,
    ddr2_sdram_ras_n,
    ddr2_sdram_we_n,
    reset,
    sys_clock_0,
    usb_uart_rxd,
    usb_uart_txd);
  (* X_INTERFACE_INFO = "xilinx.com:interface:ddrx:1.0 ddr2_sdram ADDR" *) (* X_INTERFACE_MODE = "Master" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME ddr2_sdram, AXI_ARBITRATION_SCHEME TDM, BURST_LENGTH 8, CAN_DEBUG false, CAS_LATENCY 11, CAS_WRITE_LATENCY 11, CS_ENABLED true, DATA_MASK_ENABLED true, DATA_WIDTH 8, MEMORY_TYPE COMPONENTS, MEM_ADDR_MAP ROW_COLUMN_BANK, SLOT Single, TIMEPERIOD_PS 1250" *) output [12:0]ddr2_sdram_addr;
  (* X_INTERFACE_INFO = "xilinx.com:interface:ddrx:1.0 ddr2_sdram BA" *) output [2:0]ddr2_sdram_ba;
  (* X_INTERFACE_INFO = "xilinx.com:interface:ddrx:1.0 ddr2_sdram CAS_N" *) output ddr2_sdram_cas_n;
  (* X_INTERFACE_INFO = "xilinx.com:interface:ddrx:1.0 ddr2_sdram CK_N" *) output [0:0]ddr2_sdram_ck_n;
  (* X_INTERFACE_INFO = "xilinx.com:interface:ddrx:1.0 ddr2_sdram CK_P" *) output [0:0]ddr2_sdram_ck_p;
  (* X_INTERFACE_INFO = "xilinx.com:interface:ddrx:1.0 ddr2_sdram CKE" *) output [0:0]ddr2_sdram_cke;
  (* X_INTERFACE_INFO = "xilinx.com:interface:ddrx:1.0 ddr2_sdram CS_N" *) output [0:0]ddr2_sdram_cs_n;
  (* X_INTERFACE_INFO = "xilinx.com:interface:ddrx:1.0 ddr2_sdram DM" *) output [1:0]ddr2_sdram_dm;
  (* X_INTERFACE_INFO = "xilinx.com:interface:ddrx:1.0 ddr2_sdram DQ" *) inout [15:0]ddr2_sdram_dq;
  (* X_INTERFACE_INFO = "xilinx.com:interface:ddrx:1.0 ddr2_sdram DQS_N" *) inout [1:0]ddr2_sdram_dqs_n;
  (* X_INTERFACE_INFO = "xilinx.com:interface:ddrx:1.0 ddr2_sdram DQS_P" *) inout [1:0]ddr2_sdram_dqs_p;
  (* X_INTERFACE_INFO = "xilinx.com:interface:ddrx:1.0 ddr2_sdram ODT" *) output [0:0]ddr2_sdram_odt;
  (* X_INTERFACE_INFO = "xilinx.com:interface:ddrx:1.0 ddr2_sdram RAS_N" *) output ddr2_sdram_ras_n;
  (* X_INTERFACE_INFO = "xilinx.com:interface:ddrx:1.0 ddr2_sdram WE_N" *) output ddr2_sdram_we_n;
  (* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 RST.RESET RST" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME RST.RESET, INSERT_VIP 0, POLARITY ACTIVE_LOW" *) input reset;
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 CLK.SYS_CLOCK_0 CLK" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME CLK.SYS_CLOCK_0, CLK_DOMAIN Capstone_With_AXI_Stream_sys_clock_0, FREQ_HZ 100000000, FREQ_TOLERANCE_HZ 0, INSERT_VIP 0, PHASE 0.0" *) input sys_clock_0;
  (* X_INTERFACE_INFO = "xilinx.com:interface:uart:1.0 usb_uart RxD" *) (* X_INTERFACE_MODE = "Master" *) input usb_uart_rxd;
  (* X_INTERFACE_INFO = "xilinx.com:interface:uart:1.0 usb_uart TxD" *) output usb_uart_txd;

  wire [31:0]Accelerator_Stream_0_M00_AXIS_TDATA;
  wire Accelerator_Stream_0_M00_AXIS_TLAST;
  wire Accelerator_Stream_0_M00_AXIS_TREADY;
  wire Accelerator_Stream_0_M00_AXIS_TVALID;
  wire [31:0]axi_dma_a_M_AXIS_MM2S_TDATA;
  wire axi_dma_a_M_AXIS_MM2S_TLAST;
  wire axi_dma_a_M_AXIS_MM2S_TREADY;
  wire axi_dma_a_M_AXIS_MM2S_TVALID;
  wire [31:0]axi_dma_a_M_AXI_MM2S_ARADDR;
  wire [1:0]axi_dma_a_M_AXI_MM2S_ARBURST;
  wire [3:0]axi_dma_a_M_AXI_MM2S_ARCACHE;
  wire [7:0]axi_dma_a_M_AXI_MM2S_ARLEN;
  wire [2:0]axi_dma_a_M_AXI_MM2S_ARPROT;
  wire axi_dma_a_M_AXI_MM2S_ARREADY;
  wire [2:0]axi_dma_a_M_AXI_MM2S_ARSIZE;
  wire axi_dma_a_M_AXI_MM2S_ARVALID;
  wire [31:0]axi_dma_a_M_AXI_MM2S_RDATA;
  wire axi_dma_a_M_AXI_MM2S_RLAST;
  wire axi_dma_a_M_AXI_MM2S_RREADY;
  wire [1:0]axi_dma_a_M_AXI_MM2S_RRESP;
  wire axi_dma_a_M_AXI_MM2S_RVALID;
  wire [31:0]axi_dma_b_M_AXIS_MM2S_TDATA;
  wire axi_dma_b_M_AXIS_MM2S_TLAST;
  wire axi_dma_b_M_AXIS_MM2S_TREADY;
  wire axi_dma_b_M_AXIS_MM2S_TVALID;
  wire [31:0]axi_dma_b_M_AXI_MM2S_ARADDR;
  wire [1:0]axi_dma_b_M_AXI_MM2S_ARBURST;
  wire [3:0]axi_dma_b_M_AXI_MM2S_ARCACHE;
  wire [7:0]axi_dma_b_M_AXI_MM2S_ARLEN;
  wire [2:0]axi_dma_b_M_AXI_MM2S_ARPROT;
  wire axi_dma_b_M_AXI_MM2S_ARREADY;
  wire [2:0]axi_dma_b_M_AXI_MM2S_ARSIZE;
  wire axi_dma_b_M_AXI_MM2S_ARVALID;
  wire [31:0]axi_dma_b_M_AXI_MM2S_RDATA;
  wire axi_dma_b_M_AXI_MM2S_RLAST;
  wire axi_dma_b_M_AXI_MM2S_RREADY;
  wire [1:0]axi_dma_b_M_AXI_MM2S_RRESP;
  wire axi_dma_b_M_AXI_MM2S_RVALID;
  wire [31:0]axi_dma_c_M_AXI_S2MM_AWADDR;
  wire [1:0]axi_dma_c_M_AXI_S2MM_AWBURST;
  wire [3:0]axi_dma_c_M_AXI_S2MM_AWCACHE;
  wire [7:0]axi_dma_c_M_AXI_S2MM_AWLEN;
  wire [2:0]axi_dma_c_M_AXI_S2MM_AWPROT;
  wire axi_dma_c_M_AXI_S2MM_AWREADY;
  wire [2:0]axi_dma_c_M_AXI_S2MM_AWSIZE;
  wire axi_dma_c_M_AXI_S2MM_AWVALID;
  wire axi_dma_c_M_AXI_S2MM_BREADY;
  wire [1:0]axi_dma_c_M_AXI_S2MM_BRESP;
  wire axi_dma_c_M_AXI_S2MM_BVALID;
  wire [31:0]axi_dma_c_M_AXI_S2MM_WDATA;
  wire axi_dma_c_M_AXI_S2MM_WLAST;
  wire axi_dma_c_M_AXI_S2MM_WREADY;
  wire [3:0]axi_dma_c_M_AXI_S2MM_WSTRB;
  wire axi_dma_c_M_AXI_S2MM_WVALID;
  wire clk_wiz_0_clk_out1;
  wire [12:0]ddr2_sdram_addr;
  wire [2:0]ddr2_sdram_ba;
  wire ddr2_sdram_cas_n;
  wire [0:0]ddr2_sdram_ck_n;
  wire [0:0]ddr2_sdram_ck_p;
  wire [0:0]ddr2_sdram_cke;
  wire [0:0]ddr2_sdram_cs_n;
  wire [1:0]ddr2_sdram_dm;
  wire [15:0]ddr2_sdram_dq;
  wire [1:0]ddr2_sdram_dqs_n;
  wire [1:0]ddr2_sdram_dqs_p;
  wire [0:0]ddr2_sdram_odt;
  wire ddr2_sdram_ras_n;
  wire ddr2_sdram_we_n;
  wire mdm_1_debug_sys_rst;
  wire [31:0]microblaze_riscv_0_M_AXI_DC_ARADDR;
  wire [1:0]microblaze_riscv_0_M_AXI_DC_ARBURST;
  wire [3:0]microblaze_riscv_0_M_AXI_DC_ARCACHE;
  wire [7:0]microblaze_riscv_0_M_AXI_DC_ARLEN;
  wire microblaze_riscv_0_M_AXI_DC_ARLOCK;
  wire [2:0]microblaze_riscv_0_M_AXI_DC_ARPROT;
  wire [3:0]microblaze_riscv_0_M_AXI_DC_ARQOS;
  wire microblaze_riscv_0_M_AXI_DC_ARREADY;
  wire [2:0]microblaze_riscv_0_M_AXI_DC_ARSIZE;
  wire microblaze_riscv_0_M_AXI_DC_ARVALID;
  wire [31:0]microblaze_riscv_0_M_AXI_DC_AWADDR;
  wire [1:0]microblaze_riscv_0_M_AXI_DC_AWBURST;
  wire [3:0]microblaze_riscv_0_M_AXI_DC_AWCACHE;
  wire [7:0]microblaze_riscv_0_M_AXI_DC_AWLEN;
  wire microblaze_riscv_0_M_AXI_DC_AWLOCK;
  wire [2:0]microblaze_riscv_0_M_AXI_DC_AWPROT;
  wire [3:0]microblaze_riscv_0_M_AXI_DC_AWQOS;
  wire microblaze_riscv_0_M_AXI_DC_AWREADY;
  wire [2:0]microblaze_riscv_0_M_AXI_DC_AWSIZE;
  wire microblaze_riscv_0_M_AXI_DC_AWVALID;
  wire microblaze_riscv_0_M_AXI_DC_BREADY;
  wire [1:0]microblaze_riscv_0_M_AXI_DC_BRESP;
  wire microblaze_riscv_0_M_AXI_DC_BVALID;
  wire [31:0]microblaze_riscv_0_M_AXI_DC_RDATA;
  wire microblaze_riscv_0_M_AXI_DC_RLAST;
  wire microblaze_riscv_0_M_AXI_DC_RREADY;
  wire [1:0]microblaze_riscv_0_M_AXI_DC_RRESP;
  wire microblaze_riscv_0_M_AXI_DC_RVALID;
  wire [31:0]microblaze_riscv_0_M_AXI_DC_WDATA;
  wire microblaze_riscv_0_M_AXI_DC_WLAST;
  wire microblaze_riscv_0_M_AXI_DC_WREADY;
  wire [3:0]microblaze_riscv_0_M_AXI_DC_WSTRB;
  wire microblaze_riscv_0_M_AXI_DC_WVALID;
  wire [31:0]microblaze_riscv_0_M_AXI_DP_ARADDR;
  wire [2:0]microblaze_riscv_0_M_AXI_DP_ARPROT;
  wire microblaze_riscv_0_M_AXI_DP_ARREADY;
  wire microblaze_riscv_0_M_AXI_DP_ARVALID;
  wire [31:0]microblaze_riscv_0_M_AXI_DP_AWADDR;
  wire [2:0]microblaze_riscv_0_M_AXI_DP_AWPROT;
  wire microblaze_riscv_0_M_AXI_DP_AWREADY;
  wire microblaze_riscv_0_M_AXI_DP_AWVALID;
  wire microblaze_riscv_0_M_AXI_DP_BREADY;
  wire [1:0]microblaze_riscv_0_M_AXI_DP_BRESP;
  wire microblaze_riscv_0_M_AXI_DP_BVALID;
  wire [31:0]microblaze_riscv_0_M_AXI_DP_RDATA;
  wire microblaze_riscv_0_M_AXI_DP_RREADY;
  wire [1:0]microblaze_riscv_0_M_AXI_DP_RRESP;
  wire microblaze_riscv_0_M_AXI_DP_RVALID;
  wire [31:0]microblaze_riscv_0_M_AXI_DP_WDATA;
  wire microblaze_riscv_0_M_AXI_DP_WREADY;
  wire [3:0]microblaze_riscv_0_M_AXI_DP_WSTRB;
  wire microblaze_riscv_0_M_AXI_DP_WVALID;
  wire [31:0]microblaze_riscv_0_M_AXI_IC_ARADDR;
  wire [1:0]microblaze_riscv_0_M_AXI_IC_ARBURST;
  wire [3:0]microblaze_riscv_0_M_AXI_IC_ARCACHE;
  wire [7:0]microblaze_riscv_0_M_AXI_IC_ARLEN;
  wire microblaze_riscv_0_M_AXI_IC_ARLOCK;
  wire [2:0]microblaze_riscv_0_M_AXI_IC_ARPROT;
  wire [3:0]microblaze_riscv_0_M_AXI_IC_ARQOS;
  wire microblaze_riscv_0_M_AXI_IC_ARREADY;
  wire [2:0]microblaze_riscv_0_M_AXI_IC_ARSIZE;
  wire microblaze_riscv_0_M_AXI_IC_ARVALID;
  wire [31:0]microblaze_riscv_0_M_AXI_IC_RDATA;
  wire microblaze_riscv_0_M_AXI_IC_RLAST;
  wire microblaze_riscv_0_M_AXI_IC_RREADY;
  wire [1:0]microblaze_riscv_0_M_AXI_IC_RRESP;
  wire microblaze_riscv_0_M_AXI_IC_RVALID;
  wire microblaze_riscv_0_debug_CAPTURE;
  wire microblaze_riscv_0_debug_CLK;
  wire microblaze_riscv_0_debug_DISABLE;
  wire [0:7]microblaze_riscv_0_debug_REG_EN;
  wire microblaze_riscv_0_debug_RST;
  wire microblaze_riscv_0_debug_SHIFT;
  wire microblaze_riscv_0_debug_TDI;
  wire microblaze_riscv_0_debug_TDO;
  wire microblaze_riscv_0_debug_UPDATE;
  wire [0:31]microblaze_riscv_0_dlmb_1_ABUS;
  wire microblaze_riscv_0_dlmb_1_ADDRSTROBE;
  wire [0:3]microblaze_riscv_0_dlmb_1_BE;
  wire microblaze_riscv_0_dlmb_1_CE;
  wire [0:31]microblaze_riscv_0_dlmb_1_READDBUS;
  wire microblaze_riscv_0_dlmb_1_READSTROBE;
  wire microblaze_riscv_0_dlmb_1_READY;
  wire microblaze_riscv_0_dlmb_1_UE;
  wire microblaze_riscv_0_dlmb_1_WAIT;
  wire [0:31]microblaze_riscv_0_dlmb_1_WRITEDBUS;
  wire microblaze_riscv_0_dlmb_1_WRITESTROBE;
  wire [0:31]microblaze_riscv_0_ilmb_1_ABUS;
  wire microblaze_riscv_0_ilmb_1_ADDRSTROBE;
  wire microblaze_riscv_0_ilmb_1_CE;
  wire [0:31]microblaze_riscv_0_ilmb_1_READDBUS;
  wire microblaze_riscv_0_ilmb_1_READSTROBE;
  wire microblaze_riscv_0_ilmb_1_READY;
  wire microblaze_riscv_0_ilmb_1_UE;
  wire microblaze_riscv_0_ilmb_1_WAIT;
  wire mig_7series_0_mmcm_locked;
  wire mig_7series_0_ui_clk;
  wire mig_7series_0_ui_clk_sync_rst;
  wire reset;
  wire [0:0]reset_inv_0_Res;
  wire [0:0]rst_mig_7series_0_100M_bus_struct_reset;
  wire rst_mig_7series_0_100M_mb_reset;
  wire [0:0]rst_mig_7series_0_100M_peripheral_aresetn;
  wire [0:0]rst_mig_7series_0_81M_peripheral_aresetn;
  wire [3:0]smartconnect_0_M00_AXI_ARADDR;
  wire smartconnect_0_M00_AXI_ARREADY;
  wire smartconnect_0_M00_AXI_ARVALID;
  wire [3:0]smartconnect_0_M00_AXI_AWADDR;
  wire smartconnect_0_M00_AXI_AWREADY;
  wire smartconnect_0_M00_AXI_AWVALID;
  wire smartconnect_0_M00_AXI_BREADY;
  wire [1:0]smartconnect_0_M00_AXI_BRESP;
  wire smartconnect_0_M00_AXI_BVALID;
  wire [31:0]smartconnect_0_M00_AXI_RDATA;
  wire smartconnect_0_M00_AXI_RREADY;
  wire [1:0]smartconnect_0_M00_AXI_RRESP;
  wire smartconnect_0_M00_AXI_RVALID;
  wire [31:0]smartconnect_0_M00_AXI_WDATA;
  wire smartconnect_0_M00_AXI_WREADY;
  wire [3:0]smartconnect_0_M00_AXI_WSTRB;
  wire smartconnect_0_M00_AXI_WVALID;
  wire [3:0]smartconnect_0_M01_AXI_ARADDR;
  wire [2:0]smartconnect_0_M01_AXI_ARPROT;
  wire smartconnect_0_M01_AXI_ARREADY;
  wire smartconnect_0_M01_AXI_ARVALID;
  wire [3:0]smartconnect_0_M01_AXI_AWADDR;
  wire [2:0]smartconnect_0_M01_AXI_AWPROT;
  wire smartconnect_0_M01_AXI_AWREADY;
  wire smartconnect_0_M01_AXI_AWVALID;
  wire smartconnect_0_M01_AXI_BREADY;
  wire [1:0]smartconnect_0_M01_AXI_BRESP;
  wire smartconnect_0_M01_AXI_BVALID;
  wire [31:0]smartconnect_0_M01_AXI_RDATA;
  wire smartconnect_0_M01_AXI_RREADY;
  wire [1:0]smartconnect_0_M01_AXI_RRESP;
  wire smartconnect_0_M01_AXI_RVALID;
  wire [31:0]smartconnect_0_M01_AXI_WDATA;
  wire smartconnect_0_M01_AXI_WREADY;
  wire [3:0]smartconnect_0_M01_AXI_WSTRB;
  wire smartconnect_0_M01_AXI_WVALID;
  wire [26:0]smartconnect_0_M02_AXI_ARADDR;
  wire [1:0]smartconnect_0_M02_AXI_ARBURST;
  wire [3:0]smartconnect_0_M02_AXI_ARCACHE;
  wire [7:0]smartconnect_0_M02_AXI_ARLEN;
  wire [0:0]smartconnect_0_M02_AXI_ARLOCK;
  wire [2:0]smartconnect_0_M02_AXI_ARPROT;
  wire [3:0]smartconnect_0_M02_AXI_ARQOS;
  wire smartconnect_0_M02_AXI_ARREADY;
  wire [2:0]smartconnect_0_M02_AXI_ARSIZE;
  wire smartconnect_0_M02_AXI_ARVALID;
  wire [26:0]smartconnect_0_M02_AXI_AWADDR;
  wire [1:0]smartconnect_0_M02_AXI_AWBURST;
  wire [3:0]smartconnect_0_M02_AXI_AWCACHE;
  wire [7:0]smartconnect_0_M02_AXI_AWLEN;
  wire [0:0]smartconnect_0_M02_AXI_AWLOCK;
  wire [2:0]smartconnect_0_M02_AXI_AWPROT;
  wire [3:0]smartconnect_0_M02_AXI_AWQOS;
  wire smartconnect_0_M02_AXI_AWREADY;
  wire [2:0]smartconnect_0_M02_AXI_AWSIZE;
  wire smartconnect_0_M02_AXI_AWVALID;
  wire smartconnect_0_M02_AXI_BREADY;
  wire [1:0]smartconnect_0_M02_AXI_BRESP;
  wire smartconnect_0_M02_AXI_BVALID;
  wire [63:0]smartconnect_0_M02_AXI_RDATA;
  wire smartconnect_0_M02_AXI_RLAST;
  wire smartconnect_0_M02_AXI_RREADY;
  wire [1:0]smartconnect_0_M02_AXI_RRESP;
  wire smartconnect_0_M02_AXI_RVALID;
  wire [63:0]smartconnect_0_M02_AXI_WDATA;
  wire smartconnect_0_M02_AXI_WLAST;
  wire smartconnect_0_M02_AXI_WREADY;
  wire [7:0]smartconnect_0_M02_AXI_WSTRB;
  wire smartconnect_0_M02_AXI_WVALID;
  wire [9:0]smartconnect_0_M03_AXI_ARADDR;
  wire smartconnect_0_M03_AXI_ARREADY;
  wire smartconnect_0_M03_AXI_ARVALID;
  wire [9:0]smartconnect_0_M03_AXI_AWADDR;
  wire smartconnect_0_M03_AXI_AWREADY;
  wire smartconnect_0_M03_AXI_AWVALID;
  wire smartconnect_0_M03_AXI_BREADY;
  wire [1:0]smartconnect_0_M03_AXI_BRESP;
  wire smartconnect_0_M03_AXI_BVALID;
  wire [31:0]smartconnect_0_M03_AXI_RDATA;
  wire smartconnect_0_M03_AXI_RREADY;
  wire [1:0]smartconnect_0_M03_AXI_RRESP;
  wire smartconnect_0_M03_AXI_RVALID;
  wire [31:0]smartconnect_0_M03_AXI_WDATA;
  wire smartconnect_0_M03_AXI_WREADY;
  wire smartconnect_0_M03_AXI_WVALID;
  wire [9:0]smartconnect_0_M04_AXI_ARADDR;
  wire smartconnect_0_M04_AXI_ARREADY;
  wire smartconnect_0_M04_AXI_ARVALID;
  wire [9:0]smartconnect_0_M04_AXI_AWADDR;
  wire smartconnect_0_M04_AXI_AWREADY;
  wire smartconnect_0_M04_AXI_AWVALID;
  wire smartconnect_0_M04_AXI_BREADY;
  wire [1:0]smartconnect_0_M04_AXI_BRESP;
  wire smartconnect_0_M04_AXI_BVALID;
  wire [31:0]smartconnect_0_M04_AXI_RDATA;
  wire smartconnect_0_M04_AXI_RREADY;
  wire [1:0]smartconnect_0_M04_AXI_RRESP;
  wire smartconnect_0_M04_AXI_RVALID;
  wire [31:0]smartconnect_0_M04_AXI_WDATA;
  wire smartconnect_0_M04_AXI_WREADY;
  wire smartconnect_0_M04_AXI_WVALID;
  wire [9:0]smartconnect_0_M05_AXI_ARADDR;
  wire smartconnect_0_M05_AXI_ARREADY;
  wire smartconnect_0_M05_AXI_ARVALID;
  wire [9:0]smartconnect_0_M05_AXI_AWADDR;
  wire smartconnect_0_M05_AXI_AWREADY;
  wire smartconnect_0_M05_AXI_AWVALID;
  wire smartconnect_0_M05_AXI_BREADY;
  wire [1:0]smartconnect_0_M05_AXI_BRESP;
  wire smartconnect_0_M05_AXI_BVALID;
  wire [31:0]smartconnect_0_M05_AXI_RDATA;
  wire smartconnect_0_M05_AXI_RREADY;
  wire [1:0]smartconnect_0_M05_AXI_RRESP;
  wire smartconnect_0_M05_AXI_RVALID;
  wire [31:0]smartconnect_0_M05_AXI_WDATA;
  wire smartconnect_0_M05_AXI_WREADY;
  wire smartconnect_0_M05_AXI_WVALID;
  wire sys_clock_0;
  wire usb_uart_rxd;
  wire usb_uart_txd;

  Capstone_With_AXI_Stream_Accelerator_Stream_0_5 Accelerator_Stream_0
       (.m00_axis_aclk(clk_wiz_0_clk_out1),
        .m00_axis_aresetn(rst_mig_7series_0_100M_peripheral_aresetn),
        .m00_axis_tdata(Accelerator_Stream_0_M00_AXIS_TDATA),
        .m00_axis_tlast(Accelerator_Stream_0_M00_AXIS_TLAST),
        .m00_axis_tready(Accelerator_Stream_0_M00_AXIS_TREADY),
        .m00_axis_tvalid(Accelerator_Stream_0_M00_AXIS_TVALID),
        .s00_axi_aclk(clk_wiz_0_clk_out1),
        .s00_axi_araddr(smartconnect_0_M01_AXI_ARADDR),
        .s00_axi_aresetn(rst_mig_7series_0_100M_peripheral_aresetn),
        .s00_axi_arprot(smartconnect_0_M01_AXI_ARPROT),
        .s00_axi_arready(smartconnect_0_M01_AXI_ARREADY),
        .s00_axi_arvalid(smartconnect_0_M01_AXI_ARVALID),
        .s00_axi_awaddr(smartconnect_0_M01_AXI_AWADDR),
        .s00_axi_awprot(smartconnect_0_M01_AXI_AWPROT),
        .s00_axi_awready(smartconnect_0_M01_AXI_AWREADY),
        .s00_axi_awvalid(smartconnect_0_M01_AXI_AWVALID),
        .s00_axi_bready(smartconnect_0_M01_AXI_BREADY),
        .s00_axi_bresp(smartconnect_0_M01_AXI_BRESP),
        .s00_axi_bvalid(smartconnect_0_M01_AXI_BVALID),
        .s00_axi_rdata(smartconnect_0_M01_AXI_RDATA),
        .s00_axi_rready(smartconnect_0_M01_AXI_RREADY),
        .s00_axi_rresp(smartconnect_0_M01_AXI_RRESP),
        .s00_axi_rvalid(smartconnect_0_M01_AXI_RVALID),
        .s00_axi_wdata(smartconnect_0_M01_AXI_WDATA),
        .s00_axi_wready(smartconnect_0_M01_AXI_WREADY),
        .s00_axi_wstrb(smartconnect_0_M01_AXI_WSTRB),
        .s00_axi_wvalid(smartconnect_0_M01_AXI_WVALID),
        .s00_axis_aclk(clk_wiz_0_clk_out1),
        .s00_axis_aresetn(rst_mig_7series_0_100M_peripheral_aresetn),
        .s00_axis_tdata(axi_dma_a_M_AXIS_MM2S_TDATA),
        .s00_axis_tlast(axi_dma_a_M_AXIS_MM2S_TLAST),
        .s00_axis_tready(axi_dma_a_M_AXIS_MM2S_TREADY),
        .s00_axis_tstrb({1'b1,1'b1,1'b1,1'b1}),
        .s00_axis_tvalid(axi_dma_a_M_AXIS_MM2S_TVALID),
        .s01_axis_aclk(clk_wiz_0_clk_out1),
        .s01_axis_aresetn(rst_mig_7series_0_100M_peripheral_aresetn),
        .s01_axis_tdata(axi_dma_b_M_AXIS_MM2S_TDATA),
        .s01_axis_tlast(axi_dma_b_M_AXIS_MM2S_TLAST),
        .s01_axis_tready(axi_dma_b_M_AXIS_MM2S_TREADY),
        .s01_axis_tstrb({1'b1,1'b1,1'b1,1'b1}),
        .s01_axis_tvalid(axi_dma_b_M_AXIS_MM2S_TVALID));
  Capstone_With_AXI_Stream_axi_dma_0_0 axi_dma_a
       (.axi_resetn(rst_mig_7series_0_100M_peripheral_aresetn),
        .m_axi_mm2s_aclk(clk_wiz_0_clk_out1),
        .m_axi_mm2s_araddr(axi_dma_a_M_AXI_MM2S_ARADDR),
        .m_axi_mm2s_arburst(axi_dma_a_M_AXI_MM2S_ARBURST),
        .m_axi_mm2s_arcache(axi_dma_a_M_AXI_MM2S_ARCACHE),
        .m_axi_mm2s_arlen(axi_dma_a_M_AXI_MM2S_ARLEN),
        .m_axi_mm2s_arprot(axi_dma_a_M_AXI_MM2S_ARPROT),
        .m_axi_mm2s_arready(axi_dma_a_M_AXI_MM2S_ARREADY),
        .m_axi_mm2s_arsize(axi_dma_a_M_AXI_MM2S_ARSIZE),
        .m_axi_mm2s_arvalid(axi_dma_a_M_AXI_MM2S_ARVALID),
        .m_axi_mm2s_rdata(axi_dma_a_M_AXI_MM2S_RDATA),
        .m_axi_mm2s_rlast(axi_dma_a_M_AXI_MM2S_RLAST),
        .m_axi_mm2s_rready(axi_dma_a_M_AXI_MM2S_RREADY),
        .m_axi_mm2s_rresp(axi_dma_a_M_AXI_MM2S_RRESP),
        .m_axi_mm2s_rvalid(axi_dma_a_M_AXI_MM2S_RVALID),
        .m_axis_mm2s_tdata(axi_dma_a_M_AXIS_MM2S_TDATA),
        .m_axis_mm2s_tlast(axi_dma_a_M_AXIS_MM2S_TLAST),
        .m_axis_mm2s_tready(axi_dma_a_M_AXIS_MM2S_TREADY),
        .m_axis_mm2s_tvalid(axi_dma_a_M_AXIS_MM2S_TVALID),
        .s_axi_lite_aclk(clk_wiz_0_clk_out1),
        .s_axi_lite_araddr(smartconnect_0_M03_AXI_ARADDR),
        .s_axi_lite_arready(smartconnect_0_M03_AXI_ARREADY),
        .s_axi_lite_arvalid(smartconnect_0_M03_AXI_ARVALID),
        .s_axi_lite_awaddr(smartconnect_0_M03_AXI_AWADDR),
        .s_axi_lite_awready(smartconnect_0_M03_AXI_AWREADY),
        .s_axi_lite_awvalid(smartconnect_0_M03_AXI_AWVALID),
        .s_axi_lite_bready(smartconnect_0_M03_AXI_BREADY),
        .s_axi_lite_bresp(smartconnect_0_M03_AXI_BRESP),
        .s_axi_lite_bvalid(smartconnect_0_M03_AXI_BVALID),
        .s_axi_lite_rdata(smartconnect_0_M03_AXI_RDATA),
        .s_axi_lite_rready(smartconnect_0_M03_AXI_RREADY),
        .s_axi_lite_rresp(smartconnect_0_M03_AXI_RRESP),
        .s_axi_lite_rvalid(smartconnect_0_M03_AXI_RVALID),
        .s_axi_lite_wdata(smartconnect_0_M03_AXI_WDATA),
        .s_axi_lite_wready(smartconnect_0_M03_AXI_WREADY),
        .s_axi_lite_wvalid(smartconnect_0_M03_AXI_WVALID));
  Capstone_With_AXI_Stream_axi_dma_1_0 axi_dma_b
       (.axi_resetn(rst_mig_7series_0_100M_peripheral_aresetn),
        .m_axi_mm2s_aclk(clk_wiz_0_clk_out1),
        .m_axi_mm2s_araddr(axi_dma_b_M_AXI_MM2S_ARADDR),
        .m_axi_mm2s_arburst(axi_dma_b_M_AXI_MM2S_ARBURST),
        .m_axi_mm2s_arcache(axi_dma_b_M_AXI_MM2S_ARCACHE),
        .m_axi_mm2s_arlen(axi_dma_b_M_AXI_MM2S_ARLEN),
        .m_axi_mm2s_arprot(axi_dma_b_M_AXI_MM2S_ARPROT),
        .m_axi_mm2s_arready(axi_dma_b_M_AXI_MM2S_ARREADY),
        .m_axi_mm2s_arsize(axi_dma_b_M_AXI_MM2S_ARSIZE),
        .m_axi_mm2s_arvalid(axi_dma_b_M_AXI_MM2S_ARVALID),
        .m_axi_mm2s_rdata(axi_dma_b_M_AXI_MM2S_RDATA),
        .m_axi_mm2s_rlast(axi_dma_b_M_AXI_MM2S_RLAST),
        .m_axi_mm2s_rready(axi_dma_b_M_AXI_MM2S_RREADY),
        .m_axi_mm2s_rresp(axi_dma_b_M_AXI_MM2S_RRESP),
        .m_axi_mm2s_rvalid(axi_dma_b_M_AXI_MM2S_RVALID),
        .m_axis_mm2s_tdata(axi_dma_b_M_AXIS_MM2S_TDATA),
        .m_axis_mm2s_tlast(axi_dma_b_M_AXIS_MM2S_TLAST),
        .m_axis_mm2s_tready(axi_dma_b_M_AXIS_MM2S_TREADY),
        .m_axis_mm2s_tvalid(axi_dma_b_M_AXIS_MM2S_TVALID),
        .s_axi_lite_aclk(clk_wiz_0_clk_out1),
        .s_axi_lite_araddr(smartconnect_0_M04_AXI_ARADDR),
        .s_axi_lite_arready(smartconnect_0_M04_AXI_ARREADY),
        .s_axi_lite_arvalid(smartconnect_0_M04_AXI_ARVALID),
        .s_axi_lite_awaddr(smartconnect_0_M04_AXI_AWADDR),
        .s_axi_lite_awready(smartconnect_0_M04_AXI_AWREADY),
        .s_axi_lite_awvalid(smartconnect_0_M04_AXI_AWVALID),
        .s_axi_lite_bready(smartconnect_0_M04_AXI_BREADY),
        .s_axi_lite_bresp(smartconnect_0_M04_AXI_BRESP),
        .s_axi_lite_bvalid(smartconnect_0_M04_AXI_BVALID),
        .s_axi_lite_rdata(smartconnect_0_M04_AXI_RDATA),
        .s_axi_lite_rready(smartconnect_0_M04_AXI_RREADY),
        .s_axi_lite_rresp(smartconnect_0_M04_AXI_RRESP),
        .s_axi_lite_rvalid(smartconnect_0_M04_AXI_RVALID),
        .s_axi_lite_wdata(smartconnect_0_M04_AXI_WDATA),
        .s_axi_lite_wready(smartconnect_0_M04_AXI_WREADY),
        .s_axi_lite_wvalid(smartconnect_0_M04_AXI_WVALID));
  Capstone_With_AXI_Stream_axi_dma_2_0 axi_dma_c
       (.axi_resetn(rst_mig_7series_0_100M_peripheral_aresetn),
        .m_axi_s2mm_aclk(clk_wiz_0_clk_out1),
        .m_axi_s2mm_awaddr(axi_dma_c_M_AXI_S2MM_AWADDR),
        .m_axi_s2mm_awburst(axi_dma_c_M_AXI_S2MM_AWBURST),
        .m_axi_s2mm_awcache(axi_dma_c_M_AXI_S2MM_AWCACHE),
        .m_axi_s2mm_awlen(axi_dma_c_M_AXI_S2MM_AWLEN),
        .m_axi_s2mm_awprot(axi_dma_c_M_AXI_S2MM_AWPROT),
        .m_axi_s2mm_awready(axi_dma_c_M_AXI_S2MM_AWREADY),
        .m_axi_s2mm_awsize(axi_dma_c_M_AXI_S2MM_AWSIZE),
        .m_axi_s2mm_awvalid(axi_dma_c_M_AXI_S2MM_AWVALID),
        .m_axi_s2mm_bready(axi_dma_c_M_AXI_S2MM_BREADY),
        .m_axi_s2mm_bresp(axi_dma_c_M_AXI_S2MM_BRESP),
        .m_axi_s2mm_bvalid(axi_dma_c_M_AXI_S2MM_BVALID),
        .m_axi_s2mm_wdata(axi_dma_c_M_AXI_S2MM_WDATA),
        .m_axi_s2mm_wlast(axi_dma_c_M_AXI_S2MM_WLAST),
        .m_axi_s2mm_wready(axi_dma_c_M_AXI_S2MM_WREADY),
        .m_axi_s2mm_wstrb(axi_dma_c_M_AXI_S2MM_WSTRB),
        .m_axi_s2mm_wvalid(axi_dma_c_M_AXI_S2MM_WVALID),
        .s_axi_lite_aclk(clk_wiz_0_clk_out1),
        .s_axi_lite_araddr(smartconnect_0_M05_AXI_ARADDR),
        .s_axi_lite_arready(smartconnect_0_M05_AXI_ARREADY),
        .s_axi_lite_arvalid(smartconnect_0_M05_AXI_ARVALID),
        .s_axi_lite_awaddr(smartconnect_0_M05_AXI_AWADDR),
        .s_axi_lite_awready(smartconnect_0_M05_AXI_AWREADY),
        .s_axi_lite_awvalid(smartconnect_0_M05_AXI_AWVALID),
        .s_axi_lite_bready(smartconnect_0_M05_AXI_BREADY),
        .s_axi_lite_bresp(smartconnect_0_M05_AXI_BRESP),
        .s_axi_lite_bvalid(smartconnect_0_M05_AXI_BVALID),
        .s_axi_lite_rdata(smartconnect_0_M05_AXI_RDATA),
        .s_axi_lite_rready(smartconnect_0_M05_AXI_RREADY),
        .s_axi_lite_rresp(smartconnect_0_M05_AXI_RRESP),
        .s_axi_lite_rvalid(smartconnect_0_M05_AXI_RVALID),
        .s_axi_lite_wdata(smartconnect_0_M05_AXI_WDATA),
        .s_axi_lite_wready(smartconnect_0_M05_AXI_WREADY),
        .s_axi_lite_wvalid(smartconnect_0_M05_AXI_WVALID),
        .s_axis_s2mm_tdata(Accelerator_Stream_0_M00_AXIS_TDATA),
        .s_axis_s2mm_tkeep({1'b1,1'b1,1'b1,1'b1}),
        .s_axis_s2mm_tlast(Accelerator_Stream_0_M00_AXIS_TLAST),
        .s_axis_s2mm_tready(Accelerator_Stream_0_M00_AXIS_TREADY),
        .s_axis_s2mm_tvalid(Accelerator_Stream_0_M00_AXIS_TVALID));
  Capstone_With_AXI_Stream_axi_uartlite_0_0 axi_uartlite_0
       (.rx(usb_uart_rxd),
        .s_axi_aclk(clk_wiz_0_clk_out1),
        .s_axi_araddr(smartconnect_0_M00_AXI_ARADDR),
        .s_axi_aresetn(rst_mig_7series_0_100M_peripheral_aresetn),
        .s_axi_arready(smartconnect_0_M00_AXI_ARREADY),
        .s_axi_arvalid(smartconnect_0_M00_AXI_ARVALID),
        .s_axi_awaddr(smartconnect_0_M00_AXI_AWADDR),
        .s_axi_awready(smartconnect_0_M00_AXI_AWREADY),
        .s_axi_awvalid(smartconnect_0_M00_AXI_AWVALID),
        .s_axi_bready(smartconnect_0_M00_AXI_BREADY),
        .s_axi_bresp(smartconnect_0_M00_AXI_BRESP),
        .s_axi_bvalid(smartconnect_0_M00_AXI_BVALID),
        .s_axi_rdata(smartconnect_0_M00_AXI_RDATA),
        .s_axi_rready(smartconnect_0_M00_AXI_RREADY),
        .s_axi_rresp(smartconnect_0_M00_AXI_RRESP),
        .s_axi_rvalid(smartconnect_0_M00_AXI_RVALID),
        .s_axi_wdata(smartconnect_0_M00_AXI_WDATA),
        .s_axi_wready(smartconnect_0_M00_AXI_WREADY),
        .s_axi_wstrb(smartconnect_0_M00_AXI_WSTRB),
        .s_axi_wvalid(smartconnect_0_M00_AXI_WVALID),
        .tx(usb_uart_txd));
  Capstone_With_AXI_Stream_clk_wiz_0_0 clk_wiz_0
       (.clk_in1(sys_clock_0),
        .clk_out1(clk_wiz_0_clk_out1),
        .reset(reset_inv_0_Res));
  Capstone_With_AXI_Stream_mdm_1_0 mdm_1
       (.Dbg_Capture_0(microblaze_riscv_0_debug_CAPTURE),
        .Dbg_Clk_0(microblaze_riscv_0_debug_CLK),
        .Dbg_Disable_0(microblaze_riscv_0_debug_DISABLE),
        .Dbg_Reg_En_0(microblaze_riscv_0_debug_REG_EN),
        .Dbg_Rst_0(microblaze_riscv_0_debug_RST),
        .Dbg_Shift_0(microblaze_riscv_0_debug_SHIFT),
        .Dbg_TDI_0(microblaze_riscv_0_debug_TDI),
        .Dbg_TDO_0(microblaze_riscv_0_debug_TDO),
        .Dbg_Update_0(microblaze_riscv_0_debug_UPDATE),
        .Debug_SYS_Rst(mdm_1_debug_sys_rst));
  (* BMM_INFO_PROCESSOR = "riscv > Capstone_With_AXI_Stream microblaze_riscv_0_local_memory/dlmb_bram_if_cntlr" *) 
  (* KEEP_HIERARCHY = "yes" *) 
  Capstone_With_AXI_Stream_microblaze_riscv_0_0 microblaze_riscv_0
       (.Byte_Enable(microblaze_riscv_0_dlmb_1_BE),
        .Clk(clk_wiz_0_clk_out1),
        .DCE(microblaze_riscv_0_dlmb_1_CE),
        .DReady(microblaze_riscv_0_dlmb_1_READY),
        .DUE(microblaze_riscv_0_dlmb_1_UE),
        .DWait(microblaze_riscv_0_dlmb_1_WAIT),
        .D_AS(microblaze_riscv_0_dlmb_1_ADDRSTROBE),
        .Data_Addr(microblaze_riscv_0_dlmb_1_ABUS),
        .Data_Read(microblaze_riscv_0_dlmb_1_READDBUS),
        .Data_Write(microblaze_riscv_0_dlmb_1_WRITEDBUS),
        .Dbg_Capture(microblaze_riscv_0_debug_CAPTURE),
        .Dbg_Clk(microblaze_riscv_0_debug_CLK),
        .Dbg_Disable(microblaze_riscv_0_debug_DISABLE),
        .Dbg_Reg_En(microblaze_riscv_0_debug_REG_EN),
        .Dbg_Shift(microblaze_riscv_0_debug_SHIFT),
        .Dbg_TDI(microblaze_riscv_0_debug_TDI),
        .Dbg_TDO(microblaze_riscv_0_debug_TDO),
        .Dbg_Update(microblaze_riscv_0_debug_UPDATE),
        .Debug_Rst(microblaze_riscv_0_debug_RST),
        .ICE(microblaze_riscv_0_ilmb_1_CE),
        .IFetch(microblaze_riscv_0_ilmb_1_READSTROBE),
        .IReady(microblaze_riscv_0_ilmb_1_READY),
        .IUE(microblaze_riscv_0_ilmb_1_UE),
        .IWAIT(microblaze_riscv_0_ilmb_1_WAIT),
        .I_AS(microblaze_riscv_0_ilmb_1_ADDRSTROBE),
        .Instr(microblaze_riscv_0_ilmb_1_READDBUS),
        .Instr_Addr(microblaze_riscv_0_ilmb_1_ABUS),
        .Interrupt(1'b0),
        .Interrupt_Address({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .M_AXI_DC_ARADDR(microblaze_riscv_0_M_AXI_DC_ARADDR),
        .M_AXI_DC_ARBURST(microblaze_riscv_0_M_AXI_DC_ARBURST),
        .M_AXI_DC_ARCACHE(microblaze_riscv_0_M_AXI_DC_ARCACHE),
        .M_AXI_DC_ARLEN(microblaze_riscv_0_M_AXI_DC_ARLEN),
        .M_AXI_DC_ARLOCK(microblaze_riscv_0_M_AXI_DC_ARLOCK),
        .M_AXI_DC_ARPROT(microblaze_riscv_0_M_AXI_DC_ARPROT),
        .M_AXI_DC_ARQOS(microblaze_riscv_0_M_AXI_DC_ARQOS),
        .M_AXI_DC_ARREADY(microblaze_riscv_0_M_AXI_DC_ARREADY),
        .M_AXI_DC_ARSIZE(microblaze_riscv_0_M_AXI_DC_ARSIZE),
        .M_AXI_DC_ARVALID(microblaze_riscv_0_M_AXI_DC_ARVALID),
        .M_AXI_DC_AWADDR(microblaze_riscv_0_M_AXI_DC_AWADDR),
        .M_AXI_DC_AWBURST(microblaze_riscv_0_M_AXI_DC_AWBURST),
        .M_AXI_DC_AWCACHE(microblaze_riscv_0_M_AXI_DC_AWCACHE),
        .M_AXI_DC_AWLEN(microblaze_riscv_0_M_AXI_DC_AWLEN),
        .M_AXI_DC_AWLOCK(microblaze_riscv_0_M_AXI_DC_AWLOCK),
        .M_AXI_DC_AWPROT(microblaze_riscv_0_M_AXI_DC_AWPROT),
        .M_AXI_DC_AWQOS(microblaze_riscv_0_M_AXI_DC_AWQOS),
        .M_AXI_DC_AWREADY(microblaze_riscv_0_M_AXI_DC_AWREADY),
        .M_AXI_DC_AWSIZE(microblaze_riscv_0_M_AXI_DC_AWSIZE),
        .M_AXI_DC_AWVALID(microblaze_riscv_0_M_AXI_DC_AWVALID),
        .M_AXI_DC_BID(1'b0),
        .M_AXI_DC_BREADY(microblaze_riscv_0_M_AXI_DC_BREADY),
        .M_AXI_DC_BRESP(microblaze_riscv_0_M_AXI_DC_BRESP),
        .M_AXI_DC_BVALID(microblaze_riscv_0_M_AXI_DC_BVALID),
        .M_AXI_DC_RDATA(microblaze_riscv_0_M_AXI_DC_RDATA),
        .M_AXI_DC_RID(1'b0),
        .M_AXI_DC_RLAST(microblaze_riscv_0_M_AXI_DC_RLAST),
        .M_AXI_DC_RREADY(microblaze_riscv_0_M_AXI_DC_RREADY),
        .M_AXI_DC_RRESP(microblaze_riscv_0_M_AXI_DC_RRESP),
        .M_AXI_DC_RVALID(microblaze_riscv_0_M_AXI_DC_RVALID),
        .M_AXI_DC_WDATA(microblaze_riscv_0_M_AXI_DC_WDATA),
        .M_AXI_DC_WLAST(microblaze_riscv_0_M_AXI_DC_WLAST),
        .M_AXI_DC_WREADY(microblaze_riscv_0_M_AXI_DC_WREADY),
        .M_AXI_DC_WSTRB(microblaze_riscv_0_M_AXI_DC_WSTRB),
        .M_AXI_DC_WVALID(microblaze_riscv_0_M_AXI_DC_WVALID),
        .M_AXI_DP_ARADDR(microblaze_riscv_0_M_AXI_DP_ARADDR),
        .M_AXI_DP_ARPROT(microblaze_riscv_0_M_AXI_DP_ARPROT),
        .M_AXI_DP_ARREADY(microblaze_riscv_0_M_AXI_DP_ARREADY),
        .M_AXI_DP_ARVALID(microblaze_riscv_0_M_AXI_DP_ARVALID),
        .M_AXI_DP_AWADDR(microblaze_riscv_0_M_AXI_DP_AWADDR),
        .M_AXI_DP_AWPROT(microblaze_riscv_0_M_AXI_DP_AWPROT),
        .M_AXI_DP_AWREADY(microblaze_riscv_0_M_AXI_DP_AWREADY),
        .M_AXI_DP_AWVALID(microblaze_riscv_0_M_AXI_DP_AWVALID),
        .M_AXI_DP_BREADY(microblaze_riscv_0_M_AXI_DP_BREADY),
        .M_AXI_DP_BRESP(microblaze_riscv_0_M_AXI_DP_BRESP),
        .M_AXI_DP_BVALID(microblaze_riscv_0_M_AXI_DP_BVALID),
        .M_AXI_DP_RDATA(microblaze_riscv_0_M_AXI_DP_RDATA),
        .M_AXI_DP_RREADY(microblaze_riscv_0_M_AXI_DP_RREADY),
        .M_AXI_DP_RRESP(microblaze_riscv_0_M_AXI_DP_RRESP),
        .M_AXI_DP_RVALID(microblaze_riscv_0_M_AXI_DP_RVALID),
        .M_AXI_DP_WDATA(microblaze_riscv_0_M_AXI_DP_WDATA),
        .M_AXI_DP_WREADY(microblaze_riscv_0_M_AXI_DP_WREADY),
        .M_AXI_DP_WSTRB(microblaze_riscv_0_M_AXI_DP_WSTRB),
        .M_AXI_DP_WVALID(microblaze_riscv_0_M_AXI_DP_WVALID),
        .M_AXI_IC_ARADDR(microblaze_riscv_0_M_AXI_IC_ARADDR),
        .M_AXI_IC_ARBURST(microblaze_riscv_0_M_AXI_IC_ARBURST),
        .M_AXI_IC_ARCACHE(microblaze_riscv_0_M_AXI_IC_ARCACHE),
        .M_AXI_IC_ARLEN(microblaze_riscv_0_M_AXI_IC_ARLEN),
        .M_AXI_IC_ARLOCK(microblaze_riscv_0_M_AXI_IC_ARLOCK),
        .M_AXI_IC_ARPROT(microblaze_riscv_0_M_AXI_IC_ARPROT),
        .M_AXI_IC_ARQOS(microblaze_riscv_0_M_AXI_IC_ARQOS),
        .M_AXI_IC_ARREADY(microblaze_riscv_0_M_AXI_IC_ARREADY),
        .M_AXI_IC_ARSIZE(microblaze_riscv_0_M_AXI_IC_ARSIZE),
        .M_AXI_IC_ARVALID(microblaze_riscv_0_M_AXI_IC_ARVALID),
        .M_AXI_IC_AWREADY(1'b0),
        .M_AXI_IC_BID(1'b0),
        .M_AXI_IC_BRESP({1'b0,1'b0}),
        .M_AXI_IC_BVALID(1'b0),
        .M_AXI_IC_RDATA(microblaze_riscv_0_M_AXI_IC_RDATA),
        .M_AXI_IC_RID(1'b0),
        .M_AXI_IC_RLAST(microblaze_riscv_0_M_AXI_IC_RLAST),
        .M_AXI_IC_RREADY(microblaze_riscv_0_M_AXI_IC_RREADY),
        .M_AXI_IC_RRESP(microblaze_riscv_0_M_AXI_IC_RRESP),
        .M_AXI_IC_RVALID(microblaze_riscv_0_M_AXI_IC_RVALID),
        .M_AXI_IC_WREADY(1'b0),
        .Read_Strobe(microblaze_riscv_0_dlmb_1_READSTROBE),
        .Reset(rst_mig_7series_0_100M_mb_reset),
        .Write_Strobe(microblaze_riscv_0_dlmb_1_WRITESTROBE));
  microblaze_riscv_0_local_memory_imp_13N7UL microblaze_riscv_0_local_memory
       (.DLMB_abus(microblaze_riscv_0_dlmb_1_ABUS),
        .DLMB_addrstrobe(microblaze_riscv_0_dlmb_1_ADDRSTROBE),
        .DLMB_be(microblaze_riscv_0_dlmb_1_BE),
        .DLMB_ce(microblaze_riscv_0_dlmb_1_CE),
        .DLMB_readdbus(microblaze_riscv_0_dlmb_1_READDBUS),
        .DLMB_readstrobe(microblaze_riscv_0_dlmb_1_READSTROBE),
        .DLMB_ready(microblaze_riscv_0_dlmb_1_READY),
        .DLMB_ue(microblaze_riscv_0_dlmb_1_UE),
        .DLMB_wait(microblaze_riscv_0_dlmb_1_WAIT),
        .DLMB_writedbus(microblaze_riscv_0_dlmb_1_WRITEDBUS),
        .DLMB_writestrobe(microblaze_riscv_0_dlmb_1_WRITESTROBE),
        .ILMB_abus(microblaze_riscv_0_ilmb_1_ABUS),
        .ILMB_addrstrobe(microblaze_riscv_0_ilmb_1_ADDRSTROBE),
        .ILMB_ce(microblaze_riscv_0_ilmb_1_CE),
        .ILMB_readdbus(microblaze_riscv_0_ilmb_1_READDBUS),
        .ILMB_readstrobe(microblaze_riscv_0_ilmb_1_READSTROBE),
        .ILMB_ready(microblaze_riscv_0_ilmb_1_READY),
        .ILMB_ue(microblaze_riscv_0_ilmb_1_UE),
        .ILMB_wait(microblaze_riscv_0_ilmb_1_WAIT),
        .LMB_Clk(clk_wiz_0_clk_out1),
        .SYS_Rst(rst_mig_7series_0_100M_bus_struct_reset));
  Capstone_With_AXI_Stream_mig_7series_0_0 mig_7series_0
       (.aresetn(rst_mig_7series_0_81M_peripheral_aresetn),
        .ddr2_addr(ddr2_sdram_addr),
        .ddr2_ba(ddr2_sdram_ba),
        .ddr2_cas_n(ddr2_sdram_cas_n),
        .ddr2_ck_n(ddr2_sdram_ck_n),
        .ddr2_ck_p(ddr2_sdram_ck_p),
        .ddr2_cke(ddr2_sdram_cke),
        .ddr2_cs_n(ddr2_sdram_cs_n),
        .ddr2_dm(ddr2_sdram_dm),
        .ddr2_dq(ddr2_sdram_dq),
        .ddr2_dqs_n(ddr2_sdram_dqs_n),
        .ddr2_dqs_p(ddr2_sdram_dqs_p),
        .ddr2_odt(ddr2_sdram_odt),
        .ddr2_ras_n(ddr2_sdram_ras_n),
        .ddr2_we_n(ddr2_sdram_we_n),
        .mmcm_locked(mig_7series_0_mmcm_locked),
        .s_axi_araddr(smartconnect_0_M02_AXI_ARADDR),
        .s_axi_arburst(smartconnect_0_M02_AXI_ARBURST),
        .s_axi_arcache(smartconnect_0_M02_AXI_ARCACHE),
        .s_axi_arid(1'b0),
        .s_axi_arlen(smartconnect_0_M02_AXI_ARLEN),
        .s_axi_arlock(smartconnect_0_M02_AXI_ARLOCK),
        .s_axi_arprot(smartconnect_0_M02_AXI_ARPROT),
        .s_axi_arqos(smartconnect_0_M02_AXI_ARQOS),
        .s_axi_arready(smartconnect_0_M02_AXI_ARREADY),
        .s_axi_arsize(smartconnect_0_M02_AXI_ARSIZE),
        .s_axi_arvalid(smartconnect_0_M02_AXI_ARVALID),
        .s_axi_awaddr(smartconnect_0_M02_AXI_AWADDR),
        .s_axi_awburst(smartconnect_0_M02_AXI_AWBURST),
        .s_axi_awcache(smartconnect_0_M02_AXI_AWCACHE),
        .s_axi_awid(1'b0),
        .s_axi_awlen(smartconnect_0_M02_AXI_AWLEN),
        .s_axi_awlock(smartconnect_0_M02_AXI_AWLOCK),
        .s_axi_awprot(smartconnect_0_M02_AXI_AWPROT),
        .s_axi_awqos(smartconnect_0_M02_AXI_AWQOS),
        .s_axi_awready(smartconnect_0_M02_AXI_AWREADY),
        .s_axi_awsize(smartconnect_0_M02_AXI_AWSIZE),
        .s_axi_awvalid(smartconnect_0_M02_AXI_AWVALID),
        .s_axi_bready(smartconnect_0_M02_AXI_BREADY),
        .s_axi_bresp(smartconnect_0_M02_AXI_BRESP),
        .s_axi_bvalid(smartconnect_0_M02_AXI_BVALID),
        .s_axi_rdata(smartconnect_0_M02_AXI_RDATA),
        .s_axi_rlast(smartconnect_0_M02_AXI_RLAST),
        .s_axi_rready(smartconnect_0_M02_AXI_RREADY),
        .s_axi_rresp(smartconnect_0_M02_AXI_RRESP),
        .s_axi_rvalid(smartconnect_0_M02_AXI_RVALID),
        .s_axi_wdata(smartconnect_0_M02_AXI_WDATA),
        .s_axi_wlast(smartconnect_0_M02_AXI_WLAST),
        .s_axi_wready(smartconnect_0_M02_AXI_WREADY),
        .s_axi_wstrb(smartconnect_0_M02_AXI_WSTRB),
        .s_axi_wvalid(smartconnect_0_M02_AXI_WVALID),
        .sys_clk_i(clk_wiz_0_clk_out1),
        .sys_rst(reset),
        .ui_clk(mig_7series_0_ui_clk),
        .ui_clk_sync_rst(mig_7series_0_ui_clk_sync_rst));
  Capstone_With_AXI_Stream_reset_inv_0_0 reset_inv_0
       (.Op1(reset),
        .Res(reset_inv_0_Res));
  Capstone_With_AXI_Stream_rst_mig_7series_0_100M_0 rst_mig_7series_0_100M
       (.aux_reset_in(1'b1),
        .bus_struct_reset(rst_mig_7series_0_100M_bus_struct_reset),
        .dcm_locked(mig_7series_0_mmcm_locked),
        .ext_reset_in(reset),
        .mb_debug_sys_rst(mdm_1_debug_sys_rst),
        .mb_reset(rst_mig_7series_0_100M_mb_reset),
        .peripheral_aresetn(rst_mig_7series_0_100M_peripheral_aresetn),
        .slowest_sync_clk(clk_wiz_0_clk_out1));
  Capstone_With_AXI_Stream_rst_mig_7series_0_81M_0 rst_mig_7series_0_81M
       (.aux_reset_in(1'b1),
        .dcm_locked(mig_7series_0_mmcm_locked),
        .ext_reset_in(mig_7series_0_ui_clk_sync_rst),
        .mb_debug_sys_rst(1'b0),
        .peripheral_aresetn(rst_mig_7series_0_81M_peripheral_aresetn),
        .slowest_sync_clk(mig_7series_0_ui_clk));
  Capstone_With_AXI_Stream_smartconnect_0_0 smartconnect_0
       (.M00_AXI_araddr(smartconnect_0_M00_AXI_ARADDR),
        .M00_AXI_arready(smartconnect_0_M00_AXI_ARREADY),
        .M00_AXI_arvalid(smartconnect_0_M00_AXI_ARVALID),
        .M00_AXI_awaddr(smartconnect_0_M00_AXI_AWADDR),
        .M00_AXI_awready(smartconnect_0_M00_AXI_AWREADY),
        .M00_AXI_awvalid(smartconnect_0_M00_AXI_AWVALID),
        .M00_AXI_bready(smartconnect_0_M00_AXI_BREADY),
        .M00_AXI_bresp(smartconnect_0_M00_AXI_BRESP),
        .M00_AXI_bvalid(smartconnect_0_M00_AXI_BVALID),
        .M00_AXI_rdata(smartconnect_0_M00_AXI_RDATA),
        .M00_AXI_rready(smartconnect_0_M00_AXI_RREADY),
        .M00_AXI_rresp(smartconnect_0_M00_AXI_RRESP),
        .M00_AXI_rvalid(smartconnect_0_M00_AXI_RVALID),
        .M00_AXI_wdata(smartconnect_0_M00_AXI_WDATA),
        .M00_AXI_wready(smartconnect_0_M00_AXI_WREADY),
        .M00_AXI_wstrb(smartconnect_0_M00_AXI_WSTRB),
        .M00_AXI_wvalid(smartconnect_0_M00_AXI_WVALID),
        .M01_AXI_araddr(smartconnect_0_M01_AXI_ARADDR),
        .M01_AXI_arprot(smartconnect_0_M01_AXI_ARPROT),
        .M01_AXI_arready(smartconnect_0_M01_AXI_ARREADY),
        .M01_AXI_arvalid(smartconnect_0_M01_AXI_ARVALID),
        .M01_AXI_awaddr(smartconnect_0_M01_AXI_AWADDR),
        .M01_AXI_awprot(smartconnect_0_M01_AXI_AWPROT),
        .M01_AXI_awready(smartconnect_0_M01_AXI_AWREADY),
        .M01_AXI_awvalid(smartconnect_0_M01_AXI_AWVALID),
        .M01_AXI_bready(smartconnect_0_M01_AXI_BREADY),
        .M01_AXI_bresp(smartconnect_0_M01_AXI_BRESP),
        .M01_AXI_bvalid(smartconnect_0_M01_AXI_BVALID),
        .M01_AXI_rdata(smartconnect_0_M01_AXI_RDATA),
        .M01_AXI_rready(smartconnect_0_M01_AXI_RREADY),
        .M01_AXI_rresp(smartconnect_0_M01_AXI_RRESP),
        .M01_AXI_rvalid(smartconnect_0_M01_AXI_RVALID),
        .M01_AXI_wdata(smartconnect_0_M01_AXI_WDATA),
        .M01_AXI_wready(smartconnect_0_M01_AXI_WREADY),
        .M01_AXI_wstrb(smartconnect_0_M01_AXI_WSTRB),
        .M01_AXI_wvalid(smartconnect_0_M01_AXI_WVALID),
        .M02_AXI_araddr(smartconnect_0_M02_AXI_ARADDR),
        .M02_AXI_arburst(smartconnect_0_M02_AXI_ARBURST),
        .M02_AXI_arcache(smartconnect_0_M02_AXI_ARCACHE),
        .M02_AXI_arlen(smartconnect_0_M02_AXI_ARLEN),
        .M02_AXI_arlock(smartconnect_0_M02_AXI_ARLOCK),
        .M02_AXI_arprot(smartconnect_0_M02_AXI_ARPROT),
        .M02_AXI_arqos(smartconnect_0_M02_AXI_ARQOS),
        .M02_AXI_arready(smartconnect_0_M02_AXI_ARREADY),
        .M02_AXI_arsize(smartconnect_0_M02_AXI_ARSIZE),
        .M02_AXI_arvalid(smartconnect_0_M02_AXI_ARVALID),
        .M02_AXI_awaddr(smartconnect_0_M02_AXI_AWADDR),
        .M02_AXI_awburst(smartconnect_0_M02_AXI_AWBURST),
        .M02_AXI_awcache(smartconnect_0_M02_AXI_AWCACHE),
        .M02_AXI_awlen(smartconnect_0_M02_AXI_AWLEN),
        .M02_AXI_awlock(smartconnect_0_M02_AXI_AWLOCK),
        .M02_AXI_awprot(smartconnect_0_M02_AXI_AWPROT),
        .M02_AXI_awqos(smartconnect_0_M02_AXI_AWQOS),
        .M02_AXI_awready(smartconnect_0_M02_AXI_AWREADY),
        .M02_AXI_awsize(smartconnect_0_M02_AXI_AWSIZE),
        .M02_AXI_awvalid(smartconnect_0_M02_AXI_AWVALID),
        .M02_AXI_bready(smartconnect_0_M02_AXI_BREADY),
        .M02_AXI_bresp(smartconnect_0_M02_AXI_BRESP),
        .M02_AXI_bvalid(smartconnect_0_M02_AXI_BVALID),
        .M02_AXI_rdata(smartconnect_0_M02_AXI_RDATA),
        .M02_AXI_rlast(smartconnect_0_M02_AXI_RLAST),
        .M02_AXI_rready(smartconnect_0_M02_AXI_RREADY),
        .M02_AXI_rresp(smartconnect_0_M02_AXI_RRESP),
        .M02_AXI_rvalid(smartconnect_0_M02_AXI_RVALID),
        .M02_AXI_wdata(smartconnect_0_M02_AXI_WDATA),
        .M02_AXI_wlast(smartconnect_0_M02_AXI_WLAST),
        .M02_AXI_wready(smartconnect_0_M02_AXI_WREADY),
        .M02_AXI_wstrb(smartconnect_0_M02_AXI_WSTRB),
        .M02_AXI_wvalid(smartconnect_0_M02_AXI_WVALID),
        .M03_AXI_araddr(smartconnect_0_M03_AXI_ARADDR),
        .M03_AXI_arready(smartconnect_0_M03_AXI_ARREADY),
        .M03_AXI_arvalid(smartconnect_0_M03_AXI_ARVALID),
        .M03_AXI_awaddr(smartconnect_0_M03_AXI_AWADDR),
        .M03_AXI_awready(smartconnect_0_M03_AXI_AWREADY),
        .M03_AXI_awvalid(smartconnect_0_M03_AXI_AWVALID),
        .M03_AXI_bready(smartconnect_0_M03_AXI_BREADY),
        .M03_AXI_bresp(smartconnect_0_M03_AXI_BRESP),
        .M03_AXI_bvalid(smartconnect_0_M03_AXI_BVALID),
        .M03_AXI_rdata(smartconnect_0_M03_AXI_RDATA),
        .M03_AXI_rready(smartconnect_0_M03_AXI_RREADY),
        .M03_AXI_rresp(smartconnect_0_M03_AXI_RRESP),
        .M03_AXI_rvalid(smartconnect_0_M03_AXI_RVALID),
        .M03_AXI_wdata(smartconnect_0_M03_AXI_WDATA),
        .M03_AXI_wready(smartconnect_0_M03_AXI_WREADY),
        .M03_AXI_wvalid(smartconnect_0_M03_AXI_WVALID),
        .M04_AXI_araddr(smartconnect_0_M04_AXI_ARADDR),
        .M04_AXI_arready(smartconnect_0_M04_AXI_ARREADY),
        .M04_AXI_arvalid(smartconnect_0_M04_AXI_ARVALID),
        .M04_AXI_awaddr(smartconnect_0_M04_AXI_AWADDR),
        .M04_AXI_awready(smartconnect_0_M04_AXI_AWREADY),
        .M04_AXI_awvalid(smartconnect_0_M04_AXI_AWVALID),
        .M04_AXI_bready(smartconnect_0_M04_AXI_BREADY),
        .M04_AXI_bresp(smartconnect_0_M04_AXI_BRESP),
        .M04_AXI_bvalid(smartconnect_0_M04_AXI_BVALID),
        .M04_AXI_rdata(smartconnect_0_M04_AXI_RDATA),
        .M04_AXI_rready(smartconnect_0_M04_AXI_RREADY),
        .M04_AXI_rresp(smartconnect_0_M04_AXI_RRESP),
        .M04_AXI_rvalid(smartconnect_0_M04_AXI_RVALID),
        .M04_AXI_wdata(smartconnect_0_M04_AXI_WDATA),
        .M04_AXI_wready(smartconnect_0_M04_AXI_WREADY),
        .M04_AXI_wvalid(smartconnect_0_M04_AXI_WVALID),
        .M05_AXI_araddr(smartconnect_0_M05_AXI_ARADDR),
        .M05_AXI_arready(smartconnect_0_M05_AXI_ARREADY),
        .M05_AXI_arvalid(smartconnect_0_M05_AXI_ARVALID),
        .M05_AXI_awaddr(smartconnect_0_M05_AXI_AWADDR),
        .M05_AXI_awready(smartconnect_0_M05_AXI_AWREADY),
        .M05_AXI_awvalid(smartconnect_0_M05_AXI_AWVALID),
        .M05_AXI_bready(smartconnect_0_M05_AXI_BREADY),
        .M05_AXI_bresp(smartconnect_0_M05_AXI_BRESP),
        .M05_AXI_bvalid(smartconnect_0_M05_AXI_BVALID),
        .M05_AXI_rdata(smartconnect_0_M05_AXI_RDATA),
        .M05_AXI_rready(smartconnect_0_M05_AXI_RREADY),
        .M05_AXI_rresp(smartconnect_0_M05_AXI_RRESP),
        .M05_AXI_rvalid(smartconnect_0_M05_AXI_RVALID),
        .M05_AXI_wdata(smartconnect_0_M05_AXI_WDATA),
        .M05_AXI_wready(smartconnect_0_M05_AXI_WREADY),
        .M05_AXI_wvalid(smartconnect_0_M05_AXI_WVALID),
        .S00_AXI_araddr(microblaze_riscv_0_M_AXI_DP_ARADDR),
        .S00_AXI_arprot(microblaze_riscv_0_M_AXI_DP_ARPROT),
        .S00_AXI_arready(microblaze_riscv_0_M_AXI_DP_ARREADY),
        .S00_AXI_arvalid(microblaze_riscv_0_M_AXI_DP_ARVALID),
        .S00_AXI_awaddr(microblaze_riscv_0_M_AXI_DP_AWADDR),
        .S00_AXI_awprot(microblaze_riscv_0_M_AXI_DP_AWPROT),
        .S00_AXI_awready(microblaze_riscv_0_M_AXI_DP_AWREADY),
        .S00_AXI_awvalid(microblaze_riscv_0_M_AXI_DP_AWVALID),
        .S00_AXI_bready(microblaze_riscv_0_M_AXI_DP_BREADY),
        .S00_AXI_bresp(microblaze_riscv_0_M_AXI_DP_BRESP),
        .S00_AXI_bvalid(microblaze_riscv_0_M_AXI_DP_BVALID),
        .S00_AXI_rdata(microblaze_riscv_0_M_AXI_DP_RDATA),
        .S00_AXI_rready(microblaze_riscv_0_M_AXI_DP_RREADY),
        .S00_AXI_rresp(microblaze_riscv_0_M_AXI_DP_RRESP),
        .S00_AXI_rvalid(microblaze_riscv_0_M_AXI_DP_RVALID),
        .S00_AXI_wdata(microblaze_riscv_0_M_AXI_DP_WDATA),
        .S00_AXI_wready(microblaze_riscv_0_M_AXI_DP_WREADY),
        .S00_AXI_wstrb(microblaze_riscv_0_M_AXI_DP_WSTRB),
        .S00_AXI_wvalid(microblaze_riscv_0_M_AXI_DP_WVALID),
        .S01_AXI_araddr(microblaze_riscv_0_M_AXI_DC_ARADDR),
        .S01_AXI_arburst(microblaze_riscv_0_M_AXI_DC_ARBURST),
        .S01_AXI_arcache(microblaze_riscv_0_M_AXI_DC_ARCACHE),
        .S01_AXI_arlen(microblaze_riscv_0_M_AXI_DC_ARLEN),
        .S01_AXI_arlock(microblaze_riscv_0_M_AXI_DC_ARLOCK),
        .S01_AXI_arprot(microblaze_riscv_0_M_AXI_DC_ARPROT),
        .S01_AXI_arqos(microblaze_riscv_0_M_AXI_DC_ARQOS),
        .S01_AXI_arready(microblaze_riscv_0_M_AXI_DC_ARREADY),
        .S01_AXI_arsize(microblaze_riscv_0_M_AXI_DC_ARSIZE),
        .S01_AXI_arvalid(microblaze_riscv_0_M_AXI_DC_ARVALID),
        .S01_AXI_awaddr(microblaze_riscv_0_M_AXI_DC_AWADDR),
        .S01_AXI_awburst(microblaze_riscv_0_M_AXI_DC_AWBURST),
        .S01_AXI_awcache(microblaze_riscv_0_M_AXI_DC_AWCACHE),
        .S01_AXI_awlen(microblaze_riscv_0_M_AXI_DC_AWLEN),
        .S01_AXI_awlock(microblaze_riscv_0_M_AXI_DC_AWLOCK),
        .S01_AXI_awprot(microblaze_riscv_0_M_AXI_DC_AWPROT),
        .S01_AXI_awqos(microblaze_riscv_0_M_AXI_DC_AWQOS),
        .S01_AXI_awready(microblaze_riscv_0_M_AXI_DC_AWREADY),
        .S01_AXI_awsize(microblaze_riscv_0_M_AXI_DC_AWSIZE),
        .S01_AXI_awvalid(microblaze_riscv_0_M_AXI_DC_AWVALID),
        .S01_AXI_bready(microblaze_riscv_0_M_AXI_DC_BREADY),
        .S01_AXI_bresp(microblaze_riscv_0_M_AXI_DC_BRESP),
        .S01_AXI_bvalid(microblaze_riscv_0_M_AXI_DC_BVALID),
        .S01_AXI_rdata(microblaze_riscv_0_M_AXI_DC_RDATA),
        .S01_AXI_rlast(microblaze_riscv_0_M_AXI_DC_RLAST),
        .S01_AXI_rready(microblaze_riscv_0_M_AXI_DC_RREADY),
        .S01_AXI_rresp(microblaze_riscv_0_M_AXI_DC_RRESP),
        .S01_AXI_rvalid(microblaze_riscv_0_M_AXI_DC_RVALID),
        .S01_AXI_wdata(microblaze_riscv_0_M_AXI_DC_WDATA),
        .S01_AXI_wlast(microblaze_riscv_0_M_AXI_DC_WLAST),
        .S01_AXI_wready(microblaze_riscv_0_M_AXI_DC_WREADY),
        .S01_AXI_wstrb(microblaze_riscv_0_M_AXI_DC_WSTRB),
        .S01_AXI_wvalid(microblaze_riscv_0_M_AXI_DC_WVALID),
        .S02_AXI_araddr(microblaze_riscv_0_M_AXI_IC_ARADDR),
        .S02_AXI_arburst(microblaze_riscv_0_M_AXI_IC_ARBURST),
        .S02_AXI_arcache(microblaze_riscv_0_M_AXI_IC_ARCACHE),
        .S02_AXI_arlen(microblaze_riscv_0_M_AXI_IC_ARLEN),
        .S02_AXI_arlock(microblaze_riscv_0_M_AXI_IC_ARLOCK),
        .S02_AXI_arprot(microblaze_riscv_0_M_AXI_IC_ARPROT),
        .S02_AXI_arqos(microblaze_riscv_0_M_AXI_IC_ARQOS),
        .S02_AXI_arready(microblaze_riscv_0_M_AXI_IC_ARREADY),
        .S02_AXI_arsize(microblaze_riscv_0_M_AXI_IC_ARSIZE),
        .S02_AXI_arvalid(microblaze_riscv_0_M_AXI_IC_ARVALID),
        .S02_AXI_rdata(microblaze_riscv_0_M_AXI_IC_RDATA),
        .S02_AXI_rlast(microblaze_riscv_0_M_AXI_IC_RLAST),
        .S02_AXI_rready(microblaze_riscv_0_M_AXI_IC_RREADY),
        .S02_AXI_rresp(microblaze_riscv_0_M_AXI_IC_RRESP),
        .S02_AXI_rvalid(microblaze_riscv_0_M_AXI_IC_RVALID),
        .S03_AXI_araddr(axi_dma_a_M_AXI_MM2S_ARADDR),
        .S03_AXI_arburst(axi_dma_a_M_AXI_MM2S_ARBURST),
        .S03_AXI_arcache(axi_dma_a_M_AXI_MM2S_ARCACHE),
        .S03_AXI_arlen(axi_dma_a_M_AXI_MM2S_ARLEN),
        .S03_AXI_arlock(1'b0),
        .S03_AXI_arprot(axi_dma_a_M_AXI_MM2S_ARPROT),
        .S03_AXI_arqos({1'b0,1'b0,1'b0,1'b0}),
        .S03_AXI_arready(axi_dma_a_M_AXI_MM2S_ARREADY),
        .S03_AXI_arsize(axi_dma_a_M_AXI_MM2S_ARSIZE),
        .S03_AXI_arvalid(axi_dma_a_M_AXI_MM2S_ARVALID),
        .S03_AXI_rdata(axi_dma_a_M_AXI_MM2S_RDATA),
        .S03_AXI_rlast(axi_dma_a_M_AXI_MM2S_RLAST),
        .S03_AXI_rready(axi_dma_a_M_AXI_MM2S_RREADY),
        .S03_AXI_rresp(axi_dma_a_M_AXI_MM2S_RRESP),
        .S03_AXI_rvalid(axi_dma_a_M_AXI_MM2S_RVALID),
        .S04_AXI_araddr(axi_dma_b_M_AXI_MM2S_ARADDR),
        .S04_AXI_arburst(axi_dma_b_M_AXI_MM2S_ARBURST),
        .S04_AXI_arcache(axi_dma_b_M_AXI_MM2S_ARCACHE),
        .S04_AXI_arlen(axi_dma_b_M_AXI_MM2S_ARLEN),
        .S04_AXI_arlock(1'b0),
        .S04_AXI_arprot(axi_dma_b_M_AXI_MM2S_ARPROT),
        .S04_AXI_arqos({1'b0,1'b0,1'b0,1'b0}),
        .S04_AXI_arready(axi_dma_b_M_AXI_MM2S_ARREADY),
        .S04_AXI_arsize(axi_dma_b_M_AXI_MM2S_ARSIZE),
        .S04_AXI_arvalid(axi_dma_b_M_AXI_MM2S_ARVALID),
        .S04_AXI_rdata(axi_dma_b_M_AXI_MM2S_RDATA),
        .S04_AXI_rlast(axi_dma_b_M_AXI_MM2S_RLAST),
        .S04_AXI_rready(axi_dma_b_M_AXI_MM2S_RREADY),
        .S04_AXI_rresp(axi_dma_b_M_AXI_MM2S_RRESP),
        .S04_AXI_rvalid(axi_dma_b_M_AXI_MM2S_RVALID),
        .S05_AXI_awaddr(axi_dma_c_M_AXI_S2MM_AWADDR),
        .S05_AXI_awburst(axi_dma_c_M_AXI_S2MM_AWBURST),
        .S05_AXI_awcache(axi_dma_c_M_AXI_S2MM_AWCACHE),
        .S05_AXI_awlen(axi_dma_c_M_AXI_S2MM_AWLEN),
        .S05_AXI_awlock(1'b0),
        .S05_AXI_awprot(axi_dma_c_M_AXI_S2MM_AWPROT),
        .S05_AXI_awqos({1'b0,1'b0,1'b0,1'b0}),
        .S05_AXI_awready(axi_dma_c_M_AXI_S2MM_AWREADY),
        .S05_AXI_awsize(axi_dma_c_M_AXI_S2MM_AWSIZE),
        .S05_AXI_awvalid(axi_dma_c_M_AXI_S2MM_AWVALID),
        .S05_AXI_bready(axi_dma_c_M_AXI_S2MM_BREADY),
        .S05_AXI_bresp(axi_dma_c_M_AXI_S2MM_BRESP),
        .S05_AXI_bvalid(axi_dma_c_M_AXI_S2MM_BVALID),
        .S05_AXI_wdata(axi_dma_c_M_AXI_S2MM_WDATA),
        .S05_AXI_wlast(axi_dma_c_M_AXI_S2MM_WLAST),
        .S05_AXI_wready(axi_dma_c_M_AXI_S2MM_WREADY),
        .S05_AXI_wstrb(axi_dma_c_M_AXI_S2MM_WSTRB),
        .S05_AXI_wvalid(axi_dma_c_M_AXI_S2MM_WVALID),
        .aclk(clk_wiz_0_clk_out1),
        .aclk1(mig_7series_0_ui_clk),
        .aresetn(rst_mig_7series_0_100M_peripheral_aresetn));
endmodule

module microblaze_riscv_0_local_memory_imp_13N7UL
   (DLMB_abus,
    DLMB_addrstrobe,
    DLMB_be,
    DLMB_ce,
    DLMB_readdbus,
    DLMB_readstrobe,
    DLMB_ready,
    DLMB_ue,
    DLMB_wait,
    DLMB_writedbus,
    DLMB_writestrobe,
    ILMB_abus,
    ILMB_addrstrobe,
    ILMB_ce,
    ILMB_readdbus,
    ILMB_readstrobe,
    ILMB_ready,
    ILMB_ue,
    ILMB_wait,
    LMB_Clk,
    SYS_Rst);
  input [0:31]DLMB_abus;
  input DLMB_addrstrobe;
  input [0:3]DLMB_be;
  output DLMB_ce;
  output [0:31]DLMB_readdbus;
  input DLMB_readstrobe;
  output DLMB_ready;
  output DLMB_ue;
  output DLMB_wait;
  input [0:31]DLMB_writedbus;
  input DLMB_writestrobe;
  input [0:31]ILMB_abus;
  input ILMB_addrstrobe;
  output ILMB_ce;
  output [0:31]ILMB_readdbus;
  input ILMB_readstrobe;
  output ILMB_ready;
  output ILMB_ue;
  output ILMB_wait;
  input LMB_Clk;
  input SYS_Rst;

  wire [0:31]DLMB_abus;
  wire DLMB_addrstrobe;
  wire [0:3]DLMB_be;
  wire DLMB_ce;
  wire [0:31]DLMB_readdbus;
  wire DLMB_readstrobe;
  wire DLMB_ready;
  wire DLMB_ue;
  wire DLMB_wait;
  wire [0:31]DLMB_writedbus;
  wire DLMB_writestrobe;
  wire [0:31]ILMB_abus;
  wire ILMB_addrstrobe;
  wire ILMB_ce;
  wire [0:31]ILMB_readdbus;
  wire ILMB_readstrobe;
  wire ILMB_ready;
  wire ILMB_ue;
  wire ILMB_wait;
  wire LMB_Clk;
  wire SYS_Rst;
  wire [0:31]microblaze_riscv_0_dlmb_bus_ABUS;
  wire microblaze_riscv_0_dlmb_bus_ADDRSTROBE;
  wire [0:3]microblaze_riscv_0_dlmb_bus_BE;
  wire microblaze_riscv_0_dlmb_bus_CE;
  wire [0:31]microblaze_riscv_0_dlmb_bus_READDBUS;
  wire microblaze_riscv_0_dlmb_bus_READSTROBE;
  wire microblaze_riscv_0_dlmb_bus_READY;
  wire microblaze_riscv_0_dlmb_bus_UE;
  wire microblaze_riscv_0_dlmb_bus_WAIT;
  wire [0:31]microblaze_riscv_0_dlmb_bus_WRITEDBUS;
  wire microblaze_riscv_0_dlmb_bus_WRITESTROBE;
  wire [0:31]microblaze_riscv_0_dlmb_cntlr_ADDR;
  wire microblaze_riscv_0_dlmb_cntlr_CLK;
  wire [0:31]microblaze_riscv_0_dlmb_cntlr_DIN;
  wire [31:0]microblaze_riscv_0_dlmb_cntlr_DOUT;
  wire microblaze_riscv_0_dlmb_cntlr_EN;
  wire microblaze_riscv_0_dlmb_cntlr_RST;
  wire [0:3]microblaze_riscv_0_dlmb_cntlr_WE;
  wire [0:31]microblaze_riscv_0_ilmb_bus_ABUS;
  wire microblaze_riscv_0_ilmb_bus_ADDRSTROBE;
  wire [0:3]microblaze_riscv_0_ilmb_bus_BE;
  wire microblaze_riscv_0_ilmb_bus_CE;
  wire [0:31]microblaze_riscv_0_ilmb_bus_READDBUS;
  wire microblaze_riscv_0_ilmb_bus_READSTROBE;
  wire microblaze_riscv_0_ilmb_bus_READY;
  wire microblaze_riscv_0_ilmb_bus_UE;
  wire microblaze_riscv_0_ilmb_bus_WAIT;
  wire [0:31]microblaze_riscv_0_ilmb_bus_WRITEDBUS;
  wire microblaze_riscv_0_ilmb_bus_WRITESTROBE;
  wire [0:31]microblaze_riscv_0_ilmb_cntlr_ADDR;
  wire microblaze_riscv_0_ilmb_cntlr_CLK;
  wire [0:31]microblaze_riscv_0_ilmb_cntlr_DIN;
  wire [31:0]microblaze_riscv_0_ilmb_cntlr_DOUT;
  wire microblaze_riscv_0_ilmb_cntlr_EN;
  wire microblaze_riscv_0_ilmb_cntlr_RST;
  wire [0:3]microblaze_riscv_0_ilmb_cntlr_WE;

  (* BMM_INFO_ADDRESS_SPACE = "byte  0x00000000 32 > Capstone_With_AXI_Stream microblaze_riscv_0_local_memory/lmb_bram" *) 
  (* KEEP_HIERARCHY = "yes" *) 
  Capstone_With_AXI_Stream_dlmb_bram_if_cntlr_0 dlmb_bram_if_cntlr
       (.BRAM_Addr_A(microblaze_riscv_0_dlmb_cntlr_ADDR),
        .BRAM_Clk_A(microblaze_riscv_0_dlmb_cntlr_CLK),
        .BRAM_Din_A({microblaze_riscv_0_dlmb_cntlr_DOUT[31],microblaze_riscv_0_dlmb_cntlr_DOUT[30],microblaze_riscv_0_dlmb_cntlr_DOUT[29],microblaze_riscv_0_dlmb_cntlr_DOUT[28],microblaze_riscv_0_dlmb_cntlr_DOUT[27],microblaze_riscv_0_dlmb_cntlr_DOUT[26],microblaze_riscv_0_dlmb_cntlr_DOUT[25],microblaze_riscv_0_dlmb_cntlr_DOUT[24],microblaze_riscv_0_dlmb_cntlr_DOUT[23],microblaze_riscv_0_dlmb_cntlr_DOUT[22],microblaze_riscv_0_dlmb_cntlr_DOUT[21],microblaze_riscv_0_dlmb_cntlr_DOUT[20],microblaze_riscv_0_dlmb_cntlr_DOUT[19],microblaze_riscv_0_dlmb_cntlr_DOUT[18],microblaze_riscv_0_dlmb_cntlr_DOUT[17],microblaze_riscv_0_dlmb_cntlr_DOUT[16],microblaze_riscv_0_dlmb_cntlr_DOUT[15],microblaze_riscv_0_dlmb_cntlr_DOUT[14],microblaze_riscv_0_dlmb_cntlr_DOUT[13],microblaze_riscv_0_dlmb_cntlr_DOUT[12],microblaze_riscv_0_dlmb_cntlr_DOUT[11],microblaze_riscv_0_dlmb_cntlr_DOUT[10],microblaze_riscv_0_dlmb_cntlr_DOUT[9],microblaze_riscv_0_dlmb_cntlr_DOUT[8],microblaze_riscv_0_dlmb_cntlr_DOUT[7],microblaze_riscv_0_dlmb_cntlr_DOUT[6],microblaze_riscv_0_dlmb_cntlr_DOUT[5],microblaze_riscv_0_dlmb_cntlr_DOUT[4],microblaze_riscv_0_dlmb_cntlr_DOUT[3],microblaze_riscv_0_dlmb_cntlr_DOUT[2],microblaze_riscv_0_dlmb_cntlr_DOUT[1],microblaze_riscv_0_dlmb_cntlr_DOUT[0]}),
        .BRAM_Dout_A(microblaze_riscv_0_dlmb_cntlr_DIN),
        .BRAM_EN_A(microblaze_riscv_0_dlmb_cntlr_EN),
        .BRAM_Rst_A(microblaze_riscv_0_dlmb_cntlr_RST),
        .BRAM_WEN_A(microblaze_riscv_0_dlmb_cntlr_WE),
        .LMB_ABus(microblaze_riscv_0_dlmb_bus_ABUS),
        .LMB_AddrStrobe(microblaze_riscv_0_dlmb_bus_ADDRSTROBE),
        .LMB_BE(microblaze_riscv_0_dlmb_bus_BE),
        .LMB_Clk(LMB_Clk),
        .LMB_ReadStrobe(microblaze_riscv_0_dlmb_bus_READSTROBE),
        .LMB_Rst(SYS_Rst),
        .LMB_WriteDBus(microblaze_riscv_0_dlmb_bus_WRITEDBUS),
        .LMB_WriteStrobe(microblaze_riscv_0_dlmb_bus_WRITESTROBE),
        .Sl_CE(microblaze_riscv_0_dlmb_bus_CE),
        .Sl_DBus(microblaze_riscv_0_dlmb_bus_READDBUS),
        .Sl_Ready(microblaze_riscv_0_dlmb_bus_READY),
        .Sl_UE(microblaze_riscv_0_dlmb_bus_UE),
        .Sl_Wait(microblaze_riscv_0_dlmb_bus_WAIT));
  Capstone_With_AXI_Stream_dlmb_v10_0 dlmb_v10
       (.LMB_ABus(microblaze_riscv_0_dlmb_bus_ABUS),
        .LMB_AddrStrobe(microblaze_riscv_0_dlmb_bus_ADDRSTROBE),
        .LMB_BE(microblaze_riscv_0_dlmb_bus_BE),
        .LMB_CE(DLMB_ce),
        .LMB_Clk(LMB_Clk),
        .LMB_ReadDBus(DLMB_readdbus),
        .LMB_ReadStrobe(microblaze_riscv_0_dlmb_bus_READSTROBE),
        .LMB_Ready(DLMB_ready),
        .LMB_UE(DLMB_ue),
        .LMB_Wait(DLMB_wait),
        .LMB_WriteDBus(microblaze_riscv_0_dlmb_bus_WRITEDBUS),
        .LMB_WriteStrobe(microblaze_riscv_0_dlmb_bus_WRITESTROBE),
        .M_ABus(DLMB_abus),
        .M_AddrStrobe(DLMB_addrstrobe),
        .M_BE(DLMB_be),
        .M_DBus(DLMB_writedbus),
        .M_ReadStrobe(DLMB_readstrobe),
        .M_WriteStrobe(DLMB_writestrobe),
        .SYS_Rst(SYS_Rst),
        .Sl_CE(microblaze_riscv_0_dlmb_bus_CE),
        .Sl_DBus(microblaze_riscv_0_dlmb_bus_READDBUS),
        .Sl_Ready(microblaze_riscv_0_dlmb_bus_READY),
        .Sl_UE(microblaze_riscv_0_dlmb_bus_UE),
        .Sl_Wait(microblaze_riscv_0_dlmb_bus_WAIT));
  Capstone_With_AXI_Stream_ilmb_bram_if_cntlr_0 ilmb_bram_if_cntlr
       (.BRAM_Addr_A(microblaze_riscv_0_ilmb_cntlr_ADDR),
        .BRAM_Clk_A(microblaze_riscv_0_ilmb_cntlr_CLK),
        .BRAM_Din_A({microblaze_riscv_0_ilmb_cntlr_DOUT[31],microblaze_riscv_0_ilmb_cntlr_DOUT[30],microblaze_riscv_0_ilmb_cntlr_DOUT[29],microblaze_riscv_0_ilmb_cntlr_DOUT[28],microblaze_riscv_0_ilmb_cntlr_DOUT[27],microblaze_riscv_0_ilmb_cntlr_DOUT[26],microblaze_riscv_0_ilmb_cntlr_DOUT[25],microblaze_riscv_0_ilmb_cntlr_DOUT[24],microblaze_riscv_0_ilmb_cntlr_DOUT[23],microblaze_riscv_0_ilmb_cntlr_DOUT[22],microblaze_riscv_0_ilmb_cntlr_DOUT[21],microblaze_riscv_0_ilmb_cntlr_DOUT[20],microblaze_riscv_0_ilmb_cntlr_DOUT[19],microblaze_riscv_0_ilmb_cntlr_DOUT[18],microblaze_riscv_0_ilmb_cntlr_DOUT[17],microblaze_riscv_0_ilmb_cntlr_DOUT[16],microblaze_riscv_0_ilmb_cntlr_DOUT[15],microblaze_riscv_0_ilmb_cntlr_DOUT[14],microblaze_riscv_0_ilmb_cntlr_DOUT[13],microblaze_riscv_0_ilmb_cntlr_DOUT[12],microblaze_riscv_0_ilmb_cntlr_DOUT[11],microblaze_riscv_0_ilmb_cntlr_DOUT[10],microblaze_riscv_0_ilmb_cntlr_DOUT[9],microblaze_riscv_0_ilmb_cntlr_DOUT[8],microblaze_riscv_0_ilmb_cntlr_DOUT[7],microblaze_riscv_0_ilmb_cntlr_DOUT[6],microblaze_riscv_0_ilmb_cntlr_DOUT[5],microblaze_riscv_0_ilmb_cntlr_DOUT[4],microblaze_riscv_0_ilmb_cntlr_DOUT[3],microblaze_riscv_0_ilmb_cntlr_DOUT[2],microblaze_riscv_0_ilmb_cntlr_DOUT[1],microblaze_riscv_0_ilmb_cntlr_DOUT[0]}),
        .BRAM_Dout_A(microblaze_riscv_0_ilmb_cntlr_DIN),
        .BRAM_EN_A(microblaze_riscv_0_ilmb_cntlr_EN),
        .BRAM_Rst_A(microblaze_riscv_0_ilmb_cntlr_RST),
        .BRAM_WEN_A(microblaze_riscv_0_ilmb_cntlr_WE),
        .LMB_ABus(microblaze_riscv_0_ilmb_bus_ABUS),
        .LMB_AddrStrobe(microblaze_riscv_0_ilmb_bus_ADDRSTROBE),
        .LMB_BE(microblaze_riscv_0_ilmb_bus_BE),
        .LMB_Clk(LMB_Clk),
        .LMB_ReadStrobe(microblaze_riscv_0_ilmb_bus_READSTROBE),
        .LMB_Rst(SYS_Rst),
        .LMB_WriteDBus(microblaze_riscv_0_ilmb_bus_WRITEDBUS),
        .LMB_WriteStrobe(microblaze_riscv_0_ilmb_bus_WRITESTROBE),
        .Sl_CE(microblaze_riscv_0_ilmb_bus_CE),
        .Sl_DBus(microblaze_riscv_0_ilmb_bus_READDBUS),
        .Sl_Ready(microblaze_riscv_0_ilmb_bus_READY),
        .Sl_UE(microblaze_riscv_0_ilmb_bus_UE),
        .Sl_Wait(microblaze_riscv_0_ilmb_bus_WAIT));
  Capstone_With_AXI_Stream_ilmb_v10_0 ilmb_v10
       (.LMB_ABus(microblaze_riscv_0_ilmb_bus_ABUS),
        .LMB_AddrStrobe(microblaze_riscv_0_ilmb_bus_ADDRSTROBE),
        .LMB_BE(microblaze_riscv_0_ilmb_bus_BE),
        .LMB_CE(ILMB_ce),
        .LMB_Clk(LMB_Clk),
        .LMB_ReadDBus(ILMB_readdbus),
        .LMB_ReadStrobe(microblaze_riscv_0_ilmb_bus_READSTROBE),
        .LMB_Ready(ILMB_ready),
        .LMB_UE(ILMB_ue),
        .LMB_Wait(ILMB_wait),
        .LMB_WriteDBus(microblaze_riscv_0_ilmb_bus_WRITEDBUS),
        .LMB_WriteStrobe(microblaze_riscv_0_ilmb_bus_WRITESTROBE),
        .M_ABus(ILMB_abus),
        .M_AddrStrobe(ILMB_addrstrobe),
        .M_BE({1'b0,1'b0,1'b0,1'b0}),
        .M_DBus({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .M_ReadStrobe(ILMB_readstrobe),
        .M_WriteStrobe(1'b0),
        .SYS_Rst(SYS_Rst),
        .Sl_CE(microblaze_riscv_0_ilmb_bus_CE),
        .Sl_DBus(microblaze_riscv_0_ilmb_bus_READDBUS),
        .Sl_Ready(microblaze_riscv_0_ilmb_bus_READY),
        .Sl_UE(microblaze_riscv_0_ilmb_bus_UE),
        .Sl_Wait(microblaze_riscv_0_ilmb_bus_WAIT));
  Capstone_With_AXI_Stream_lmb_bram_0 lmb_bram
       (.addra({microblaze_riscv_0_dlmb_cntlr_ADDR[0],microblaze_riscv_0_dlmb_cntlr_ADDR[1],microblaze_riscv_0_dlmb_cntlr_ADDR[2],microblaze_riscv_0_dlmb_cntlr_ADDR[3],microblaze_riscv_0_dlmb_cntlr_ADDR[4],microblaze_riscv_0_dlmb_cntlr_ADDR[5],microblaze_riscv_0_dlmb_cntlr_ADDR[6],microblaze_riscv_0_dlmb_cntlr_ADDR[7],microblaze_riscv_0_dlmb_cntlr_ADDR[8],microblaze_riscv_0_dlmb_cntlr_ADDR[9],microblaze_riscv_0_dlmb_cntlr_ADDR[10],microblaze_riscv_0_dlmb_cntlr_ADDR[11],microblaze_riscv_0_dlmb_cntlr_ADDR[12],microblaze_riscv_0_dlmb_cntlr_ADDR[13],microblaze_riscv_0_dlmb_cntlr_ADDR[14],microblaze_riscv_0_dlmb_cntlr_ADDR[15],microblaze_riscv_0_dlmb_cntlr_ADDR[16],microblaze_riscv_0_dlmb_cntlr_ADDR[17],microblaze_riscv_0_dlmb_cntlr_ADDR[18],microblaze_riscv_0_dlmb_cntlr_ADDR[19],microblaze_riscv_0_dlmb_cntlr_ADDR[20],microblaze_riscv_0_dlmb_cntlr_ADDR[21],microblaze_riscv_0_dlmb_cntlr_ADDR[22],microblaze_riscv_0_dlmb_cntlr_ADDR[23],microblaze_riscv_0_dlmb_cntlr_ADDR[24],microblaze_riscv_0_dlmb_cntlr_ADDR[25],microblaze_riscv_0_dlmb_cntlr_ADDR[26],microblaze_riscv_0_dlmb_cntlr_ADDR[27],microblaze_riscv_0_dlmb_cntlr_ADDR[28],microblaze_riscv_0_dlmb_cntlr_ADDR[29],microblaze_riscv_0_dlmb_cntlr_ADDR[30],microblaze_riscv_0_dlmb_cntlr_ADDR[31]}),
        .addrb({microblaze_riscv_0_ilmb_cntlr_ADDR[0],microblaze_riscv_0_ilmb_cntlr_ADDR[1],microblaze_riscv_0_ilmb_cntlr_ADDR[2],microblaze_riscv_0_ilmb_cntlr_ADDR[3],microblaze_riscv_0_ilmb_cntlr_ADDR[4],microblaze_riscv_0_ilmb_cntlr_ADDR[5],microblaze_riscv_0_ilmb_cntlr_ADDR[6],microblaze_riscv_0_ilmb_cntlr_ADDR[7],microblaze_riscv_0_ilmb_cntlr_ADDR[8],microblaze_riscv_0_ilmb_cntlr_ADDR[9],microblaze_riscv_0_ilmb_cntlr_ADDR[10],microblaze_riscv_0_ilmb_cntlr_ADDR[11],microblaze_riscv_0_ilmb_cntlr_ADDR[12],microblaze_riscv_0_ilmb_cntlr_ADDR[13],microblaze_riscv_0_ilmb_cntlr_ADDR[14],microblaze_riscv_0_ilmb_cntlr_ADDR[15],microblaze_riscv_0_ilmb_cntlr_ADDR[16],microblaze_riscv_0_ilmb_cntlr_ADDR[17],microblaze_riscv_0_ilmb_cntlr_ADDR[18],microblaze_riscv_0_ilmb_cntlr_ADDR[19],microblaze_riscv_0_ilmb_cntlr_ADDR[20],microblaze_riscv_0_ilmb_cntlr_ADDR[21],microblaze_riscv_0_ilmb_cntlr_ADDR[22],microblaze_riscv_0_ilmb_cntlr_ADDR[23],microblaze_riscv_0_ilmb_cntlr_ADDR[24],microblaze_riscv_0_ilmb_cntlr_ADDR[25],microblaze_riscv_0_ilmb_cntlr_ADDR[26],microblaze_riscv_0_ilmb_cntlr_ADDR[27],microblaze_riscv_0_ilmb_cntlr_ADDR[28],microblaze_riscv_0_ilmb_cntlr_ADDR[29],microblaze_riscv_0_ilmb_cntlr_ADDR[30],microblaze_riscv_0_ilmb_cntlr_ADDR[31]}),
        .clka(microblaze_riscv_0_dlmb_cntlr_CLK),
        .clkb(microblaze_riscv_0_ilmb_cntlr_CLK),
        .dina({microblaze_riscv_0_dlmb_cntlr_DIN[0],microblaze_riscv_0_dlmb_cntlr_DIN[1],microblaze_riscv_0_dlmb_cntlr_DIN[2],microblaze_riscv_0_dlmb_cntlr_DIN[3],microblaze_riscv_0_dlmb_cntlr_DIN[4],microblaze_riscv_0_dlmb_cntlr_DIN[5],microblaze_riscv_0_dlmb_cntlr_DIN[6],microblaze_riscv_0_dlmb_cntlr_DIN[7],microblaze_riscv_0_dlmb_cntlr_DIN[8],microblaze_riscv_0_dlmb_cntlr_DIN[9],microblaze_riscv_0_dlmb_cntlr_DIN[10],microblaze_riscv_0_dlmb_cntlr_DIN[11],microblaze_riscv_0_dlmb_cntlr_DIN[12],microblaze_riscv_0_dlmb_cntlr_DIN[13],microblaze_riscv_0_dlmb_cntlr_DIN[14],microblaze_riscv_0_dlmb_cntlr_DIN[15],microblaze_riscv_0_dlmb_cntlr_DIN[16],microblaze_riscv_0_dlmb_cntlr_DIN[17],microblaze_riscv_0_dlmb_cntlr_DIN[18],microblaze_riscv_0_dlmb_cntlr_DIN[19],microblaze_riscv_0_dlmb_cntlr_DIN[20],microblaze_riscv_0_dlmb_cntlr_DIN[21],microblaze_riscv_0_dlmb_cntlr_DIN[22],microblaze_riscv_0_dlmb_cntlr_DIN[23],microblaze_riscv_0_dlmb_cntlr_DIN[24],microblaze_riscv_0_dlmb_cntlr_DIN[25],microblaze_riscv_0_dlmb_cntlr_DIN[26],microblaze_riscv_0_dlmb_cntlr_DIN[27],microblaze_riscv_0_dlmb_cntlr_DIN[28],microblaze_riscv_0_dlmb_cntlr_DIN[29],microblaze_riscv_0_dlmb_cntlr_DIN[30],microblaze_riscv_0_dlmb_cntlr_DIN[31]}),
        .dinb({microblaze_riscv_0_ilmb_cntlr_DIN[0],microblaze_riscv_0_ilmb_cntlr_DIN[1],microblaze_riscv_0_ilmb_cntlr_DIN[2],microblaze_riscv_0_ilmb_cntlr_DIN[3],microblaze_riscv_0_ilmb_cntlr_DIN[4],microblaze_riscv_0_ilmb_cntlr_DIN[5],microblaze_riscv_0_ilmb_cntlr_DIN[6],microblaze_riscv_0_ilmb_cntlr_DIN[7],microblaze_riscv_0_ilmb_cntlr_DIN[8],microblaze_riscv_0_ilmb_cntlr_DIN[9],microblaze_riscv_0_ilmb_cntlr_DIN[10],microblaze_riscv_0_ilmb_cntlr_DIN[11],microblaze_riscv_0_ilmb_cntlr_DIN[12],microblaze_riscv_0_ilmb_cntlr_DIN[13],microblaze_riscv_0_ilmb_cntlr_DIN[14],microblaze_riscv_0_ilmb_cntlr_DIN[15],microblaze_riscv_0_ilmb_cntlr_DIN[16],microblaze_riscv_0_ilmb_cntlr_DIN[17],microblaze_riscv_0_ilmb_cntlr_DIN[18],microblaze_riscv_0_ilmb_cntlr_DIN[19],microblaze_riscv_0_ilmb_cntlr_DIN[20],microblaze_riscv_0_ilmb_cntlr_DIN[21],microblaze_riscv_0_ilmb_cntlr_DIN[22],microblaze_riscv_0_ilmb_cntlr_DIN[23],microblaze_riscv_0_ilmb_cntlr_DIN[24],microblaze_riscv_0_ilmb_cntlr_DIN[25],microblaze_riscv_0_ilmb_cntlr_DIN[26],microblaze_riscv_0_ilmb_cntlr_DIN[27],microblaze_riscv_0_ilmb_cntlr_DIN[28],microblaze_riscv_0_ilmb_cntlr_DIN[29],microblaze_riscv_0_ilmb_cntlr_DIN[30],microblaze_riscv_0_ilmb_cntlr_DIN[31]}),
        .douta(microblaze_riscv_0_dlmb_cntlr_DOUT),
        .doutb(microblaze_riscv_0_ilmb_cntlr_DOUT),
        .ena(microblaze_riscv_0_dlmb_cntlr_EN),
        .enb(microblaze_riscv_0_ilmb_cntlr_EN),
        .rsta(microblaze_riscv_0_dlmb_cntlr_RST),
        .rstb(microblaze_riscv_0_ilmb_cntlr_RST),
        .wea({microblaze_riscv_0_dlmb_cntlr_WE[0],microblaze_riscv_0_dlmb_cntlr_WE[1],microblaze_riscv_0_dlmb_cntlr_WE[2],microblaze_riscv_0_dlmb_cntlr_WE[3]}),
        .web({microblaze_riscv_0_ilmb_cntlr_WE[0],microblaze_riscv_0_ilmb_cntlr_WE[1],microblaze_riscv_0_ilmb_cntlr_WE[2],microblaze_riscv_0_ilmb_cntlr_WE[3]}));
endmodule
