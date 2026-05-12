#include "xparameters.h"
#include "xil_printf.h"
#include "xil_io.h"
#include "xil_cache.h"
#include "xaxidma.h"
#include "xaxipmon.h"
#include "xstatus.h"
#include <stdint.h>

#define ACCEL_BASEADDR   XPAR_ACCELERATOR_STREAM_0_BASEADDR

#define DMA_A_BASEADDR   XPAR_AXI_DMA_A_BASEADDR
#define DMA_B_BASEADDR   XPAR_AXI_DMA_B_BASEADDR
#define DMA_C_BASEADDR   XPAR_AXI_DMA_C_BASEADDR

#define DDR_A_BASE       ((UINTPTR)0x80000000U)
#define DDR_B_BASE       ((UINTPTR)0x80001000U)
#define DDR_C_BASE       ((UINTPTR)0x80002000U)

#define REG_CONTROL      0x00
#define REG_N            0x04
#define REG_STATUS       0x08

#define STATUS_DONE_MASK 0x1

#define N_DIGIT          8
#define NUM_CLASSES      10
#define WORD_BYTES       4
#define MAT_WORDS(n)     ((n) * (n))
#define MAT_BYTES(n)     (MAT_WORDS(n) * WORD_BYTES)

#define CPU_FREQ_HZ      XPAR_CPU_CORE_CLOCK_FREQ_HZ
#define APM_FREQ_HZ      100000000U

/* ------------------------------------------------------------
 * AXI-Lite helpers
 * ------------------------------------------------------------ */
static inline void accel_write(uint32_t offset, uint32_t value)
{
    Xil_Out32(ACCEL_BASEADDR + offset, value);
}

static inline uint32_t accel_read(uint32_t offset)
{
    return Xil_In32(ACCEL_BASEADDR + offset);
}

/* ------------------------------------------------------------
 * CPU cycle counter
 * ------------------------------------------------------------ */
static inline uint64_t read_cpu_cycles(void)
{
    uint32_t hi1, lo, hi2;
    do {
        __asm__ volatile ("rdcycleh %0" : "=r"(hi1));
        __asm__ volatile ("rdcycle %0"  : "=r"(lo));
        __asm__ volatile ("rdcycleh %0" : "=r"(hi2));
    } while (hi1 != hi2);

    return (((uint64_t)hi1) << 32) | (uint64_t)lo;
}

static uint32_t cycles_to_us_u32(uint64_t cycles)
{
    return (uint32_t)((cycles * 1000000ULL) / (uint64_t)CPU_FREQ_HZ);
}

static uint32_t apm_cycles_to_us_u32(uint64_t cycles)
{
    return (uint32_t)((cycles * 1000000ULL) / (uint64_t)APM_FREQ_HZ);
}

static uint32_t bytes_per_sec_to_mb_per_sec(uint64_t bytes, uint64_t cycles)
{
    if (cycles == 0ULL) return 0U;
    return (uint32_t)((bytes * (uint64_t)APM_FREQ_HZ) / (cycles * 1000000ULL));
}

static uint32_t bytes_per_sec_to_kb_per_sec(uint64_t bytes, uint64_t cycles)
{
    if (cycles == 0ULL) return 0U;
    return (uint32_t)((bytes * (uint64_t)APM_FREQ_HZ) / (cycles * 1000ULL));
}

/* ------------------------------------------------------------
 * DMA instances
 * ------------------------------------------------------------ */
static XAxiDma DmaA;
static XAxiDma DmaB;
static XAxiDma DmaC;

/* ------------------------------------------------------------
 * APM instance
 * ------------------------------------------------------------ */
static XAxiPmon AxiPmon;

/* ------------------------------------------------------------
 * Manual DMA configs
 * ------------------------------------------------------------ */
