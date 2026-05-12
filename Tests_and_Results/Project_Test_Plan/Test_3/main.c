#include "xparameters.h"
#include "xil_printf.h"
#include "xil_io.h"
#include "xil_cache.h"
#include "xaxidma.h"
#include "xstatus.h"
#include <stdint.h>

/* ============================================================
 * Base addresses from xparameters.h
 * ============================================================ */
#define ACCEL_BASEADDR   XPAR_ACCELERATOR_STREAM_0_BASEADDR

#define DMA_A_BASEADDR   XPAR_AXI_DMA_A_BASEADDR
#define DMA_B_BASEADDR   XPAR_AXI_DMA_B_BASEADDR
#define DMA_C_BASEADDR   XPAR_AXI_DMA_C_BASEADDR

/* DDR test buffers */
#define DDR_A_BASE       ((UINTPTR)0x80000000U)
#define DDR_B_BASE       ((UINTPTR)0x80001000U)
#define DDR_C_BASE       ((UINTPTR)0x80002000U)

/* ============================================================
 * Accelerator register map
 * ============================================================ */
#define REG_CONTROL      0x00
#define REG_N            0x04
#define REG_STATUS       0x08

#define STATUS_DONE_MASK 0x1

#define N_TEST           3
#define WORD_BYTES       4
#define MAT_WORDS(n)     ((n) * (n))
#define MAT_BYTES(n)     (MAT_WORDS(n) * WORD_BYTES)

/* ============================================================
 * MMIO helpers
 * ============================================================ */
static inline void accel_write(uint32_t offset, uint32_t value)
{
    Xil_Out32(ACCEL_BASEADDR + offset, value);
}

static inline uint32_t accel_read(uint32_t offset)
{
    return Xil_In32(ACCEL_BASEADDR + offset);
}

/* ============================================================
 * DMA instances
 * ============================================================ */
static XAxiDma DmaA;
static XAxiDma DmaB;
static XAxiDma DmaC;

/* ============================================================
 * Manual DMA config
 * ============================================================ */
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

static int dma_init_manual(XAxiDma *InstancePtr, XAxiDma_Config *CfgPtr, const char *name)
{
    if (XAxiDma_CfgInitialize(InstancePtr, CfgPtr) != XST_SUCCESS) {
        xil_printf("ERROR: XAxiDma_CfgInitialize failed for %s\r\n", name);
        return XST_FAILURE;
    }

    if (XAxiDma_HasSg(InstancePtr)) {
        xil_printf("ERROR: %s is in SG mode; this test expects simple mode.\r\n", name);
        return XST_FAILURE;
    }

    xil_printf("%s initialized (base=0x%08x)\r\n",
               name, (unsigned int)CfgPtr->BaseAddr);
    return XST_SUCCESS;
}

/* ============================================================
 * Helpers
 * ============================================================ */
static void print_matrix_u32(const char *name, volatile uint32_t *buf, int n)
{
    int r, c;
    xil_printf("%s =\r\n", name);
    for (r = 0; r < n; r++) {
        for (c = 0; c < n; c++) {
            xil_printf("%8d ", (unsigned int)buf[r*n + c]);
        }
        xil_printf("\r\n");
    }
}

