module AHB2PORT1RAM (
// inputs and outputs
input         HRESETn,
input         BIGEND,
input         PORT1HCLK,
input         PORT1HSEL,
input         PORT1HREADYIN,
input   [1:0] PORT1HTRANS,
input   [1:0] PORT1HSIZE,
input         PORT1HWRITE,
input  [31:0] PORT1HWDATA,
input  [31:0] PORT1HADDR,
output [31:0] PORT1HRDATA,
output        PORT1HREADYOUT,
output  [1:0] PORT1HRESP,
input         PORT2HCLK,
input  [15:0] port2di,
input  [31:0] port2addr,
input   port2cs,
input [1:0] port2bwe,
output [15:0] port2do,
input fwrite,
input [15:0] fwaddr,
input [31:0] fwdata,
input sel_rbram
);

// -----------------------------------------------------------------------------
// Signal declaration
//wire        HRESETn;
wire  [2:1] REQ;
reg   [1:0] PORT1HSIZEREG;
reg         PORT1HWRITEREG;
reg         PORT1HWRITEOLD;
reg         PORt1HREADYOLD;
reg  [31:0] PORT1HADDRREG;
reg   [1:0] PORT1HTRANSREG;
reg         PORT1HSELREG;
reg         P1HWRITEMUX;
wire [31:0] P1HADDRMUX; 
//
// -----------------------------------------------------------------------------
// start of main code  
     
//  register hsize,hwrite and haddr to create data phase signals PORT 1
always @ (posedge PORT1HCLK or negedge HRESETn)
begin 
  if (!HRESETn)
    begin 
      PORT1HSIZEREG    <= 2'b10;
      PORT1HWRITEREG   <= 1'b0 ;
      PORT1HADDRREG    <= 32'h00000000;
      PORT1HSELREG     <= 1'b0;
      PORT1HTRANSREG   <= 2'b00;
      PORT1HWRITEOLD   <= 1'b0;
      P1HWRITEMUX      <= 1'b0;
    end else begin
      PORT1HWRITEOLD   <= (PORT1HWRITE & PORT1HSEL & PORT1HTRANS[1]);
      P1HWRITEMUX   <= (PORT1HWRITE & PORT1HSEL & PORT1HTRANS[1] &
                           PORT1HREADYIN);
      if (PORT1HREADYIN)
        begin
          PORT1HSIZEREG    <= PORT1HSIZE;
          PORT1HWRITEREG   <= PORT1HWRITE;
          PORT1HADDRREG    <= PORT1HADDR;
          PORT1HSELREG     <= PORT1HSEL;
          PORT1HTRANSREG   <= PORT1HTRANS;
        end 
    end 
end // always
//Only write to BRAM in Write data phase
//assign P1HWRITEMUX   = PORT1HWRITEOLD & PORT1HREADYIN;
//Delayed in Write Data Phase, else straight through
assign P1HADDRMUX    = P1HWRITEMUX ? PORT1HADDRREG : PORT1HADDR;
// CS on write data phase or read addr phase
assign REQ[1] = (PORT1HTRANSREG[1] & PORT1HWRITEREG & PORT1HSELREG) |
               (PORT1HTRANS[1] & ~PORT1HWRITE & PORT1HSEL);
// -----------------------------------------------------------------------------
// multiplexing hsize and hwrite and haddr and hwdata
assign PORT1HRESP     = 2'b00;
// Hready needs to be held off if a write was previously committed to DPRAM and
// now a read to DPRAM is required as the address/control phase will overlap.
assign PORT1HREADYOUT = ~(~PORT1HWRITE & PORT1HWRITEOLD & PORT1HTRANS[1]);
reg   [1:0] HADDR1Masked;  // Uses size and BIGEND
wire  [3:0] BWE1;
    
// Byte lane decoding for ssram    
// ----------------------------
// memory byte lane enables are decoded from transfer size, A1, A0 & endianness.
// Change the address so that :
// - The two bottom bits are inverted in BIGEND mode
always @ (P1HADDRMUX or BIGEND)
begin
  HADDR1Masked[1:0]   = PORT1HADDRREG[1:0] ^ {BIGEND, BIGEND};
end
// Decode byte write enables
// Only relevant for writes hence done in write data phase
assign BWE1[0] = P1HWRITEMUX && ( (PORT1HSIZEREG == 2'b10) || 
  ((PORT1HSIZEREG == 2'b01) && !HADDR1Masked[1]) || 
  ((PORT1HSIZEREG == 2'b00 ) && (HADDR1Masked[1:0] == 2'b00)));
assign BWE1[1] = P1HWRITEMUX && ( (PORT1HSIZEREG == 2'b10) || 
  ((PORT1HSIZEREG == 2'b01) && !HADDR1Masked[1]) || 
  ((PORT1HSIZEREG == 2'b00 ) && (HADDR1Masked[1:0] == 2'b01)));
assign BWE1[2] = P1HWRITEMUX && ( (PORT1HSIZEREG == 2'b10) || 
  ((PORT1HSIZEREG == 2'b01) && HADDR1Masked[1]) || 
  ((PORT1HSIZEREG == 2'b00 ) && (HADDR1Masked[1:0] == 2'b10)));
assign BWE1[3] = P1HWRITEMUX && ( (PORT1HSIZEREG == 2'b10) || 
  ((PORT1HSIZEREG == 2'b01) && HADDR1Masked[1]) || 
  ((PORT1HSIZEREG == 2'b00 ) && (HADDR1Masked[1:0] == 2'b11)));
  
  
/* To write data from the filter */
wire en_BRAM_i;
wire en_BRAM_j;
wire [15:0] dout_BRAM_i;
wire [15:0] dout_BRAM_j;

/* Write data from the filter when fwrite signal comes in */
assign en_BRAM_i = (sel_rbram == 0) ? 1'b1 : 0;
assign en_BRAM_j = (sel_rbram == 1) ? 1'b1 : 0;
assign port2do = (sel_rbram == 0) ? dout_BRAM_i : dout_BRAM_j;

/*original image store and load */
bufferram bufferram_i (
  .clka ( PORT2HCLK ), // read clock
  .ena ( en_BRAM_i ), // read enable
  .wea ( port2bwe ), // write enable -> always 0
  .addra ( port2addr[16:0] ), // read address
  .dina ( port2di ), // write data -> always 0
  .douta( dout_BRAM_i ), // read data
  .clkb ( PORT1HCLK ), // write clock from processor system
  .enb ( REQ[1] ), // write enable from processor system
  .web ( BWE1 ), // write enable from processor system
  .addrb( P1HADDRMUX[17:2]), // write address from processor system
  .dinb(PORT1HWDATA), // write data from processor system
  .doutb(PORT1HRDATA) // read data to processor system
);

/* filtered Image store and load */
bufferram bufferram_j (
  .clka ( PORT2HCLK ), // read clock
  .ena ( en_BRAM_j ), // read enable
  .wea ( 1'b0 ), // write enable -> always 0
  .addra ( port2addr[16:0] ), // read address
  .dina ( 1'b0 ), // write data -> always 0
  .douta( dout_BRAM_j ), // read data
  .clkb ( PORT2HCLK ), // write clock from filter.v
  .enb ( fwrite ), // write enable from filter.v
  .web ( fwrite  ), // write enable from filter.v
  .addrb( fwaddr ), // write address from filter.v
  .dinb( fwdata ), // write data from filter.v
  .doutb(1'b0) // read data to filter.v -> always 0
);

endmodule
