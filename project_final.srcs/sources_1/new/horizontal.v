`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2014/07/31 12:55:01
// Design Name: 
// Module Name: horizontal
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


module horizontal(CLK,UP_CLKa,H_COUNT,Hsync,hDE,RESET);
    
    input CLK;
    input RESET;
    
    output reg UP_CLKa;
    output reg [9:0] H_COUNT;
    output reg Hsync;
    output reg hDE;
    
    always@(posedge CLK or posedge RESET)
    begin
        if(RESET)
        begin
            Hsync <= 1'b0;
            H_COUNT <= 10'd0;
            hDE <= 1'b0;
            UP_CLKa <= 1'b0;
        end
        else
        begin
            UP_CLKa <= ~Hsync;        
            if (H_COUNT <= 10'd40)
            begin
                Hsync <= 1'b0;
                hDE <= 1'b0;
            end
            else if ((H_COUNT > 10'd40) && (H_COUNT <= 10'd42))
            begin
                Hsync <= 1'b1;
                hDE <= 1'b0;
            end
            else if ((H_COUNT > 10'd42) && (H_COUNT <= 10'd522))
            begin
                Hsync <= 1'b1;
                hDE <= 1'b1;
            end
            else if ((H_COUNT > 10'd522) && (H_COUNT <= 10'd524))
            begin
                Hsync <= 1'b1;
                hDE <= 1'b0;
            end
            if (H_COUNT < 10'd524)
                H_COUNT <= H_COUNT + 10'd1;
            else
                H_COUNT <= 10'd0;
        end
    end

endmodule
