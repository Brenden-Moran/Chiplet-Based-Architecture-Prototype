#include "xparameters.h"
#include "xil_printf.h"
#include "xstatus.h"
#include <stdint.h>

#define N_DIGIT          8
#define NUM_CLASSES      10
#define CPU_FREQ_HZ      XPAR_CPU_CORE_CLOCK_FREQ_HZ

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

static void sw_full_matmul_u32(const uint8_t *A, const uint8_t *B, uint32_t *C, int n)
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

static uint32_t trace_result_matrix_u32(const uint32_t *buf, int n)
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

/* ------------------------------------------------------------
 * Test inputs: only 3 and 6
 * ------------------------------------------------------------ */
static const uint8_t input_digit_3[64] = {
     0, 8, 8, 8, 8, 8, 0, 0,
     0, 0, 0, 0, 0, 8, 0, 0,
     0, 0, 0, 2, 8, 8, 0, 0,
     0, 2, 8, 8, 8, 2, 0, 0,
     0, 0, 0, 0, 0, 8, 0, 0,
     0, 0, 0, 0, 0, 8, 0, 0,
     0, 8, 8, 8, 8, 8, 0, 0,
     0, 0, 0, 0, 0, 0, 0, 0
};

static const uint8_t input_digit_6[64] = {
     0, 6, 8, 8, 6, 0, 0, 0,
     2, 8, 0, 0, 0, 0, 0, 0,
     6, 8, 8, 8, 6, 0, 0, 0,
     8, 2, 0, 0, 2, 8, 0, 0,
     8, 2, 0, 0, 2, 8, 0, 0,
     6, 8, 2, 2, 8, 6, 0, 0,
     0, 6, 8, 8, 6, 0, 0, 0,
     0, 0, 0, 0, 0, 0, 0, 0
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

static int run_sw_test(const char *label, const uint8_t *input_img)
{
    int d;
    int best_digit = -1;
    uint32_t best_norm = 0;
    uint32_t raw_trace[NUM_CLASSES];
    uint32_t energy[NUM_CLASSES];
    uint32_t norm_score[NUM_CLASSES];
    uint8_t transposed_template[64];
    uint32_t result[64];
    uint64_t start_cycles, end_cycles, sw_cycles;
    uint32_t sw_latency_us;

    xil_printf("\r\n========================================\r\n");
    xil_printf("Software test input: %s\r\n", label);
    xil_printf("========================================\r\n");
    print_matrix_u8("Input", input_img, N_DIGIT);

    start_cycles = read_cpu_cycles();

    for (d = 0; d < NUM_CLASSES; d++) {
        transpose_u8(transposed_template, digit_templates[d], N_DIGIT);
        sw_full_matmul_u32(input_img, transposed_template, result, N_DIGIT);

        raw_trace[d]  = trace_result_matrix_u32(result, N_DIGIT);
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
    xil_printf("Software cycles = %u\r\n", (unsigned int)sw_cycles);
    xil_printf("Software latency = %u us\r\n", (unsigned int)sw_latency_us);

    return XST_SUCCESS;
}

int main(void)
{
    int status;

    xil_printf("\r\n========================================\r\n");
    xil_printf(" Software-Only Latency Test\r\n");
    xil_printf(" Tests only: digit 3 and digit 6\r\n");
    xil_printf("========================================\r\n");

    status = run_sw_test("digit 3", input_digit_3);
    if (status != XST_SUCCESS) return XST_FAILURE;

    status = run_sw_test("digit 6", input_digit_6);
    if (status != XST_SUCCESS) return XST_FAILURE;

    xil_printf("\r\nSoftware-only tests completed.\r\n");
    while (1) { }
    return 0;
}