
/* four register set module */

module register_set (
  input HCLK,
  input HRESETn,
  input HSEL,
  input [31:0] HADDR,
  input HWRITE,
  input [1:0] HTRANS,
  input [2:0] HSIZE,
  input [31:0] HWDATA,
  output HREADY,
  input HREADYin,
  output [1:0] HRESP,
  output reg [31:0] HRDATA,
  output [31:0] REG0, //mode[0]
  output [31:0] REG1, //mode[1]
  output [31:0] REG2, //START
  output [31:0] REG3  //END
  );

  reg [31:0] curr_haddr;
  reg [31:0] next_haddr;
  reg curr_hwrite;
  reg next_hwrite;
  reg [2:0] curr_hsize;
  reg [2:0] next_hsize;
  reg [31:0] curr_reg0; //mode[0]
  reg [31:0] next_reg0;
  reg [31:0] curr_reg1; //mode[1]
  reg [31:0] next_reg1;
  reg [31:0] curr_reg2; //START
  reg [31:0] next_reg2;
  reg [31:0] curr_reg3; //INIT
  reg [31:0] next_reg3;
  reg [31:0] curr_ext;
  reg [31:0] next_ext;
  reg curr_hsel;
  reg next_hsel;
  reg [31:0] sig_hwdata;
  reg [31:0] sig_hrdata;

  assign HREADY = 1'b1;
  assign HRESP = 2'b00;
  assign REG0 = curr_reg0;
  assign REG1 = curr_reg1;
  assign REG2 = curr_reg2;
  assign REG3 = curr_reg3;

  always @ (HSEL or HREADYin or HTRANS or HADDR or HWRITE or HSIZE or curr_haddr or
            curr_hwrite or curr_hsize)
  begin
    if (HSEL && HREADYin && HTRANS[1])
    begin
      next_haddr <= HADDR;
      next_hwrite <= HWRITE;
      next_hsize <= HSIZE;
      next_hsel <= 1'b1;
    end
    else
    begin
      next_haddr <= curr_haddr;
      next_hwrite <= curr_hwrite;
      next_hsize <= curr_hsize;
      next_hsel <= 1'b0;
    end
  end

  always @ (posedge HCLK or negedge HRESETn)
  begin
    if (!HRESETn)
    begin
      curr_haddr <= 32'd0;
      curr_hwrite <= 1'b0;
      curr_hsize <= 3'b010;
      curr_hsel <= 1'b0;
    end
    else
    begin
      curr_haddr <= next_haddr;
      curr_hwrite <= next_hwrite;
      curr_hsize <= next_hsize;
      curr_hsel <= next_hsel;
    end
  end

  always @ (curr_reg0 or curr_reg1 or curr_reg2 or curr_reg3 or curr_hsel or curr_hwrite or curr_haddr or sig_hwdata)
  begin
    next_reg0 <= curr_reg0;
    next_reg1 <= curr_reg1;
    next_reg2 <= curr_reg2;
    next_reg3 <= curr_reg3;
    next_ext <= curr_ext;
    sig_hrdata <= 32'd0;
    if (curr_hsel)
    begin
      if (curr_hwrite)
      begin
        case (curr_haddr[5:2])
          4'b0000: next_reg0 <= sig_hwdata;
          4'b0001: next_reg1 <= sig_hwdata;
          4'b0010: next_reg2 <= sig_hwdata;
          4'b0011: next_reg3 <= sig_hwdata;
          default: next_ext <= sig_hwdata;
        endcase
      end
      else
      begin
        case (curr_haddr[5:2])
          4'b0000: sig_hrdata <= curr_reg0;
          4'b0001: sig_hrdata <= curr_reg1;
          4'b0010: sig_hrdata <= curr_reg2;
          4'b0011: sig_hrdata <= curr_reg3;
          default: sig_hrdata <= 32'd0;
        endcase
      end
    end
  end
 
  always @ (posedge HCLK or negedge HRESETn)
  begin
    if (!HRESETn)
    begin
      curr_reg0 <= 32'd0;
      curr_reg1 <= 32'd0;
      curr_reg2 <= 32'd0;
      curr_reg3 <= 32'd0;
      curr_ext <= 32'd0;
    end
    else
    begin
      curr_reg0 <= next_reg0;
      curr_reg1 <= next_reg1;
      curr_reg2 <= next_reg2;
      curr_reg3 <= next_reg3;
      curr_ext <= next_reg0;
    end
  end

  always @ (curr_hsize or HWDATA or curr_haddr or sig_hrdata)
  begin
    if (curr_hsize == 3'b001)
    begin
      sig_hwdata <= {2{HWDATA[15:0]}};
      if (curr_haddr[1])
        HRDATA <= {2{HWDATA[31:16]}};
      else
        HRDATA <= {2{HWDATA[15:0]}};
    end
    else if (curr_hsize == 3'b000)
    begin
      sig_hwdata <= {4{HWDATA[7:0]}};
      if (curr_haddr[1:0] == 2'b11)
        HRDATA <= {4{sig_hrdata[31:24]}};
      else if (curr_haddr[1:0] == 2'b10)
        HRDATA <= {4{sig_hrdata[23:16]}};
      else if (curr_haddr[1:0] == 2'b01)
        HRDATA <= {4{sig_hrdata[15:8]}};
      else
        HRDATA <= {4{sig_hrdata[7:0]}};
    end
    else
    begin
      HRDATA <= sig_hrdata;
      sig_hwdata <= HWDATA;
    end
  end

endmodule