static XAxiDma_Config DmaA_Config = {
    0,
    DMA_A_BASEADDR,
    XPAR_AXI_DMA_A_SG_INCLUDE_STSCNTRL_STRM,
    XPAR_AXI_DMA_A_INCLUDE_MM2S,
    XPAR_AXI_DMA_A_INCLUDE_MM2S_DRE,
    XPAR_AXI_DMA_A_MM2S_DATA_WIDTH,
    XPAR_AXI_DMA_A_INCLUDE_S2MM,
    XPAR_AXI_DMA_A_INCLUDE_S2MM_DRE,
    XPAR_AXI_DMA_A_S2MM_DATA_WIDTH,
    0,
    XPAR_AXI_DMA_A_NUM_MM2S_CHANNELS,
    XPAR_AXI_DMA_A_NUM_S2MM_CHANNELS,
    XPAR_AXI_DMA_A_MM2S_BURST_SIZE,
    XPAR_AXI_DMA_A_S2MM_BURST_SIZE,
    XPAR_AXI_DMA_A_MICRO_DMA,
    XPAR_AXI_DMA_A_ADDRWIDTH,
    XPAR_AXI_DMA_A_SG_LENGTH_WIDTH
};

static XAxiDma_Config DmaB_Config = {
    1,
    DMA_B_BASEADDR,
    XPAR_AXI_DMA_B_SG_INCLUDE_STSCNTRL_STRM,
    XPAR_AXI_DMA_B_INCLUDE_MM2S,
    XPAR_AXI_DMA_B_INCLUDE_MM2S_DRE,
    XPAR_AXI_DMA_B_MM2S_DATA_WIDTH,
    XPAR_AXI_DMA_B_INCLUDE_S2MM,
    XPAR_AXI_DMA_B_INCLUDE_S2MM_DRE,
    XPAR_AXI_DMA_B_S2MM_DATA_WIDTH,
    0,
    XPAR_AXI_DMA_B_NUM_MM2S_CHANNELS,
    XPAR_AXI_DMA_B_NUM_S2MM_CHANNELS,
    XPAR_AXI_DMA_B_MM2S_BURST_SIZE,
    XPAR_AXI_DMA_B_S2MM_BURST_SIZE,
    XPAR_AXI_DMA_B_MICRO_DMA,
    XPAR_AXI_DMA_B_ADDRWIDTH,
    XPAR_AXI_DMA_B_SG_LENGTH_WIDTH
};

static XAxiDma_Config DmaC_Config = {
    2,
    DMA_C_BASEADDR,
    XPAR_AXI_DMA_C_SG_INCLUDE_STSCNTRL_STRM,
    XPAR_AXI_DMA_C_INCLUDE_MM2S,
    XPAR_AXI_DMA_C_INCLUDE_MM2S_DRE,
    XPAR_AXI_DMA_C_MM2S_DATA_WIDTH,
    XPAR_AXI_DMA_C_INCLUDE_S2MM,
    XPAR_AXI_DMA_C_INCLUDE_S2MM_DRE,
    XPAR_AXI_DMA_C_S2MM_DATA_WIDTH,
    0,
    XPAR_AXI_DMA_C_NUM_MM2S_CHANNELS,
    XPAR_AXI_DMA_C_NUM_S2MM_CHANNELS,
    XPAR_AXI_DMA_C_MM2S_BURST_SIZE,
    XPAR_AXI_DMA_C_S2MM_BURST_SIZE,
    XPAR_AXI_DMA_C_MICRO_DMA,
    XPAR_AXI_DMA_C_ADDRWIDTH,
    XPAR_AXI_DMA_C_SG_LENGTH_WIDTH
};

/* ------------------------------------------------------------
 * DMA init
 * ------------------------------------------------------------ */
