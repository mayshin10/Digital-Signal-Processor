vlib work
vlib riviera

vlib riviera/xilinx_vip
vlib riviera/xil_defaultlib
vlib riviera/xpm
vlib riviera/axi_infrastructure_v1_1_0
vlib riviera/axi_vip_v1_1_5
vlib riviera/processing_system7_vip_v1_0_7
vlib riviera/lib_cdc_v1_0_2
vlib riviera/proc_sys_reset_v5_0_13
vlib riviera/generic_baseblocks_v2_1_0
vlib riviera/axi_register_slice_v2_1_19
vlib riviera/fifo_generator_v13_2_4
vlib riviera/axi_data_fifo_v2_1_18
vlib riviera/axi_crossbar_v2_1_20
vlib riviera/axi_ahblite_bridge_v3_0_16
vlib riviera/axi_protocol_converter_v2_1_19

vmap xilinx_vip riviera/xilinx_vip
vmap xil_defaultlib riviera/xil_defaultlib
vmap xpm riviera/xpm
vmap axi_infrastructure_v1_1_0 riviera/axi_infrastructure_v1_1_0
vmap axi_vip_v1_1_5 riviera/axi_vip_v1_1_5
vmap processing_system7_vip_v1_0_7 riviera/processing_system7_vip_v1_0_7
vmap lib_cdc_v1_0_2 riviera/lib_cdc_v1_0_2
vmap proc_sys_reset_v5_0_13 riviera/proc_sys_reset_v5_0_13
vmap generic_baseblocks_v2_1_0 riviera/generic_baseblocks_v2_1_0
vmap axi_register_slice_v2_1_19 riviera/axi_register_slice_v2_1_19
vmap fifo_generator_v13_2_4 riviera/fifo_generator_v13_2_4
vmap axi_data_fifo_v2_1_18 riviera/axi_data_fifo_v2_1_18
vmap axi_crossbar_v2_1_20 riviera/axi_crossbar_v2_1_20
vmap axi_ahblite_bridge_v3_0_16 riviera/axi_ahblite_bridge_v3_0_16
vmap axi_protocol_converter_v2_1_19 riviera/axi_protocol_converter_v2_1_19

vlog -work xilinx_vip  -sv2k12 "+incdir+E:/Xilinx/Vivado/2019.1/data/xilinx_vip/include" \
"E:/Xilinx/Vivado/2019.1/data/xilinx_vip/hdl/axi4stream_vip_axi4streampc.sv" \
"E:/Xilinx/Vivado/2019.1/data/xilinx_vip/hdl/axi_vip_axi4pc.sv" \
"E:/Xilinx/Vivado/2019.1/data/xilinx_vip/hdl/xil_common_vip_pkg.sv" \
"E:/Xilinx/Vivado/2019.1/data/xilinx_vip/hdl/axi4stream_vip_pkg.sv" \
"E:/Xilinx/Vivado/2019.1/data/xilinx_vip/hdl/axi_vip_pkg.sv" \
"E:/Xilinx/Vivado/2019.1/data/xilinx_vip/hdl/axi4stream_vip_if.sv" \
"E:/Xilinx/Vivado/2019.1/data/xilinx_vip/hdl/axi_vip_if.sv" \
"E:/Xilinx/Vivado/2019.1/data/xilinx_vip/hdl/clk_vip_if.sv" \
"E:/Xilinx/Vivado/2019.1/data/xilinx_vip/hdl/rst_vip_if.sv" \

vlog -work xil_defaultlib  -sv2k12 "+incdir+../../../../project_final.srcs/sources_1/bd/system/ipshared/ec67/hdl" "+incdir+../../../../project_final.srcs/sources_1/bd/system/ipshared/8c62/hdl" "+incdir+../../../../project_final.srcs/sources_1/bd/system/ip/system_processing_system7_0_0" "+incdir+E:/Xilinx/Vivado/2019.1/data/xilinx_vip/include" \
"E:/Xilinx/Vivado/2019.1/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \
"E:/Xilinx/Vivado/2019.1/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv" \

vcom -work xpm -93 \
"E:/Xilinx/Vivado/2019.1/data/ip/xpm/xpm_VCOMP.vhd" \

vlog -work axi_infrastructure_v1_1_0  -v2k5 "+incdir+../../../../project_final.srcs/sources_1/bd/system/ipshared/ec67/hdl" "+incdir+../../../../project_final.srcs/sources_1/bd/system/ipshared/8c62/hdl" "+incdir+../../../../project_final.srcs/sources_1/bd/system/ip/system_processing_system7_0_0" "+incdir+E:/Xilinx/Vivado/2019.1/data/xilinx_vip/include" \
"../../../../project_final.srcs/sources_1/bd/system/ipshared/ec67/hdl/axi_infrastructure_v1_1_vl_rfs.v" \

