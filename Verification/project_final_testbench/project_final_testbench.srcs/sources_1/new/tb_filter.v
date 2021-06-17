`timescale 1ns/1ns
module tb_filter;
reg clk, resetn;
reg [16:0] raddr;
reg [15:0] rdata;
reg [1:0] mode;
wire wen;
wire [15:0] waddr;
wire [31:0] wdata;
wire Intr;
wire [31:0] cycle;
reg START, INIT;
wire END;

filter FILTER(
  .clk(clk),
  .resetn(resetn),
  .raddr(raddr),
  .rdata(rdata),   //read data
  .mode(mode),     //filtering mode
  .wen(wen),   //write enable
  .waddr(waddr),  //write address
  .wdata(wdata), //write data
  .Intr(Intr), //interrupt signal
  .cycle(cycle), //comsumed cycle
  .START(START),
  .INIT(INIT),
  .END(END)
  
);

initial
begin
	clk = 1'b0;
	resetn = 1'b0;
	raddr = 17'd130594;
	rdata = 0;
	mode = 0;
	START = 0;
	INIT = 0;
	#5
	resetn=1;
    START = 1;
	
end

always@(*)
begin
   #10 clk <= ~clk; 
end

always@(posedge clk)
begin
   if(raddr == 17'd130599)
      raddr = 0;
   else
      raddr = raddr +1;
   case(raddr)
      (17'd0): begin
         rdata = 16'h2989;
      end
      (17'd1): begin
         rdata = 16'h5c55;
      end
      (17'd2): begin
         rdata = 16'h5c36;
      end
      (17'd3): begin
         rdata = 16'h6436;
      end
      (17'd4): begin
         rdata = 16'h5c56;
      end
      (17'd5): begin
         rdata = 16'h5c36;
      end
      (17'd6): begin
         rdata = 16'h6416;
      end
      (17'd7): begin
         rdata = 16'h6436;
      end
      (17'd8): begin
         rdata = 16'h6436;
      end
      (17'd9): begin
         rdata = 16'h6436;
      end
      (17'd10): begin
         rdata = 16'h6436;
      end
      (17'd11): begin
         rdata = 16'h6436;
      end
      (17'd12): begin
         rdata = 16'h6436;
      end
      (17'd13): begin
         rdata = 16'h6436;
      end
      (17'd14): begin
         rdata = 16'h6436;
      end
      (17'd15): begin
         rdata = 16'h6436;
      end
      (17'd16): begin
         rdata = 16'h6436;
      end
      (17'd17): begin
         rdata = 16'h6436;
      end
      (17'd18): begin
         rdata = 16'h6436;
      end
      (17'd19): begin
         rdata = 16'h6436;
      end
      (17'd130585): begin
         rdata = 16'h2145;
      end
      (17'd130586): begin
         rdata = 16'h2145;
      end
      (17'd130587): begin
         rdata = 16'h2145;
      end
      (17'd130588): begin
         rdata = 16'h2145;
      end
      (17'd130589): begin
         rdata = 16'h2145;
      end
      (17'd130590): begin
         rdata = 16'h1925;
      end
      (17'd130591): begin
         rdata = 16'h2145;
      end
      (17'd130592): begin
         rdata = 16'h2165;
      end
      (17'd130593): begin
         rdata = 16'h2165;
      end
      (17'd130594): begin
         rdata = 16'h2165;
      end
      (17'd130595): begin
         rdata = 16'h2165;
      end
      (17'd130596): begin
         rdata = 16'h2145;
      end
      (17'd130597): begin
         rdata = 16'h2145;
      end
      (17'd130598): begin
         rdata = 16'h1904;
      end
      (17'd130599): begin
         rdata = 16'h1904;
      end
      
      default: begin
         rdata = 0;
      end
   endcase
end

endmodule