static int dma_init_manual(XAxiDma *InstancePtr, XAxiDma_Config *CfgPtr, const char *name)
{
    if (XAxiDma_CfgInitialize(InstancePtr, CfgPtr) != XST_SUCCESS) {
        xil_printf("ERROR: XAxiDma_CfgInitialize failed for %s\r\n", name);
        return XST_FAILURE;
    }

    if (XAxiDma_HasSg(InstancePtr)) {
        xil_printf("ERROR: %s is in SG mode; expected simple mode.\r\n", name);
        return XST_FAILURE;
    }

    xil_printf("%s initialized (base=0x%08x)\r\n",
               name, (unsigned int)CfgPtr->BaseAddr);
    return XST_SUCCESS;
}

/* ------------------------------------------------------------
 * APM init / AXIS metric helpers
 * ------------------------------------------------------------ */
static int apm_init(void)
{
    XAxiPmon_Config *CfgPtr;

    CfgPtr = XAxiPmon_LookupConfig(XPAR_XAXIPMON_0_BASEADDR);
    if (CfgPtr == NULL) {
        xil_printf("ERROR: XAxiPmon_LookupConfig failed\r\n");
        return XST_FAILURE;
    }

    if (XAxiPmon_CfgInitialize(&AxiPmon, CfgPtr, CfgPtr->BaseAddress) != XST_SUCCESS) {
        xil_printf("ERROR: XAxiPmon_CfgInitialize failed\r\n");
        return XST_FAILURE;
    }

    xil_printf("APM initialized (base=0x%08x)\r\n", (unsigned int)CfgPtr->BaseAddress);
    return XST_SUCCESS;
}

static int apm_start_axis_bytes(void)
{
    int status;

    XAxiPmon_StopCounters(&AxiPmon);
    XAxiPmon_DisableMetricsCounter(&AxiPmon);
    XAxiPmon_DisableGlobalClkCounter(&AxiPmon);

    status = XAxiPmon_SetMetrics(&AxiPmon, 0, XAPM_METRIC_SET_18, XAPM_METRIC_COUNTER_0);
    if (status != XST_SUCCESS) {
        xil_printf("ERROR: XAxiPmon_SetMetrics failed\r\n");
        return XST_FAILURE;
    }

    XAxiPmon_EnableMetricsCounter(&AxiPmon);
    XAxiPmon_EnableGlobalClkCounter(&AxiPmon);
    XAxiPmon_StartCounters(&AxiPmon, 0);

    return XST_SUCCESS;
}

static void apm_stop_axis_bytes(uint32_t *axi_cycles, uint32_t *axis_bytes)
{
    uint32_t hi = 0, lo = 0;

    XAxiPmon_StopCounters(&AxiPmon);
    XAxiPmon_DisableMetricsCounter(&AxiPmon);
    XAxiPmon_DisableGlobalClkCounter(&AxiPmon);

    XAxiPmon_GetGlobalClkCounter(&AxiPmon, &hi, &lo);
    *axis_bytes = XAxiPmon_GetMetricCounter(&AxiPmon, XAPM_METRIC_COUNTER_0);
    *axi_cycles = lo;

    if (hi != 0U) {
        xil_printf("WARNING: APM global counter high word is nonzero: 0x%08x\r\n",
                   (unsigned int)hi);
    }
}

/* ------------------------------------------------------------
 * Helpers
 * ------------------------------------------------------------ */
static void print_matrix_u8(const char *name, const uint8_t *buf, int n)
{
    int r, c;
    xil_printf("%s =\r\n", name);
    for (r = 0; r < n; r++) {
        for (c = 0; c < n; c++) {
            xil_printf("%3d ", (unsigned int)buf[r*n + c]);
        }
        xil_printf("\r\n");
    }
}

static void transpose_u8(uint8_t *dst, const uint8_t *src, int n)
{
    int r, c;
    for (r = 0; r < n; r++) {
        for (c = 0; c < n; c++) {
            dst[c*n + r] = src[r*n + c];
        }
    }
}

static uint32_t trace_result_matrix_hw(volatile uint32_t *buf, int n)
{
    int i;
    uint32_t sum = 0;
    for (i = 0; i < n; i++) {
        sum += buf[i*n + i];
    }
    return sum;
}

