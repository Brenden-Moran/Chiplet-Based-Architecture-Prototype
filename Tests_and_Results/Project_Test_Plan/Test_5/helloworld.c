/******************************************************************************
* Copyright (C) 2023 Advanced Micro Devices, Inc. All Rights Reserved.
* SPDX-License-Identifier: MIT
******************************************************************************/
/*
 * helloworld.c: simple test application
 *
 * This application configures UART 16550 to baud rate 9600.
 * PS7 UART (Zynq) is not initialized by this application, since
 * bootrom/bsp configures it to baud rate 115200
 *
 * ------------------------------------------------
 * | UART TYPE   BAUD RATE                        |
 * ------------------------------------------------
 *   uartns550   9600
 *   uartlite    Configurable only in HW design
 *   ps7_uart    115200 (configured by bootrom/bsp)
 */

#include <stdio.h>
#include <stdint.h>
#include "platform.h"
#include "xil_cache.h"
#include "xil_printf.h"

typedef struct m3x3 {
    int a;
    int b;
    int c;

    int d;
    int e;
    int f;

    int g;
    int h;
    int i;
} matrix3x3;

volatile int *stall;
volatile int *data1Mutex;
volatile int *data2Mutex;
volatile matrix3x3 *data1;
volatile matrix3x3 *data2;

uint32_t coreID() {
    uint32_t id;
    __asm__ volatile ("csrr %0, mhartid" : "=r" (id));
    return id;
}

void initPtr() {
    stall = (int*)0x200000;
    data1Mutex = (int*)(stall+sizeof(int));
    data2Mutex = (int*)(data1Mutex+sizeof(int));
    data1 = (matrix3x3*)(data2Mutex+sizeof(int));
    data2 = (matrix3x3*)(data1+sizeof(matrix3x3));
}

int main()
{   
    matrix3x3 m1;

    Xil_DCacheEnable();
    initPtr();

    do {
        Xil_DCacheInvalidateRange((UINTPTR)data1Mutex, sizeof(int)); // force read from ram
    } while  (*data1Mutex!=1); // data1 spinlock
    
    Xil_DCacheInvalidateRange((UINTPTR)data1, sizeof(matrix3x3));
    m1.a = data1->a;
    m1.b = data1->b;
    m1.c = data1->c;

    m1.d = data1->d;
    m1.e = data1->e;
    m1.f = data1->f;

    m1.g = data1->g;
    m1.h = data1->h;
    m1.i = data1->i;
    do {
        Xil_DCacheInvalidateRange((UINTPTR)data2Mutex, sizeof(int));
    } while (*data2Mutex!=1);  // data2 spinlock

    Xil_DCacheInvalidateRange((UINTPTR)data2, sizeof(matrix3x3));
    data1->a = m1.a*data2->a + m1.b*data2->d + m1.c*data2->g;
    data1->b = m1.a*data2->b + m1.b*data2->e + m1.c*data2->h;
    data1->c = m1.a*data2->c + m1.b*data2->f + m1.c*data2->i;

    data1->d = m1.d*data2->a + m1.e*data2->d + m1.f*data2->g;
    data1->e = m1.d*data2->b + m1.e*data2->e + m1.f*data2->h;
    data1->f = m1.d*data2->c + m1.e*data2->f + m1.f*data2->i;

    data1->g = m1.g*data2->a + m1.h*data2->d + m1.i*data2->g;
    data1->h = m1.g*data2->b + m1.h*data2->e + m1.i*data2->h;
    data1->i = m1.g*data2->c + m1.h*data2->f + m1.i*data2->i;

    Xil_DCacheFlushRange((UINTPTR)data1, sizeof(matrix3x3)); // force write to ram
    *stall=1;
    Xil_DCacheFlushRange((UINTPTR)stall, sizeof(int));

    return 0;
}