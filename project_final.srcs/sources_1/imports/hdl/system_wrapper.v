//Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2019.1 (win64) Build 2552052 Fri May 24 14:49:42 MDT 2019
//Date        : Sat Jun 12 03:55:03 2021
//Host        : DESKTOP-5K5FCUF running 64-bit major release  (build 9200)
//Command     : generate_target system_wrapper.bd
//Design      : system_wrapper
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module system_wrapper
   (Core0_nIRQ,
    DDR_addr,
    DDR_ba,
    DDR_cas_n,
    DDR_ck_n,
    DDR_ck_p,
    DDR_cke,
    DDR_cs_n,
    DDR_dm,
    DDR_dq,
    DDR_dqs_n,
    DDR_dqs_p,
    DDR_odt,
    DDR_ras_n,
    DDR_reset_n,
    DDR_we_n,
    FIXED_IO_ddr_vrn,
    FIXED_IO_ddr_vrp,
    FIXED_IO_mio,
    FIXED_IO_ps_clk,
    FIXED_IO_ps_porb,
    FIXED_IO_ps_srstb,
    M_AHB_0_haddr,
    M_AHB_0_hburst,
    M_AHB_0_hmastlock,
    M_AHB_0_hprot,
    M_AHB_0_hrdata,
    M_AHB_0_hready,
    M_AHB_0_hresp,
    M_AHB_0_hsize,
    M_AHB_0_htrans,
    M_AHB_0_hwdata,
    M_AHB_0_hwrite,
    M_AHB_1_haddr,
    M_AHB_1_hburst,
    M_AHB_1_hmastlock,
    M_AHB_1_hprot,
    M_AHB_1_hrdata,
    M_AHB_1_hready,
    M_AHB_1_hresp,
    M_AHB_1_hsize,
    M_AHB_1_htrans,
    M_AHB_1_hwdata,
    M_AHB_1_hwrite,
    SEGDATA,
    clk,
    cycle,
    resetn);
  input Core0_nIRQ;
  inout [14:0]DDR_addr;
  inout [2:0]DDR_ba;
  inout DDR_cas_n;
  inout DDR_ck_n;
  inout DDR_ck_p;
  inout DDR_cke;
  inout DDR_cs_n;
  inout [3:0]DDR_dm;
  inout [31:0]DDR_dq;
  inout [3:0]DDR_dqs_n;
  inout [3:0]DDR_dqs_p;
  inout DDR_odt;
  inout DDR_ras_n;
  inout DDR_reset_n;
  inout DDR_we_n;
  inout FIXED_IO_ddr_vrn;
  inout FIXED_IO_ddr_vrp;
  inout [53:0]FIXED_IO_mio;
  inout FIXED_IO_ps_clk;
  inout FIXED_IO_ps_porb;
  inout FIXED_IO_ps_srstb;
  output [31:0]M_AHB_0_haddr;
  output [2:0]M_AHB_0_hburst;
  output M_AHB_0_hmastlock;
  output [3:0]M_AHB_0_hprot;
  input [31:0]M_AHB_0_hrdata;
  input M_AHB_0_hready;
  input M_AHB_0_hresp;
  output [2:0]M_AHB_0_hsize;
  output [1:0]M_AHB_0_htrans;
  output [31:0]M_AHB_0_hwdata;
  output M_AHB_0_hwrite;
  output [31:0]M_AHB_1_haddr;
  output [2:0]M_AHB_1_hburst;
  output M_AHB_1_hmastlock;
  output [3:0]M_AHB_1_hprot;
  input [31:0]M_AHB_1_hrdata;
  input M_AHB_1_hready;
  input M_AHB_1_hresp;
  output [2:0]M_AHB_1_hsize;
  output [1:0]M_AHB_1_htrans;
  output [31:0]M_AHB_1_hwdata;
  output M_AHB_1_hwrite;
  output [31:0]SEGDATA;
  output clk;
  input [31:0]cycle;
  output [0:0]resetn;

  wire Core0_nIRQ;
  wire [14:0]DDR_addr;
  wire [2:0]DDR_ba;
  wire DDR_cas_n;
  wire DDR_ck_n;
  wire DDR_ck_p;
  wire DDR_cke;
  wire DDR_cs_n;
  wire [3:0]DDR_dm;
  wire [31:0]DDR_dq;
  wire [3:0]DDR_dqs_n;
  wire [3:0]DDR_dqs_p;
  wire DDR_odt;
  wire DDR_ras_n;
  wire DDR_reset_n;
  wire DDR_we_n;
  wire FIXED_IO_ddr_vrn;
  wire FIXED_IO_ddr_vrp;
  wire [53:0]FIXED_IO_mio;
  wire FIXED_IO_ps_clk;
  wire FIXED_IO_ps_porb;
  wire FIXED_IO_ps_srstb;
  wire [31:0]M_AHB_0_haddr;
  wire [2:0]M_AHB_0_hburst;
  wire M_AHB_0_hmastlock;
  wire [3:0]M_AHB_0_hprot;
  wire [31:0]M_AHB_0_hrdata;
  wire M_AHB_0_hready;
  wire M_AHB_0_hresp;
  wire [2:0]M_AHB_0_hsize;
  wire [1:0]M_AHB_0_htrans;
  wire [31:0]M_AHB_0_hwdata;
  wire M_AHB_0_hwrite;
  wire [31:0]M_AHB_1_haddr;
  wire [2:0]M_AHB_1_hburst;
  wire M_AHB_1_hmastlock;
  wire [3:0]M_AHB_1_hprot;
  wire [31:0]M_AHB_1_hrdata;
  wire M_AHB_1_hready;
  wire M_AHB_1_hresp;
  wire [2:0]M_AHB_1_hsize;
  wire [1:0]M_AHB_1_htrans;
  wire [31:0]M_AHB_1_hwdata;
  wire M_AHB_1_hwrite;
  wire [31:0]SEGDATA;
  wire clk;
  wire [31:0]cycle;
  wire [0:0]resetn;

  system system_i
       (.Core0_nIRQ(Core0_nIRQ),
        .DDR_addr(DDR_addr),
        .DDR_ba(DDR_ba),
        .DDR_cas_n(DDR_cas_n),
        .DDR_ck_n(DDR_ck_n),
        .DDR_ck_p(DDR_ck_p),
        .DDR_cke(DDR_cke),
        .DDR_cs_n(DDR_cs_n),
        .DDR_dm(DDR_dm),
        .DDR_dq(DDR_dq),
        .DDR_dqs_n(DDR_dqs_n),
        .DDR_dqs_p(DDR_dqs_p),
        .DDR_odt(DDR_odt),
        .DDR_ras_n(DDR_ras_n),
        .DDR_reset_n(DDR_reset_n),
        .DDR_we_n(DDR_we_n),
        .FIXED_IO_ddr_vrn(FIXED_IO_ddr_vrn),
        .FIXED_IO_ddr_vrp(FIXED_IO_ddr_vrp),
        .FIXED_IO_mio(FIXED_IO_mio),
        .FIXED_IO_ps_clk(FIXED_IO_ps_clk),
        .FIXED_IO_ps_porb(FIXED_IO_ps_porb),
        .FIXED_IO_ps_srstb(FIXED_IO_ps_srstb),
        .M_AHB_0_haddr(M_AHB_0_haddr),
        .M_AHB_0_hburst(M_AHB_0_hburst),
        .M_AHB_0_hmastlock(M_AHB_0_hmastlock),
        .M_AHB_0_hprot(M_AHB_0_hprot),
        .M_AHB_0_hrdata(M_AHB_0_hrdata),
        .M_AHB_0_hready(M_AHB_0_hready),
        .M_AHB_0_hresp(M_AHB_0_hresp),
        .M_AHB_0_hsize(M_AHB_0_hsize),
        .M_AHB_0_htrans(M_AHB_0_htrans),
        .M_AHB_0_hwdata(M_AHB_0_hwdata),
        .M_AHB_0_hwrite(M_AHB_0_hwrite),
        .M_AHB_1_haddr(M_AHB_1_haddr),
        .M_AHB_1_hburst(M_AHB_1_hburst),
        .M_AHB_1_hmastlock(M_AHB_1_hmastlock),
        .M_AHB_1_hprot(M_AHB_1_hprot),
        .M_AHB_1_hrdata(M_AHB_1_hrdata),
        .M_AHB_1_hready(M_AHB_1_hready),
        .M_AHB_1_hresp(M_AHB_1_hresp),
        .M_AHB_1_hsize(M_AHB_1_hsize),
        .M_AHB_1_htrans(M_AHB_1_htrans),
        .M_AHB_1_hwdata(M_AHB_1_hwdata),
        .M_AHB_1_hwrite(M_AHB_1_hwrite),
        .SEGDATA(SEGDATA),
        .clk(clk),
        .cycle(cycle),
        .resetn(resetn));
endmodule