static uint32_t trace_result_matrix_sw(const uint32_t *buf, int n)
{
    int i;
    uint32_t sum = 0;
    for (i = 0; i < n; i++) {
        sum += buf[i*n + i];
    }
    return sum;
}

static uint32_t template_energy(const uint8_t *buf, int n)
{
    int i;
    uint32_t sum = 0;
    for (i = 0; i < n*n; i++) {
        sum += (uint32_t)buf[i];
    }
    return sum;
}

static uint32_t normalized_score_x1000(uint32_t raw_trace, uint32_t energy)
{
    if (energy == 0U) return 0U;
    return (raw_trace * 1000U) / energy;
}

static void load_u8_matrix_to_ddr(volatile uint32_t *dst, const uint8_t *src, int n)
{
    int i;
    for (i = 0; i < n*n; i++) {
        dst[i] = (uint32_t)src[i];
    }
}

static void clear_u32_matrix_in_ddr(volatile uint32_t *dst, int n)
{
    int i;
    for (i = 0; i < n*n; i++) {
        dst[i] = 0U;
    }
}

static void sw_matmul_u8_u32(const uint8_t *A, const uint8_t *B, uint32_t *C, int n)
{
    int i, j, k;
    for (i = 0; i < n; i++) {
        for (j = 0; j < n; j++) {
            uint32_t sum = 0U;
            for (k = 0; k < n; k++) {
                sum += (uint32_t)A[i*n + k] * (uint32_t)B[k*n + j];
            }
            C[i*n + j] = sum;
        }
    }
}

/* ------------------------------------------------------------
 * One accelerator run
 * ------------------------------------------------------------ */
static int run_hw_matmul_8x8(const uint8_t *A, const uint8_t *B)
{
    int status;
    volatile uint32_t *A_ddr = (volatile uint32_t *)DDR_A_BASE;
    volatile uint32_t *B_ddr = (volatile uint32_t *)DDR_B_BASE;
    volatile uint32_t *C_ddr = (volatile uint32_t *)DDR_C_BASE;
    uint32_t reg_status;
    uint32_t timeout = 200000000U;
    int bytes = MAT_BYTES(N_DIGIT);

    load_u8_matrix_to_ddr(A_ddr, A, N_DIGIT);
    load_u8_matrix_to_ddr(B_ddr, B, N_DIGIT);
    clear_u32_matrix_in_ddr(C_ddr, N_DIGIT);

    Xil_DCacheFlushRange((UINTPTR)A_ddr, bytes);
    Xil_DCacheFlushRange((UINTPTR)B_ddr, bytes);
    Xil_DCacheFlushRange((UINTPTR)C_ddr, bytes);

    accel_write(REG_N, N_DIGIT);

    status = XAxiDma_SimpleTransfer(&DmaC, (UINTPTR)C_ddr, bytes, XAXIDMA_DEVICE_TO_DMA);
    if (status != XST_SUCCESS) {
        xil_printf("ERROR: DMA C start failed.\r\n");
        return XST_FAILURE;
    }

    status = XAxiDma_SimpleTransfer(&DmaA, (UINTPTR)A_ddr, bytes, XAXIDMA_DMA_TO_DEVICE);
    if (status != XST_SUCCESS) {
        xil_printf("ERROR: DMA A start failed.\r\n");
        return XST_FAILURE;
    }

    status = XAxiDma_SimpleTransfer(&DmaB, (UINTPTR)B_ddr, bytes, XAXIDMA_DMA_TO_DEVICE);
    if (status != XST_SUCCESS) {
        xil_printf("ERROR: DMA B start failed.\r\n");
        return XST_FAILURE;
    }

    accel_write(REG_CONTROL, 0x0);
    accel_write(REG_CONTROL, 0x1);
    accel_write(REG_CONTROL, 0x0);

    while (timeout--) {
        reg_status = accel_read(REG_STATUS);

        if (((reg_status & STATUS_DONE_MASK) != 0U) &&
            (!XAxiDma_Busy(&DmaA, XAXIDMA_DMA_TO_DEVICE)) &&
            (!XAxiDma_Busy(&DmaB, XAXIDMA_DMA_TO_DEVICE)) &&
            (!XAxiDma_Busy(&DmaC, XAXIDMA_DEVICE_TO_DMA))) {
            break;
        }
    }

    if (timeout == 0U) {
        xil_printf("ERROR: Timeout waiting for accelerator.\r\n");
        xil_printf("Final status = 0x%08x\r\n", (unsigned int)accel_read(REG_STATUS));
        return XST_FAILURE;
    }

    Xil_DCacheInvalidateRange((UINTPTR)C_ddr, bytes);
    return XST_SUCCESS;
}