static void print_matrix_u32_sw(const char *name, const uint32_t *buf, int n)
{
    int r, c;
    xil_printf("%s =\r\n", name);
    for (r = 0; r < n; r++) {
        for (c = 0; c < n; c++) {
            xil_printf("%8d ", (unsigned int)buf[r*n + c]);
        }
        xil_printf("\r\n");
    }
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

static void matmul_ref_u8_to_u32(const uint8_t *A, const uint8_t *B, uint32_t *C, int n)
{
    int i, j, k;
    for (i = 0; i < n; i++) {
        for (j = 0; j < n; j++) {
            uint32_t sum = 0;
            for (k = 0; k < n; k++) {
                sum += (uint32_t)A[i*n + k] * (uint32_t)B[k*n + j];
            }
            C[i*n + j] = sum;
        }
    }
}

static int compare_result(const volatile uint32_t *hw, const uint32_t *sw, int n)
{
    int i;
    for (i = 0; i < n*n; i++) {
        if (hw[i] != sw[i]) {
            xil_printf("Mismatch at index %d: hw=%d sw=%d\r\n",
                       i, (unsigned int)hw[i], (unsigned int)sw[i]);
            return XST_FAILURE;
        }
    }
    return XST_SUCCESS;
}

static int accel_comm_test(void)
{
    uint32_t n_read, status_read;

    xil_printf("\r\n--- AXI-Lite communication test ---\r\n");

    accel_write(REG_N, N_TEST);
    n_read = accel_read(REG_N);
    status_read = accel_read(REG_STATUS);

    xil_printf("REG_N      = %d\r\n", (unsigned int)n_read);
    xil_printf("REG_STATUS = 0x%08x\r\n", (unsigned int)status_read);

    if (n_read != N_TEST) {
        xil_printf("ERROR: REG_N readback mismatch.\r\n");
        return XST_FAILURE;
    }

    xil_printf("AXI-Lite communication OK.\r\n");
    return XST_SUCCESS;
}

static int run_hw_matmul_3x3(const uint8_t *A, const uint8_t *B, uint32_t *expected)
{
    int status;
    volatile uint32_t *A_ddr = (volatile uint32_t *)DDR_A_BASE;
    volatile uint32_t *B_ddr = (volatile uint32_t *)DDR_B_BASE;
    volatile uint32_t *C_ddr = (volatile uint32_t *)DDR_C_BASE;
    uint32_t reg_status;
    uint32_t timeout = 100000000U;
    int bytes = MAT_BYTES(N_TEST);

    load_u8_matrix_to_ddr(A_ddr, A, N_TEST);
    load_u8_matrix_to_ddr(B_ddr, B, N_TEST);
    clear_u32_matrix_in_ddr(C_ddr, N_TEST);

    Xil_DCacheFlushRange((UINTPTR)A_ddr, bytes);
    Xil_DCacheFlushRange((UINTPTR)B_ddr, bytes);
    Xil_DCacheFlushRange((UINTPTR)C_ddr, bytes);

    accel_write(REG_N, N_TEST);

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
        xil_printf("ERROR: Timeout waiting for completion.\r\n");
        xil_printf("Final status = 0x%08x\r\n", (unsigned int)accel_read(REG_STATUS));
        return XST_FAILURE;
    }

    xil_printf("Final status = 0x%08x\r\n", (unsigned int)accel_read(REG_STATUS));

    Xil_DCacheInvalidateRange((UINTPTR)C_ddr, bytes);

    print_matrix_u32("HW C", C_ddr, N_TEST);

    if (compare_result(C_ddr, expected, N_TEST) != XST_SUCCESS) {
        xil_printf("ERROR: Hardware result mismatch.\r\n");
        return XST_FAILURE;
    }

    xil_printf("PASS: Hardware result matches software reference.\r\n");
    return XST_SUCCESS;
}

static int run_test_case(const char *name, const uint8_t *A, const uint8_t *B)
{
    uint32_t expected[9];
    int status;

    xil_printf("\r\n========================================\r\n");
    xil_printf("%s\r\n", name);
    xil_printf("========================================\r\n");

    matmul_ref_u8_to_u32(A, B, expected, N_TEST);
    print_matrix_u32_sw("SW Expected C", expected, N_TEST);

    status = run_hw_matmul_3x3(A, B, expected);
    return status;
}

int main(void)
{
    int status;

    /* Test 1: check whether first term is double-counted */
    const uint8_t A_first_term[9] = {
        1,0,0,
        0,0,0,
        0,0,0
    };

    const uint8_t B_first_term[9] = {
        11,12,13,
        21,22,23,
        31,32,33
    };

    /* Test 2: second back-to-back multiply */
    const uint8_t A_complex[9] = {
        3,1,4,
        1,5,9,
        2,6,5
    };

    const uint8_t B_complex[9] = {
        8,9,7,
        9,3,2,
        3,8,4
    };

    xil_printf("\r\n========================================\r\n");
    xil_printf(" AXI-Stream Accelerator Repeated-Run Test\r\n");
    xil_printf("========================================\r\n");

    status = dma_init_manual(&DmaA, &DmaA_Config, "DMA_A");
    if (status != XST_SUCCESS) return XST_FAILURE;

    status = dma_init_manual(&DmaB, &DmaB_Config, "DMA_B");
    if (status != XST_SUCCESS) return XST_FAILURE;

    status = dma_init_manual(&DmaC, &DmaC_Config, "DMA_C");
    if (status != XST_SUCCESS) return XST_FAILURE;

    status = accel_comm_test();
    if (status != XST_SUCCESS) return XST_FAILURE;

    status = run_test_case("Test 1: First-term double-count check", A_first_term, B_first_term);
    if (status != XST_SUCCESS) {
        xil_printf("Test 1 failed, continuing to Test 2 for debug.\r\n");
    }

    status = run_test_case("Test 2: Second multiply after first", A_complex, B_complex);
    if (status != XST_SUCCESS) {
        xil_printf("Test 2 failed.\r\n");
    }

    xil_printf("\r\nBoth back-to-back tests completed.\r\n");
    while (1) { }

    return 0;
}