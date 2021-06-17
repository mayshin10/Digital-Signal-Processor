`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2014/07/31 12:55:38
// Design Name: 
// Module Name: vertical
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


module vertical(CLK,V_COUNT,Vsync,vDE,RESET);
    
    input CLK;
    input RESET;
    
    output reg [9:0] V_COUNT;
    output reg Vsync;
    output reg vDE;
    
    always@(posedge CLK or posedge RESET)
    begin
        if(RESET)
        begin
            V_COUNT <= 10'd0;
            Vsync <= 1'b0;
            vDE <= 1'b0;
        end
        else
        begin
            if (V_COUNT <= 9)
            begin
                Vsync <= 1'b0;
                vDE <= 1'b0;
            end
            else if ((V_COUNT > 9) && (V_COUNT <= 11))
            begin
                Vsync <= 1'b1;
                vDE <= 1'b0;
            end
            else if ((V_COUNT > 11) && (V_COUNT <= 283))
            begin
                Vsync <= 1'b1;
                vDE <= 1'b1;
            end
            else if ((V_COUNT > 283) && (V_COUNT <= 285))
            begin
                Vsync <= 1'b1;
                vDE <= 1'b0;
            end
            if (V_COUNT < 285)
              V_COUNT <= V_COUNT + 10'b1;
            else
              V_COUNT <= 10'd0;
        end
    end
    
endmodule
