`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: HUINS
// Engineer: 
// 
// Create Date: 2012/11/28 13:46:07
// Design Name: segment
// Module Name: bin2seg
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


module bin2seg(
input [3:0] bin_data,
output reg [7:0] seg_data);

  always @(bin_data)
  begin
    case (bin_data)
      4'b0000 : seg_data <= 8'b11111100 ; 
      4'b0001 : seg_data <= 8'b01100000 ; 
      4'b0010 : seg_data <= 8'b11011010 ; 
      4'b0011 : seg_data <= 8'b11110010 ; 
      4'b0100 : seg_data <= 8'b01100110 ; 
      4'b0101 : seg_data <= 8'b10110110 ; 
      4'b0110 : seg_data <= 8'b10111110 ; 
      4'b0111 : seg_data <= 8'b11100100 ; 
      4'b1000 : seg_data <= 8'b11111110 ;
      4'b1001 : seg_data <= 8'b11110110 ;
      4'b1010 : seg_data <= 8'b00000010 ;
      default : seg_data <= 8'b11111100 ; 
    endcase 
  end 

endmodule