/* ------------------------------------------------------------
 * Input test digit: only 3
 * ------------------------------------------------------------ */
static const uint8_t input_digit_3[64] =  {
        0,6,8,8,6,0,0,0, 6,8,2,2,8,6,0,0, 0,6,8,8,6,0,0,0, 6,8,2,2,8,6,0,0,
        8,2,0,0,2,8,0,0, 6,8,2,2,8,6,0,0, 0,6,8,8,6,0,0,0, 0,0,0,0,0,0,0,0
    };

/* ------------------------------------------------------------
 * Digit templates 0-9
 * ------------------------------------------------------------ */
static const uint8_t digit_templates[NUM_CLASSES][64] = {
    {
        0,6,8,8,8,6,0,0, 6,8,0,0,0,8,6,0, 8,0,0,0,0,0,8,0, 8,0,0,0,0,0,8,0,
        8,0,0,0,0,0,8,0, 6,8,0,0,0,8,6,0, 0,6,8,8,8,6,0,0, 0,0,0,0,0,0,0,0
    },
    {
        0,0,4,8,4,0,0,0, 0,4,8,8,4,0,0,0, 0,0,0,8,4,0,0,0, 0,0,0,8,4,0,0,0,
        0,0,0,8,4,0,0,0, 0,0,0,8,4,0,0,0, 0,4,8,8,8,4,0,0, 0,0,0,0,0,0,0,0
    },
    {
        0,6,8,8,8,6,0,0, 0,0,0,0,0,8,0,0, 0,0,0,2,8,6,0,0, 0,0,2,8,6,0,0,0,
        0,2,8,6,0,0,0,0, 2,8,6,0,0,0,0,0, 8,8,8,8,8,8,0,0, 0,0,0,0,0,0,0,0
    },
    {
        0,8,8,8,8,8,0,0, 0,0,0,0,0,8,0,0, 0,0,0,2,8,8,0,0, 0,2,8,8,8,2,0,0,
        0,0,0,0,0,8,0,0, 0,0,0,0,0,8,0,0, 0,8,8,8,8,8,0,0, 0,0,0,0,0,0,0,0
    },
    {
        0,0,2,6,2,0,0,0, 0,2,6,6,2,0,0,0, 2,6,2,6,2,0,0,0, 6,6,6,8,8,8,0,0,
        0,0,0,6,2,0,0,0, 0,0,0,6,2,0,0,0, 0,0,0,6,2,0,0,0, 0,0,0,0,0,0,0,0
    },
    {
        8,8,8,8,8,8,0,0, 8,0,0,0,0,0,0,0, 8,8,8,8,8,6,0,0, 0,0,0,0,2,8,0,0,
        0,0,0,0,2,8,0,0, 6,8,2,2,8,6,0,0, 0,6,8,8,6,0,0,0, 0,0,0,0,0,0,0,0
    },
    {
        0,6,8,8,6,0,0,0, 2,8,0,0,0,0,0,0, 6,8,8,8,6,0,0,0, 8,2,0,0,2,8,0,0,
        8,2,0,0,2,8,0,0, 6,8,2,2,8,6,0,0, 0,6,8,8,6,0,0,0, 0,0,0,0,0,0,0,0
    },
    {
        8,8,8,8,8,8,0,0, 0,0,0,0,2,8,0,0, 0,0,0,2,8,0,0,0, 0,0,2,8,0,0,0,0,
        0,2,8,0,0,0,0,0, 2,8,0,0,0,0,0,0, 8,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0
    },
    {
        0,6,8,8,6,0,0,0, 6,8,2,2,8,6,0,0, 0,6,8,8,6,0,0,0, 6,8,2,2,8,6,0,0,
        8,2,0,0,2,8,0,0, 6,8,2,2,8,6,0,0, 0,6,8,8,6,0,0,0, 0,0,0,0,0,0,0,0
    },
    {
        0,6,8,8,6,0,0,0, 6,8,2,2,8,6,0,0, 8,2,0,0,2,8,0,0, 0,6,8,8,8,8,0,0,
        0,0,0,0,2,8,0,0, 0,0,0,2,8,6,0,0, 0,6,8,8,6,0,0,0, 0,0,0,0,0,0,0,0
    }
};

