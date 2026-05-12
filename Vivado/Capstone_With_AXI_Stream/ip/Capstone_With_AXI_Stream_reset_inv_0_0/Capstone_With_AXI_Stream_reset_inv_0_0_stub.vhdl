-- Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
-- Copyright 2022-2025 Advanced Micro Devices, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2025.1 (win64) Build 6140274 Thu May 22 00:12:29 MDT 2025
-- Date        : Tue Mar  3 23:41:31 2026
-- Host        : Brenden-Laptop running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode synth_stub -rename_top Capstone_With_AXI_Stream_reset_inv_0_0 -prefix
--               Capstone_With_AXI_Stream_reset_inv_0_0_ Mbv_W_Acc_reset_inv_0_1_stub.vhdl
-- Design      : Mbv_W_Acc_reset_inv_0_1
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7a100tcsg324-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Capstone_With_AXI_Stream_reset_inv_0_0 is
  Port ( 
    Op1 : in STD_LOGIC_VECTOR ( 0 to 0 );
    Res : out STD_LOGIC_VECTOR ( 0 to 0 )
  );

  attribute CHECK_LICENSE_TYPE : string;
  attribute CHECK_LICENSE_TYPE of Capstone_With_AXI_Stream_reset_inv_0_0 : entity is "Mbv_W_Acc_reset_inv_0_1,util_vector_logic_v2_0_5_util_vector_logic,{}";
  attribute CORE_GENERATION_INFO : string;
  attribute CORE_GENERATION_INFO of Capstone_With_AXI_Stream_reset_inv_0_0 : entity is "Mbv_W_Acc_reset_inv_0_1,util_vector_logic_v2_0_5_util_vector_logic,{x_ipProduct=Vivado 2025.1,x_ipVendor=xilinx.com,x_ipLibrary=ip,x_ipName=util_vector_logic,x_ipVersion=2.0,x_ipCoreRevision=5,x_ipLanguage=VERILOG,x_ipSimLanguage=MIXED,C_OPERATION=not,C_SIZE=1}";
  attribute DowngradeIPIdentifiedWarnings : string;
  attribute DowngradeIPIdentifiedWarnings of Capstone_With_AXI_Stream_reset_inv_0_0 : entity is "yes";
end Capstone_With_AXI_Stream_reset_inv_0_0;

architecture stub of Capstone_With_AXI_Stream_reset_inv_0_0 is
  attribute syn_black_box : boolean;
  attribute black_box_pad_pin : string;
  attribute syn_black_box of stub : architecture is true;
  attribute black_box_pad_pin of stub : architecture is "Op1[0:0],Res[0:0]";
  attribute X_CORE_INFO : string;
  attribute X_CORE_INFO of stub : architecture is "util_vector_logic_v2_0_5_util_vector_logic,Vivado 2025.1";
begin
end;