vlog -work axi_vip_v1_1_5  -sv2k12 "+incdir+../../../../project_final.srcs/sources_1/bd/system/ipshared/ec67/hdl" "+incdir+../../../../project_final.srcs/sources_1/bd/system/ipshared/8c62/hdl" "+incdir+../../../../project_final.srcs/sources_1/bd/system/ip/system_processing_system7_0_0" "+incdir+E:/Xilinx/Vivado/2019.1/data/xilinx_vip/include" \
"../../../../project_final.srcs/sources_1/bd/system/ipshared/d4a8/hdl/axi_vip_v1_1_vl_rfs.sv" \

vlog -work processing_system7_vip_v1_0_7  -sv2k12 "+incdir+../../../../project_final.srcs/sources_1/bd/system/ipshared/ec67/hdl" "+incdir+../../../../project_final.srcs/sources_1/bd/system/ipshared/8c62/hdl" "+incdir+../../../../project_final.srcs/sources_1/bd/system/ip/system_processing_system7_0_0" "+incdir+E:/Xilinx/Vivado/2019.1/data/xilinx_vip/include" \
"../../../../project_final.srcs/sources_1/bd/system/ipshared/8c62/hdl/processing_system7_vip_v1_0_vl_rfs.sv" \

vlog -work xil_defaultlib  -v2k5 "+incdir+../../../../project_final.srcs/sources_1/bd/system/ipshared/ec67/hdl" "+incdir+../../../../project_final.srcs/sources_1/bd/system/ipshared/8c62/hdl" "+incdir+../../../../project_final.srcs/sources_1/bd/system/ip/system_processing_system7_0_0" "+incdir+E:/Xilinx/Vivado/2019.1/data/xilinx_vip/include" \
"../../../bd/system/ip/system_processing_system7_0_0/sim/system_processing_system7_0_0.v" \

vcom -work lib_cdc_v1_0_2 -93 \
"../../../../project_final.srcs/sources_1/bd/system/ipshared/ef1e/hdl/lib_cdc_v1_0_rfs.vhd" \

vcom -work proc_sys_reset_v5_0_13 -93 \
"../../../../project_final.srcs/sources_1/bd/system/ipshared/8842/hdl/proc_sys_reset_v5_0_vh_rfs.vhd" \

vcom -work xil_defaultlib -93 \
"../../../bd/system/ip/system_proc_sys_reset_0_0/sim/system_proc_sys_reset_0_0.vhd" \

vlog -work generic_baseblocks_v2_1_0  -v2k5 "+incdir+../../../../project_final.srcs/sources_1/bd/system/ipshared/ec67/hdl" "+incdir+../../../../project_final.srcs/sources_1/bd/system/ipshared/8c62/hdl" "+incdir+../../../../project_final.srcs/sources_1/bd/system/ip/system_processing_system7_0_0" "+incdir+E:/Xilinx/Vivado/2019.1/data/xilinx_vip/include" \
"../../../../project_final.srcs/sources_1/bd/system/ipshared/b752/hdl/generic_baseblocks_v2_1_vl_rfs.v" \

vlog -work axi_register_slice_v2_1_19  -v2k5 "+incdir+../../../../project_final.srcs/sources_1/bd/system/ipshared/ec67/hdl" "+incdir+../../../../project_final.srcs/sources_1/bd/system/ipshared/8c62/hdl" "+incdir+../../../../project_final.srcs/sources_1/bd/system/ip/system_processing_system7_0_0" "+incdir+E:/Xilinx/Vivado/2019.1/data/xilinx_vip/include" \
"../../../../project_final.srcs/sources_1/bd/system/ipshared/4d88/hdl/axi_register_slice_v2_1_vl_rfs.v" \

vlog -work fifo_generator_v13_2_4  -v2k5 "+incdir+../../../../project_final.srcs/sources_1/bd/system/ipshared/ec67/hdl" "+incdir+../../../../project_final.srcs/sources_1/bd/system/ipshared/8c62/hdl" "+incdir+../../../../project_final.srcs/sources_1/bd/system/ip/system_processing_system7_0_0" "+incdir+E:/Xilinx/Vivado/2019.1/data/xilinx_vip/include" \
"../../../../project_final.srcs/sources_1/bd/system/ipshared/1f5a/simulation/fifo_generator_vlog_beh.v" \

vcom -work fifo_generator_v13_2_4 -93 \
"../../../../project_final.srcs/sources_1/bd/system/ipshared/1f5a/hdl/fifo_generator_v13_2_rfs.vhd" \

vlog -work fifo_generator_v13_2_4  -v2k5 "+incdir+../../../../project_final.srcs/sources_1/bd/system/ipshared/ec67/hdl" "+incdir+../../../../project_final.srcs/sources_1/bd/system/ipshared/8c62/hdl" "+incdir+../../../../project_final.srcs/sources_1/bd/system/ip/system_processing_system7_0_0" "+incdir+E:/Xilinx/Vivado/2019.1/data/xilinx_vip/include" \
"../../../../project_final.srcs/sources_1/bd/system/ipshared/1f5a/hdl/fifo_generator_v13_2_rfs.v" \