static int run_hw_test(const char *label, const uint8_t *input_img)
{
    int d;
    int best_digit = -1;
    uint32_t best_norm = 0;
    uint32_t raw_trace[NUM_CLASSES];
    uint32_t energy[NUM_CLASSES];
    uint32_t norm_score[NUM_CLASSES];
    uint8_t transposed_template[64];

    uint64_t start_cycles, end_cycles, hw_cycles;
    uint32_t hw_latency_us;

    uint32_t apm_axi_cycles;
    uint32_t apm_axis_bytes;
    uint32_t apm_axi_latency_us;
    uint32_t apm_bw_mb_s;
    uint32_t apm_bw_kb_s;

    xil_printf("\r\n========================================\r\n");
    xil_printf("Hardware test input: %s\r\n", label);
    xil_printf("========================================\r\n");
    print_matrix_u8("Input", input_img, N_DIGIT);

    if (apm_start_axis_bytes() != XST_SUCCESS) {
        return XST_FAILURE;
    }

    start_cycles = read_cpu_cycles();

    for (d = 0; d < NUM_CLASSES; d++) {
        volatile uint32_t *C_ddr = (volatile uint32_t *)DDR_C_BASE;
        int status;

        transpose_u8(transposed_template, digit_templates[d], N_DIGIT);

        status = run_hw_matmul_8x8(input_img, transposed_template);
        if (status != XST_SUCCESS) {
            xil_printf("ERROR: accelerator run failed for class %d\r\n", d);
            return XST_FAILURE;
        }

        raw_trace[d]  = trace_result_matrix_hw(C_ddr, N_DIGIT);
        energy[d]     = template_energy(digit_templates[d], N_DIGIT);
        norm_score[d] = normalized_score_x1000(raw_trace[d], energy[d]);

        if ((best_digit < 0) || (norm_score[d] > best_norm)) {
            best_norm = norm_score[d];
            best_digit = d;
        }
    }

    end_cycles = read_cpu_cycles();
    apm_stop_axis_bytes(&apm_axi_cycles, &apm_axis_bytes);

    hw_cycles = end_cycles - start_cycles;
    hw_latency_us = cycles_to_us_u32(hw_cycles);

    apm_axi_latency_us = apm_cycles_to_us_u32((uint64_t)apm_axi_cycles);
    apm_bw_mb_s = bytes_per_sec_to_mb_per_sec((uint64_t)apm_axis_bytes,
                                              (uint64_t)apm_axi_cycles);
    apm_bw_kb_s = bytes_per_sec_to_kb_per_sec((uint64_t)apm_axis_bytes,
                                              (uint64_t)apm_axi_cycles);

    xil_printf("\r\nHardware predicted digit = %d\r\n", best_digit);
    xil_printf("Hardware best normalized score x1000 = %u\r\n", (unsigned int)best_norm);

    xil_printf("CPU cycles         = %u\r\n", (unsigned int)hw_cycles);
    xil_printf("CPU latency        = %u us\r\n", (unsigned int)hw_latency_us);

    xil_printf("APM AXIS cycles    = %u\r\n", (unsigned int)apm_axi_cycles);
    xil_printf("APM AXIS latency   = %u us\r\n", (unsigned int)apm_axi_latency_us);
    xil_printf("APM AXIS bytes     = %u\r\n", (unsigned int)apm_axis_bytes);
    xil_printf("APM AXIS BW        = %u MB/s\r\n", (unsigned int)apm_bw_mb_s);
    xil_printf("APM AXIS BW        = %u KB/s\r\n", (unsigned int)apm_bw_kb_s);

    return XST_SUCCESS;
}

