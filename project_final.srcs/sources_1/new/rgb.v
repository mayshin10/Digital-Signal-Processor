module rgb(R,G,B,H_COUNT,V_COUNT,DE,RESET, Reverse_SW);
    
    input [9:0] H_COUNT;
    input [9:0] V_COUNT;
    input DE;
    input RESET;
    input Reverse_SW;
    
    output reg [7:3] R;
    output reg [7:2] G;
    output reg [7:3] B;
    
    wire [9:0] NEW_V_COUNT;
    assign NEW_V_COUNT = (Reverse_SW) ?  271 - (V_COUNT-12) + 12 : V_COUNT ;
    
    always@(DE,H_COUNT,V_COUNT,RESET)
    begin
        if(RESET == 1)
        begin
            R = 0;
            G = 0;
            B = 0;
        end
        
        else if(DE == 1)
        begin
            if(H_COUNT >= 10'd1)
            begin
            
                if ((NEW_V_COUNT > 10'd11) && (NEW_V_COUNT <= 10'd45))	/* white */
                begin
                    R = 5'b11111;
                    G = 6'b111111;
                    B = 5'b111111;
                end
                else if ((NEW_V_COUNT > 10'd45) && (NEW_V_COUNT <= 10'd79)) 	/* yellow */
                begin
                    R = 5'b11111;
                    G = 6'b111111;
                    B = 0;
                end
                else if ((NEW_V_COUNT > 10'd79) && (NEW_V_COUNT <= 10'd113)) 	/* cyan */
                begin
                    R = 0;
                    G = 6'b111111;
                    B = 5'b11111;
                end
                else if ((NEW_V_COUNT > 10'd113) && (NEW_V_COUNT <= 10'd147)) 	/* green */
                begin
                 R = 0;
                                   G = 6'b111111;
                                   B = 0;
                               end
                               else if ((NEW_V_COUNT > 10'd147) && (NEW_V_COUNT <= 10'd181))    /* purplr */
                               begin
                                   R = 5'b11111;
                                   G = 0;
                                   B = 5'b11111;
                               end
                               else if ((NEW_V_COUNT > 10'd181) && (NEW_V_COUNT <= 10'd215))    /* red */
                               begin
                                   R = 5'b11111;
                                   G = 0;
                                   B = 0;
                               end  
                               else if ((NEW_V_COUNT > 10'd215) && (NEW_V_COUNT <= 10'd249))     /* blue */
                               begin
                                   R = 0;
                                   G = 0;
                                   B = 5'b11111;
                               end
                               else if ((NEW_V_COUNT > 10'd249) && (NEW_V_COUNT <= 10'd283))     /* white */
                               begin
                                   R = 5'b11111;
                                   G = 6'b111111;
                                   B = 5'b11111;
                               end
                               else 
                               begin
                                   R = 0;
                                   G = 0;
                                   B = 0;
                               end
                           end
                       end
                       else
                       begin
                           R = 0;
                           G = 0;
                           B = 0;
                       end
                       
                   end
                   
               endmodule