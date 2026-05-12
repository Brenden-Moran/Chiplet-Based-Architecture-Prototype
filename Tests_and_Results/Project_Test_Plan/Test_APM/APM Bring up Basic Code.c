#include "xparameters.h"
#include "xil_printf.h"
#include "xaxipmon.h"
#include "xstatus.h"
#include <stdint.h>

static XAxiPmon AxiPmon;

int main(void)
{
    XAxiPmon_Config *CfgPtr;
    int status;
    volatile uint32_t i;
    uint32_t hi = 0, lo = 0;

    xil_printf("\r\n========================================\r\n");
    xil_printf(" APM Bring-Up Test\r\n");
    xil_printf("========================================\r\n");

    xil_printf("Step 1: Lookup config...\r\n");
    CfgPtr = XAxiPmon_LookupConfig(XPAR_XAXIPMON_0_BASEADDR);
    if (CfgPtr == NULL) {
        xil_printf("ERROR: XAxiPmon_LookupConfig returned NULL\r\n");
        while (1) { }
    }
    xil_printf("Lookup OK\r\n");

    xil_printf("Step 2: Initialize APM...\r\n");
    status = XAxiPmon_CfgInitialize(&AxiPmon, CfgPtr, CfgPtr->BaseAddress);
    if (status != XST_SUCCESS) {
        xil_printf("ERROR: XAxiPmon_CfgInitialize failed, status=%d\r\n", status);
        while (1) { }
    }
    xil_printf("Init OK\r\n");

    xil_printf("Step 3: Reset/disable counters...\r\n");
    XAxiPmon_StopCounters(&AxiPmon);
    XAxiPmon_DisableMetricsCounter(&AxiPmon);
    XAxiPmon_DisableGlobalClkCounter(&AxiPmon);
    xil_printf("Counter reset OK\r\n");

    xil_printf("Step 4: Start global clock counter...\r\n");
    XAxiPmon_EnableGlobalClkCounter(&AxiPmon);
    XAxiPmon_StartCounters(&AxiPmon, 0);
    xil_printf("Counter started\r\n");

    xil_printf("Step 5: Delay loop...\r\n");
    for (i = 0; i < 1000000U; i++) {
        /* intentional delay */
    }

    xil_printf("Step 6: Stop and read counter...\r\n");
    XAxiPmon_StopCounters(&AxiPmon);
    XAxiPmon_DisableGlobalClkCounter(&AxiPmon);
    XAxiPmon_GetGlobalClkCounter(&AxiPmon, &hi, &lo);

    xil_printf("APM global count hi = 0x%08x\r\n", (unsigned int)hi);
    xil_printf("APM global count lo = 0x%08x\r\n", (unsigned int)lo);

    if ((hi == 0U) && (lo == 0U)) {
        xil_printf("WARNING: Counter read back as zero.\r\n");
        xil_printf("Possible causes:\r\n");
        xil_printf(" - core_aclk or s_axi_aclk not running\r\n");
        xil_printf(" - reset stuck active\r\n");
        xil_printf(" - wrong bitstream/platform loaded\r\n");
    } else {
        xil_printf("APM basic bring-up PASSED\r\n");
    }

    while (1) { }
    return 0;
}