static int run_sw_test(const char *label, const uint8_t *input_img)
{
    int d;
    int best_digit = -1;
    uint32_t best_norm = 0;
    uint32_t raw_trace[NUM_CLASSES];
    uint32_t energy[NUM_CLASSES];
    uint32_t norm_score[NUM_CLASSES];
    uint8_t transposed_template[64];
    uint32_t sw_result[64];

    uint64_t start_cycles, end_cycles, sw_cycles;
    uint32_t sw_latency_us;

    xil_printf("\r\n========================================\r\n");
    xil_printf("Software test input: %s\r\n", label);
    xil_printf("========================================\r\n");

    start_cycles = read_cpu_cycles();

    for (d = 0; d < NUM_CLASSES; d++) {
        transpose_u8(transposed_template, digit_templates[d], N_DIGIT);
        sw_matmul_u8_u32(input_img, transposed_template, sw_result, N_DIGIT);

        raw_trace[d]  = trace_result_matrix_sw(sw_result, N_DIGIT);
        energy[d]     = template_energy(digit_templates[d], N_DIGIT);
        norm_score[d] = normalized_score_x1000(raw_trace[d], energy[d]);

        if ((best_digit < 0) || (norm_score[d] > best_norm)) {
            best_norm = norm_score[d];
            best_digit = d;
        }
    }

    end_cycles = read_cpu_cycles();

    sw_cycles = end_cycles - start_cycles;
    sw_latency_us = cycles_to_us_u32(sw_cycles);

    xil_printf("\r\nSoftware predicted digit = %d\r\n", best_digit);
    xil_printf("Software best normalized score x1000 = %u\r\n", (unsigned int)best_norm);
    xil_printf("Software CPU cycles     = %u\r\n", (unsigned int)sw_cycles);
    xil_printf("Software latency        = %u us\r\n", (unsigned int)sw_latency_us);

    return XST_SUCCESS;
}

int main(void)
{
    int status;

    xil_printf("\r\n========================================\r\n");
    xil_printf(" HW/SW Comparison + APM\r\n");
    xil_printf(" One input only: digit 3\r\n");
    xil_printf("========================================\r\n");

    status = dma_init_manual(&DmaA, &DmaA_Config, "DMA_A");
    if (status != XST_SUCCESS) return XST_FAILURE;

    status = dma_init_manual(&DmaB, &DmaB_Config, "DMA_B");
    if (status != XST_SUCCESS) return XST_FAILURE;

    status = dma_init_manual(&DmaC, &DmaC_Config, "DMA_C");
    if (status != XST_SUCCESS) return XST_FAILURE;

    status = apm_init();
    if (status != XST_SUCCESS) return XST_FAILURE;

    status = run_hw_test("digit 3", input_digit_3);
    if (status != XST_SUCCESS) return XST_FAILURE;

    status = run_sw_test("digit 3", input_digit_3);
    if (status != XST_SUCCESS) return XST_FAILURE;

    xil_printf("\r\nHW/SW comparison completed.\r\n");

    while (1) { }
    return 0;
}