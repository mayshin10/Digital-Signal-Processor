module top(
inout [14:0]DDR_addr,
inout [2:0]DDR_ba,
inout DDR_cas_n,
inout DDR_ck_n,
inout DDR_ck_p,
inout DDR_cke,
inout DDR_cs_n,
inout [3:0]DDR_dm,
inout [31:0]DDR_dq,
inout [3:0]DDR_dqs_n,
inout [3:0]DDR_dqs_p,
inout DDR_odt,
inout DDR_ras_n,
inout DDR_reset_n,
inout DDR_we_n,
inout FIXED_IO_ddr_vrn,
inout FIXED_IO_ddr_vrp,
inout [53:0]FIXED_IO_mio,
inout FIXED_IO_ps_clk,
inout FIXED_IO_ps_porb,
inout FIXED_IO_ps_srstb,
input TFTLCD_CLK,
input TFTLCD_nRESET,
output TFTLCD_TCLK,	// TFT-LCD Clock
output wire TFTLCD_Hsync,	// TFT-LCD HSYNC
output wire TFTLCD_Vsync,	// TFT-LCD VSYNC
output wire TFTLCD_DE_out,	// TFT-LCD Data enable
output [7:3] TFTLCD_R, // TFT-LCD Red signal 
output [7:2] TFTLCD_G, // TFT-LCD Green signal
output [7:3] TFTLCD_B, // TFT-LCD Blue signal
output TFTLCD_Tpower,  // TFT-LCD Backlight On signal
output [7:0] segout,
output [7:0] segcom,
output [2:0] LED
);

// AHB Slave 0
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

// AHB Slave 1
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

//wires for common 
wire [31:0] SEGDATA;
wire clk;
wire [31:0] cycle;
wire resetn;

//wires for BRAM
wire BRAMCLK;
wire [16:0] BRAMADDR;
wire [15:0] BRAMDATA;

//hresponse for register set 
wire [1:0] register_set_0_hresp;
wire [1:0] register_set_1_hresp;

//wires for register set 
wire [31:0] register_set_1_reg0;
wire [31:0] register_set_1_reg1;
wire START;
wire INIT;


//wires for a filter, interrupt, display mode
wire fwrite;
wire [15:0] fwaddr;
wire [16:0] fraddr;
wire [31:0] fwdata;
wire END;
wire Core0_nIRQ;
wire [1:0] TFTLCD_SW;
wire sel;


//00: edge mode, 01: sharp mode, 10: blur mode
assign TFTLCD_SW[0] = register_set_1_reg0[0];   //0이면 rgb, 1이면 image
assign TFTLCD_SW[1] = register_set_1_reg1[0];   //0이면 normal, 1이면 반전

//LED assignment
assign LED[0] = sel;
assign LED[1] = register_set_1_reg0[0]; 
assign LED[2] = register_set_1_reg1[0];

filter filter_i(
  .clk(BRAMCLK),
  .resetn(TFTLCD_nRESET),
  .raddr(BRAMADDR), //read address
  .rdata(BRAMDATA),   //read data
  .mode(TFTLCD_SW),     //filtering mode
  .wen(fwrite),   //write enable
  .waddr(fwaddr),  //write address
  .wdata(fwdata), //write data
  .Intr(Core0_nIRQ), //interrupt signal
  .cycle(cycle), //comsumed cycle
  .START(START),  //start signal
  .INIT(INIT),  //initialize signal
  .END(END)  //end flag
);

TFTLCDCtrl TFTLCDCtrl_i (
      .CLK(TFTLCD_CLK),
      .nRESET(TFTLCD_nRESET),
      .TCLK(TFTLCD_TCLK),
      .Hsync(TFTLCD_Hsync),
      .Vsync(TFTLCD_Vsync),
      .DE_out(TFTLCD_DE_out),
      .R(TFTLCD_R),
      .G(TFTLCD_G),
      .B(TFTLCD_B),
      .Tpower(TFTLCD_Tpower),
      .BRAMCLK(BRAMCLK),
      .BRAMADDR(BRAMADDR),
      .BRAMDATA(BRAMDATA),
      .SW(TFTLCD_SW),
      .sel(sel),
      .START(START)
);
  
AHB2PORT1RAM AHB2PORT1RAM_i (
    .HRESETn ( resetn ),
    .BIGEND ( 1'b0 ),
    .PORT1HCLK ( clk ),
    .PORT1HSEL ( 1'b1 ),
    .PORT1HREADYIN ( M_AHB_0_hready ),
    .PORT1HTRANS ( M_AHB_0_htrans ),
    .PORT1HSIZE ( M_AHB_0_hsize[1:0] ),
    .PORT1HWRITE ( M_AHB_0_hwrite ),
    .PORT1HWDATA ( M_AHB_0_hwdata ),
    .PORT1HRDATA ( M_AHB_0_hrdata ),
    .PORT1HADDR ( M_AHB_0_haddr ),
    .PORT1HREADYOUT ( M_AHB_0_hready ),
    .PORT1HRESP (register_set_0_hresp ),
    .PORT2HCLK ( BRAMCLK ),
    .port2addr ( BRAMADDR ),
    .port2di ( 32'd0 ),
    .port2cs ( 1'b1 ),
    .port2bwe ( 2'b0000 ),
    .port2do ( BRAMDATA ),
    .fwrite(fwrite),   //filter write enable
    .fwaddr(fwaddr),  //filter write address
    .fwdata(fwdata), //filter write data
    .sel_rbram(sel)
 );


register_set register_set_1 (
  .HCLK(clk),
  .HRESETn(resetn),
  .HSEL(1'b1),
  .HADDR(M_AHB_1_haddr),
  .HWRITE(M_AHB_1_hwrite),
  .HTRANS(M_AHB_1_htrans),
  .HSIZE(M_AHB_1_hsize),
  .HWDATA(M_AHB_1_hwdata),
  .HREADY(M_AHB_1_hready),
  .HREADYin(M_AHB_1_hready),
  .HRESP(register_set_1_hresp),
  .HRDATA(M_AHB_1_hrdata),
  .REG0(register_set_1_reg0),
  .REG1(register_set_1_reg1),
  .REG2(START),
  .REG3(INIT)
);

seven_seg seven_seg_inst (
 .clk(TFTLCD_CLK),
 .resetn(TFTLCD_nRESET),
 .data(SEGDATA), //SEGDATA = system_wrapper's seven_seg IP output
 .segout(segout),
 .segcom(segcom)
);

assign M_AHB_0_hresp = (register_set_0_hresp == 2'b00) ? 1'b0 : 1'b1;
assign M_AHB_1_hresp = (register_set_1_hresp == 2'b00) ? 1'b0 : 1'b1;

system_wrapper system_wrapper_i (
.Core0_nIRQ(~Core0_nIRQ),
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
.resetn(resetn)
);

endmodule