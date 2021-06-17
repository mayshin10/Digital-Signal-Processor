// Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2019.1 (win64) Build 2552052 Fri May 24 14:49:42 MDT 2019
// Date        : Fri Jun 11 00:04:34 2021
// Host        : DESKTOP-5K5FCUF running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub -rename_top system_axi_ahblite_bridge_1_0 -prefix
//               system_axi_ahblite_bridge_1_0_ system_axi_ahblite_bridge_0_0_stub.v
// Design      : system_axi_ahblite_bridge_0_0
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7z020clg484-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "axi_ahblite_bridge,Vivado 2019.1" *)
module system_axi_ahblite_bridge_1_0(s_axi_aclk, s_axi_aresetn, s_axi_awid, 
  s_axi_awlen, s_axi_awsize, s_axi_awburst, s_axi_awcache, s_axi_awaddr, s_axi_awprot, 
  s_axi_awvalid, s_axi_awready, s_axi_awlock, s_axi_wdata, s_axi_wstrb, s_axi_wlast, 
  s_axi_wvalid, s_axi_wready, s_axi_bid, s_axi_bresp, s_axi_bvalid, s_axi_bready, s_axi_arid, 
  s_axi_araddr, s_axi_arprot, s_axi_arcache, s_axi_arvalid, s_axi_arlen, s_axi_arsize, 
  s_axi_arburst, s_axi_arlock, s_axi_arready, s_axi_rid, s_axi_rdata, s_axi_rresp, 
  s_axi_rvalid, s_axi_rlast, s_axi_rready, m_ahb_haddr, m_ahb_hwrite, m_ahb_hsize, 
  m_ahb_hburst, m_ahb_hprot, m_ahb_htrans, m_ahb_hmastlock, m_ahb_hwdata, m_ahb_hready, 
  m_ahb_hrdata, m_ahb_hresp)
/* synthesis syn_black_box black_box_pad_pin="s_axi_aclk,s_axi_aresetn,s_axi_awid[11:0],s_axi_awlen[7:0],s_axi_awsize[2:0],s_axi_awburst[1:0],s_axi_awcache[3:0],s_axi_awaddr[31:0],s_axi_awprot[2:0],s_axi_awvalid,s_axi_awready,s_axi_awlock,s_axi_wdata[31:0],s_axi_wstrb[3:0],s_axi_wlast,s_axi_wvalid,s_axi_wready,s_axi_bid[11:0],s_axi_bresp[1:0],s_axi_bvalid,s_axi_bready,s_axi_arid[11:0],s_axi_araddr[31:0],s_axi_arprot[2:0],s_axi_arcache[3:0],s_axi_arvalid,s_axi_arlen[7:0],s_axi_arsize[2:0],s_axi_arburst[1:0],s_axi_arlock,s_axi_arready,s_axi_rid[11:0],s_axi_rdata[31:0],s_axi_rresp[1:0],s_axi_rvalid,s_axi_rlast,s_axi_rready,m_ahb_haddr[31:0],m_ahb_hwrite,m_ahb_hsize[2:0],m_ahb_hburst[2:0],m_ahb_hprot[3:0],m_ahb_htrans[1:0],m_ahb_hmastlock,m_ahb_hwdata[31:0],m_ahb_hready,m_ahb_hrdata[31:0],m_ahb_hresp" */;
  input s_axi_aclk;
  input s_axi_aresetn;
  input [11:0]s_axi_awid;
  input [7:0]s_axi_awlen;
  input [2:0]s_axi_awsize;
  input [1:0]s_axi_awburst;
  input [3:0]s_axi_awcache;
  input [31:0]s_axi_awaddr;
  input [2:0]s_axi_awprot;
  input s_axi_awvalid;
  output s_axi_awready;
  input s_axi_awlock;
  input [31:0]s_axi_wdata;
  input [3:0]s_axi_wstrb;
  input s_axi_wlast;
  input s_axi_wvalid;
  output s_axi_wready;
  output [11:0]s_axi_bid;
  output [1:0]s_axi_bresp;
  output s_axi_bvalid;
  input s_axi_bready;
  input [11:0]s_axi_arid;
  input [31:0]s_axi_araddr;
  input [2:0]s_axi_arprot;
  input [3:0]s_axi_arcache;
  input s_axi_arvalid;
  input [7:0]s_axi_arlen;
  input [2:0]s_axi_arsize;
  input [1:0]s_axi_arburst;
  input s_axi_arlock;
  output s_axi_arready;
  output [11:0]s_axi_rid;
  output [31:0]s_axi_rdata;
  output [1:0]s_axi_rresp;
  output s_axi_rvalid;
  output s_axi_rlast;
  input s_axi_rready;
  output [31:0]m_ahb_haddr;
  output m_ahb_hwrite;
  output [2:0]m_ahb_hsize;
  output [2:0]m_ahb_hburst;
  output [3:0]m_ahb_hprot;
  output [1:0]m_ahb_htrans;
  output m_ahb_hmastlock;
  output [31:0]m_ahb_hwdata;
  input m_ahb_hready;
  input [31:0]m_ahb_hrdata;
  input m_ahb_hresp;
endmodule