vlog -work axi_data_fifo_v2_1_18  -v2k5 "+incdir+../../../../project_final.srcs/sources_1/bd/system/ipshared/ec67/hdl" "+incdir+../../../../project_final.srcs/sources_1/bd/system/ipshared/8c62/hdl" "+incdir+../../../../project_final.srcs/sources_1/bd/system/ip/system_processing_system7_0_0" "+incdir+E:/Xilinx/Vivado/2019.1/data/xilinx_vip/include" \
"../../../../project_final.srcs/sources_1/bd/system/ipshared/5b9c/hdl/axi_data_fifo_v2_1_vl_rfs.v" \

vlog -work axi_crossbar_v2_1_20  -v2k5 "+incdir+../../../../project_final.srcs/sources_1/bd/system/ipshared/ec67/hdl" "+incdir+../../../../project_final.srcs/sources_1/bd/system/ipshared/8c62/hdl" "+incdir+../../../../project_final.srcs/sources_1/bd/system/ip/system_processing_system7_0_0" "+incdir+E:/Xilinx/Vivado/2019.1/data/xilinx_vip/include" \
"../../../../project_final.srcs/sources_1/bd/system/ipshared/ace7/hdl/axi_crossbar_v2_1_vl_rfs.v" \

vlog -work xil_defaultlib  -v2k5 "+incdir+../../../../project_final.srcs/sources_1/bd/system/ipshared/ec67/hdl" "+incdir+../../../../project_final.srcs/sources_1/bd/system/ipshared/8c62/hdl" "+incdir+../../../../project_final.srcs/sources_1/bd/system/ip/system_processing_system7_0_0" "+incdir+E:/Xilinx/Vivado/2019.1/data/xilinx_vip/include" \
"../../../bd/system/ip/system_xbar_0/sim/system_xbar_0.v" \

vcom -work axi_ahblite_bridge_v3_0_16 -93 \
"../../../../project_final.srcs/sources_1/bd/system/ipshared/c8f4/hdl/axi_ahblite_bridge_v3_0_vh_rfs.vhd" \

vcom -work xil_defaultlib -93 \
"../../../bd/system/ip/system_axi_ahblite_bridge_0_0/sim/system_axi_ahblite_bridge_0_0.vhd" \
"../../../bd/system/ip/system_axi_ahblite_bridge_1_0/sim/system_axi_ahblite_bridge_1_0.vhd" \

vlog -work xil_defaultlib  -v2k5 "+incdir+../../../../project_final.srcs/sources_1/bd/system/ipshared/ec67/hdl" "+incdir+../../../../project_final.srcs/sources_1/bd/system/ipshared/8c62/hdl" "+incdir+../../../../project_final.srcs/sources_1/bd/system/ip/system_processing_system7_0_0" "+incdir+E:/Xilinx/Vivado/2019.1/data/xilinx_vip/include" \
"../../../bd/system/ipshared/cee8/hdl/sevenseg_v1_0_S00_AXI.v" \
"../../../bd/system/ipshared/cee8/hdl/sevenseg_v1_0.v" \
"../../../bd/system/ip/system_sevenseg_0_0/sim/system_sevenseg_0_0.v" \
"../../../bd/system/ipshared/cf50/hdl/cycle_v1_0_S00_AXI.v" \
"../../../bd/system/ipshared/cf50/hdl/cycle_v1_0.v" \
"../../../bd/system/ip/system_cycle_1_0/sim/system_cycle_1_0.v" \

vlog -work axi_protocol_converter_v2_1_19  -v2k5 "+incdir+../../../../project_final.srcs/sources_1/bd/system/ipshared/ec67/hdl" "+incdir+../../../../project_final.srcs/sources_1/bd/system/ipshared/8c62/hdl" "+incdir+../../../../project_final.srcs/sources_1/bd/system/ip/system_processing_system7_0_0" "+incdir+E:/Xilinx/Vivado/2019.1/data/xilinx_vip/include" \
"../../../../project_final.srcs/sources_1/bd/system/ipshared/c83a/hdl/axi_protocol_converter_v2_1_vl_rfs.v" \

vlog -work xil_defaultlib  -v2k5 "+incdir+../../../../project_final.srcs/sources_1/bd/system/ipshared/ec67/hdl" "+incdir+../../../../project_final.srcs/sources_1/bd/system/ipshared/8c62/hdl" "+incdir+../../../../project_final.srcs/sources_1/bd/system/ip/system_processing_system7_0_0" "+incdir+E:/Xilinx/Vivado/2019.1/data/xilinx_vip/include" \
"../../../bd/system/ip/system_auto_pc_2/sim/system_auto_pc_2.v" \
"../../../bd/system/ip/system_auto_pc_0/sim/system_auto_pc_0.v" \
"../../../bd/system/ip/system_auto_pc_1/sim/system_auto_pc_1.v" \
"../../../bd/system/sim/system.v" \

vlog -work xil_defaultlib \
"glbl.v"

