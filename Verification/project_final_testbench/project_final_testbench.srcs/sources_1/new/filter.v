`timescale 1ns / 1ps

module filter(
  input clk,
  input resetn,
  input [16:0] raddr, //read address
  input [15:0] rdata,   //read data
  input [1:0] mode,     //filtering mode
  output reg wen,   //write enable
  output reg [15:0] waddr,  //write address
  output reg [31:0] wdata, //write data
  output reg Intr, //interrupt signal
  output reg [31:0] cycle, //comsumed cycle
  input START,
  output reg END,
  input INIT
);

reg [4:0] im1_R, im2_R, im3_R, im4_R, im5_R;
reg [5:0] im1_G, im2_G, im3_G, im4_G, im5_G;
reg [4:0] im1_B, im2_B, im3_B, im4_B, im5_B;
reg [16:0] Sync; //sync with BRAMCtrl
reg [31:0] lastcell;
reg lastFlag;

wire [7:0] edge_R, sharp_R, blur_R;
wire [8:0] edge_G, sharp_G, blur_G;
wire [7:0] edge_B, sharp_B, blur_B;

wire [7:0] last_1_edge_R, last_1_sharp_R, last_1_blur_R;
wire [8:0] last_1_edge_G, last_1_sharp_G, last_1_blur_G;
wire [7:0] last_1_edge_B, last_1_sharp_B, last_1_blur_B;

wire [7:0] last_2_edge_R, last_2_sharp_R, last_2_blur_R;
wire [8:0] last_2_edge_G, last_2_sharp_G, last_2_blur_G;
wire [7:0] last_2_edge_B, last_2_sharp_B, last_2_blur_B;
 
assign edge_R = im1_R * (-1) + im2_R * (-2) + im3_R * 6 + im4_R *(-2) + im5_R * (-1) < 32  ? 
                  im1_R * (-1) + im2_R * (-2) + im3_R * 6 + im4_R *(-2) + im5_R * (-1) : 0;
assign edge_G = im1_G * (-1) + im2_G * (-2) + im3_G * 6 + im4_G *(-2) + im5_G * (-1) <  64 ? 
                  im1_G * (-1) + im2_G * (-2) + im3_G * 6 + im4_G *(-2) + im5_G * (-1) : 0;
assign edge_B = im1_B * (-1) + im2_B * (-2) + im3_B * 6 + im4_B *(-2) + im5_B * (-1) < 32 ?
                  im1_B * (-1) + im2_B * (-2) + im3_B * 6 + im4_B *(-2) + im5_B * (-1) : 0;
                  
assign sharp_R = im1_R * (-1) + im2_R * (-2) + im3_R * 7 + im4_R *(-2) + im5_R * (-1) < 32 ? 
                  im1_R * (-1) + im2_R * (-2) + im3_R * 7 + im4_R *(-2) + im5_R * (-1) : 0;
assign sharp_G = im1_G * (-1) + im2_G * (-2) + im3_G * 7 + im4_G *(-2) + im5_G * (-1) < 64 ? 
                  im1_G * (-1) + im2_G * (-2) + im3_G * 7 + im4_G *(-2) + im5_G * (-1) : 0;
assign sharp_B = im1_B * (-1) + im2_B * (-2) + im3_B * 7 + im4_B *(-2) + im5_B * (-1) < 32  ?
                  im1_B * (-1) + im2_B * (-2) + im3_B * 7 + im4_B *(-2) + im5_B * (-1) : 0;
                  
assign blur_R = im1_R * 1/10 + im2_R * 2/10 + im3_R * 4/10 + im4_R *2/10 + im5_R * 1/10 < 32 ? 
                  im1_R * 1/10 + im2_R * 2/10 + im3_R * 4/10 + im4_R *2/10 + im5_R * 1/10 : 0;
assign blur_G = im1_G * 1/10 + im2_G * 2/10 + im3_G * 4/10 + im4_G *2/10 + im5_G * 1/10  < 64 ? 
                  im1_G * 1/10 + im2_G * 2/10 + im3_G * 4/10 + im4_G *2/10 + im5_G * 1/10 : 0;
assign blur_B = im1_B * 1/10 + im2_B * 2/10 + im3_B * 4/10 + im4_B *2/10 + im5_B * 1/10 < 32 ?
                  im1_B * 1/10 + im2_B * 2/10 + im3_B * 4/10 + im4_B *2/10 + im5_B * 1/10 : 0;

assign last_1_edge_R = im2_R * (-1) + im3_R * (-2) + im4_R * 6 + im5_R *(-2) < 32  ? 
                  im2_R * (-1) + im3_R * (-2) + im4_R * 6 + im5_R *(-2) : 0;
assign last_1_edge_G = im2_G * (-1) + im3_G * (-2) + im4_G * 6 + im5_G *(-2) < 64 ? 
                  im2_G * (-1) + im3_G * (-2) + im4_G * 6 + im5_G *(-2) : 0;
assign last_1_edge_B = im2_B * (-1) + im3_B * (-2) + im4_B * 6 + im5_B *(-2) < 32  ?
                  im2_B * (-1) + im3_B * (-2) + im4_B * 6 + im5_B *(-2) : 0;
                  
assign last_1_sharp_R = im2_R * (-1) + im3_R * (-2) + im4_R * 7 + im5_R *(-2) < 32 ? 
                  im2_R * (-1) + im3_R * (-2) + im4_R * 7 + im5_R *(-2) : 0;
assign last_1_sharp_G = im2_G * (-1) + im3_G * (-2) + im4_G * 7 + im5_G *(-2) < 64 ? 
                  im2_G * (-1) + im3_G * (-2) + im4_G * 7 + im5_G *(-2) : 0;
assign last_1_sharp_B = im2_B * (-1) + im3_B * (-2) + im4_B * 7 + im5_B *(-2) < 32 ?
                  im2_B * (-1) + im3_B * (-2) + im4_B * 7 + im5_B *(-2) : 0;
                  
assign last_1_blur_R = im2_R * 1/10 + im3_R * 2/10 + im4_R * 4/10 + im5_R *2/10 < 32 ? 
                  im2_R * 1/10 + im3_R * 2/10 + im4_R * 4/10 + im5_R *2/10 : 0;
assign last_1_blur_G = im2_G * 1/10 + im3_G * 2/10 + im4_G * 4/10 + im5_G *2/10 < 64 ? 
                  im2_G * 1/10 + im3_G * 2/10 + im4_G * 4/10 + im5_G *2/10 : 0;
assign last_1_blur_B = im2_B * 1/10 + im3_B * 2/10 + im4_B * 4/10 + im5_B *2/10 < 32 ?
                  im2_B * 1/10 + im3_B * 2/10 + im4_B * 4/10 + im5_B *2/10 : 0;
                  
assign last_2_edge_R = im3_R * (-1) + im4_R * (-2) + im5_R * 6 < 32 ? 
                  im3_R * (-1) + im4_R * (-2) + im5_R * 6 : 0;
assign last_2_edge_G = im3_G * (-1) + im4_G * (-2) + im5_G * 6 < 64 ? 
                  im3_G * (-1) + im4_G * (-2) + im5_G * 6 : 0;
assign last_2_edge_B = im3_B * (-1) + im4_B * (-2) + im5_B * 6 < 32 ?
                  im3_B * (-1) + im4_B * (-2) + im5_B * 6 : 0;
                  
assign last_2_sharp_R = im3_R * (-1) + im4_R * (-2) + im5_R * 7 < 32 ? 
                  im3_R * (-1) + im4_R * (-2) + im5_R * 7 : 0;
assign last_2_sharp_G = im3_G * (-1) + im4_G * (-2) + im5_G * 7 < 64 ? 
                  im3_G * (-1) + im4_G * (-2) + im5_G * 7 : 0;
assign last_2_sharp_B = im3_B * (-1) + im4_B * (-2) + im5_B * 7 < 32 ?
                  im3_B * (-1) + im4_B * (-2) + im5_B * 7 : 0;
                  
assign last_2_blur_R = im3_R * 1/10 + im4_R * 2/10 + im5_R * 4/10 < 32 ? 
                  im3_R * 1/10 + im4_R * 2/10 + im5_R * 4/10 : 0;
assign last_2_blur_G = im3_G * 1/10 + im4_G * 2/10 + im5_G * 4/10 < 64 ? 
                  im3_G * 1/10 + im4_G * 2/10 + im5_G * 4/10 : 0;
assign last_2_blur_B = im3_B * 1/10 + im4_B * 2/10 + im5_B * 4/10 < 32 ?
                  im3_B * 1/10 + im4_B * 2/10 + im5_B * 4/10 : 0;                  
                       
             
always@(negedge resetn or posedge clk)
begin
   if(!resetn)
      Sync <= 0;
   else if(raddr==17'd130599)
      Sync <= 1;
   else if(START == 1 && END == 1 && INIT == 0)
      Sync <= 0;
end

/* handling interrupt and cycle count */
always@(negedge resetn or posedge clk)
begin
   if(!resetn) begin    
      Intr <= 0; 
      cycle <=0;
   end
   /* increase cycle during calculation */
   else if(START == 1 && END == 0 && INIT == 0) begin
      Intr <= 0;
      if(cycle != 32'hFFFFFFFF)
          cycle <= cycle +1;
   end
   /* calculation end & interrupt start condition */
   else if(START == 1 && END == 1 && INIT==0)
      Intr <= 1; 
   /* interrupt end condition */
   else if(INIT == 1) begin
      Intr <= 0;
      cycle <=0;
   end
end

   
/* calculation block */
always@(negedge resetn or posedge clk)
begin
   if(!resetn || ((START==0) && (INIT == 1)))
   begin
      wen <= 0; waddr <=0;  wdata <=0;
      END <= 0; 
      im1_R <= 0; im1_G <= 0; im1_B <= 0;
      im2_R <= 0; im2_G <= 0; im2_B <= 0;
      im3_R <= 0; im3_G <= 0; im3_B <= 0;
      im4_R <= 0; im4_G <= 0; im4_B <= 0;
      im5_R <= 0; im5_G <= 0; im5_B <= 0;
      lastFlag <= 0;
   end
   else if(END == 1)
       wen <= 0;
   else if(START == 1 && END == 0 && Sync == 1)  //start calculation if a mode is changed or start is on
   begin
         im5_R <= rdata[15:11]; im5_G <= rdata[10:5]; im5_B <= rdata[4:0];
         im4_R <= im5_R; im4_G <= im5_G; im4_B <= im5_B;
         im3_R <= im4_R; im3_G <= im4_G; im3_B <= im4_B;
         im2_R <= im3_R; im2_G <= im3_G; im2_B <= im3_B;
         im1_R <= im2_R; im1_G <= im2_G; im1_B <= im2_B;
     
        //store last two cell
         if (raddr == 1 && lastFlag==1) begin
             wdata <= lastcell;
             wen <= 1;
             waddr <= 16'd65279; 
             END <= 1;
             lastFlag <= 0;
          end
     
         else if(raddr[0] == 0 && mode == 2'b00 && (raddr >=3 || lastFlag == 1)) begin
            if(lastFlag)
               waddr <= 16'd65278;
            else 
               waddr <= raddr[16:1]-2;     
            wdata[31:16] <= {edge_R[4:0], edge_G[5:0], edge_B[4:0]};
            wen <= 1;
         end
         else if(raddr[0] == 0 && mode == 2'b01 && (raddr >=3 || lastFlag == 1)) begin
            if(lastFlag)
               waddr <= 16'd65278;
            else 
               waddr <= raddr[16:1]-2;  
            wdata[31:16] <= {sharp_R[4:0], sharp_G[5:0], sharp_B[4:0]};
            wen <= 1;
         end
         else if(raddr[0] == 0 && mode == 2'b10 && (raddr >=3 || lastFlag == 1)) begin
            if(lastFlag)
               waddr <= 16'd65278;
            else 
               waddr <= raddr[16:1]-2;  
            wdata[31:16] <= {blur_R[4:0], blur_G[5:0], blur_B[4:0]};
            wen <= 1;
         end
         else if(raddr[0] == 1 && mode == 2'b00 && raddr >=3) begin
            wdata[15:0] <= {edge_R[4:0], edge_G[5:0], edge_B[4:0]};
            wen <= 0;
         end
         else if(raddr[0] == 1 && mode == 2'b01 && raddr >=3) begin
            wdata[15:0] <= {sharp_R[4:0], sharp_G[5:0], sharp_B[4:0]};
            wen <= 0;
         end
         else if(raddr[0] == 1 && mode == 2'b10 && raddr >=3) begin
            wdata[15:0] <= {blur_R[4:0], blur_G[5:0], blur_B[4:0]};
            wen <= 0;
         end
         if(raddr == 17'd130599)
            lastFlag <= 1;
            
         if(raddr == 17'd0 && lastFlag == 1 && mode == 2'b00 )
            lastcell <= {last_2_edge_R[4:0], last_2_edge_G[5:0], last_2_edge_B[4:0],
                         last_1_edge_R[4:0], last_1_edge_G[5:0], last_1_edge_B[4:0]};
                         
         if(raddr == 17'd0 && lastFlag == 1 && mode == 2'b01) 
            lastcell <= {last_2_sharp_R[4:0], last_2_sharp_G[5:0], last_2_sharp_B[4:0],
                         last_1_sharp_R[4:0], last_1_sharp_G[5:0], last_1_sharp_B[4:0]};

         if(raddr == 17'd0 && lastFlag == 1 && mode == 2'b10) 
            lastcell <= {last_2_blur_R[4:0], last_2_blur_G[5:0], last_2_blur_B[4:0],
                         last_1_blur_R[4:0], last_1_blur_G[5:0], last_1_blur_B[4:0]};
         
    end
end   


endmodule
