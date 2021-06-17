`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2014/07/31 12:50:55
// Design Name: 
// Module Name: g2m
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////



//
// TFT-LCD Clock 생성
// 입력 Clock을 2분주 시킴
//

module g2m(
  input CLK,
  input RESET,
  output reg UP_CLK);
    
  always@(posedge RESET or posedge CLK)
  begin
    if(RESET == 1)
        UP_CLK = 0;
    else
        UP_CLK = ~UP_CLK;
  end
    
endmodule
