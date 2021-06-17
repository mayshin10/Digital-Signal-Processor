`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: HUINS
// Engineer: 
// 
// Create Date: 2012/11/28 13:46:07
// Design Name: segment
// Module Name: seven_seg
// Project Name: segment
// Target Devices: xc7z020clg484-1
// Tool Versions: Xilinx PlanAhead 14.3
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module seven_seg(
input clk,
input resetn,
input [31:0] data, 
output reg [7:0] segout, 
output reg [7:0] segcom,
output [7:0] led_out);

  wire [7:0] seg1;
  wire [7:0] seg2;
  wire [7:0] seg3;
  wire [7:0] seg4;
  wire [7:0] seg5;
  wire [7:0] seg6;
  wire [7:0] seg7;
  wire [7:0] seg8;

  reg[14:0] clk_cnt; 
  reg[2:0] com_cnt; 

  bin2seg bin2seg_1 (.bin_data(data[31:28]), .seg_data(seg1));
  bin2seg bin2seg_2 (.bin_data(data[27:24]), .seg_data(seg2));
  bin2seg bin2seg_3 (.bin_data(data[23:20]), .seg_data(seg3));
  bin2seg bin2seg_4 (.bin_data(data[19:16]), .seg_data(seg4));
  bin2seg bin2seg_5 (.bin_data(data[15:12]), .seg_data(seg5));
  bin2seg bin2seg_6 (.bin_data(data[11:8]), .seg_data(seg6));
  bin2seg bin2seg_7 (.bin_data(data[7:4]), .seg_data(seg7));
  bin2seg bin2seg_8 (.bin_data(data[3:0]), .seg_data(seg8));

  assign led_out = data[7:0];


  always @ (negedge resetn or posedge clk)
  begin
    if (!resetn)
    begin
      clk_cnt <= 15'd0;
      com_cnt <= 3'd0;
    end
    else
    begin
      if (clk_cnt == 15'd16384)
      begin
        clk_cnt <= 15'd0;
        if (com_cnt == 3'd7) com_cnt <= 3'd0;
        else com_cnt <= com_cnt + 3'd1;
      end
      else
      begin
        clk_cnt <= clk_cnt + 15'd1;
      end
    end
  end

  always @ (com_cnt or seg1 or seg2 or seg3 or seg4 or seg5 or seg6 or seg7 or seg8)
  begin
    case (com_cnt)
      3'd0: begin
        segcom <= 8'b10000000;
        segout <= ~seg1; end
      3'd1: begin
        segcom <= 8'b01000000;
        segout <= ~seg2; end
      3'd2: begin
        segcom <= 8'b00100000;
        segout <= ~seg3; end
      3'd3: begin
        segcom <= 8'b00010000;
        segout <= ~seg4; end
      3'd4: begin
        segcom <= 8'b00001000;
        segout <= ~seg5; end
      3'd5: begin
        segcom <= 8'b00000100;
        segout <= ~seg6; end
      3'd6: begin
        segcom <= 8'b00000010;
        segout <= ~seg7; end
      default: begin
        segcom <= 8'b00000001;
        segout <= ~seg8; end
    endcase
  end

endmodule
