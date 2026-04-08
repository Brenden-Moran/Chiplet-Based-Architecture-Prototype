set(mig_7series_0_memory_0 "0x80000000;0x8000000")
set(microblaze_riscv_0_local_memory_dlmb_bram_if_cntlr_memory_0 "0x0;0x4000")
set(DDR mig_7series_0_memory_0)
set(CODE mig_7series_0_memory_0)
set(DATA mig_7series_0_memory_0)
set(TOTAL_MEM_CONTROLLERS "mig_7series_0_memory_0;microblaze_riscv_0_local_memory_dlmb_bram_if_cntlr_memory_0")
set(MEMORY_SECTION "MEMORY
{
	mig_7series_0_memory_0 : ORIGIN = 0x80000000, LENGTH = 0x8000000
	microblaze_riscv_0_local_memory_dlmb_bram_if_cntlr_memory_0 : ORIGIN = 0x0, LENGTH = 0x4000
}")
set(STACK_SIZE 0x400)
set(HEAP_SIZE 0x800)
