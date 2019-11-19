`timescale 1ns / 1ps
`include"defines.v"
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/19/2019 12:47:43 AM
// Design Name: 
// Module Name: comparators
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


module comparators(input [2:0]func3,
input [31:0] inputA, inputB, output reg flag
    );
    always@(*)
    begin
     case (func3 )
           `BR_BEQ:
           begin
                if($signed(inputA)==$signed(inputB)) 
                     flag=1;
                 else 
                      flag=0;
            end
           
           `BR_BNE:
           begin
                if($signed(inputA)!=$signed(inputB)) 
                    flag=1;
                else 
                    flag=0;
            end

           `BR_BLT:
           begin
                if($signed(inputA)<$signed(inputB)) 
                    flag=1;
                else 
                    flag=0;
            end
            
           `BR_BGE:
            begin
                 if($signed(inputA)<=$signed(inputB)) 
                     flag=1;
                 else 
                     flag=0;
             end

           `BR_BLTU:
            begin
                 if(inputA<inputB) 
                     flag=1;
                 else 
                     flag=0;
             end
 
           `BR_BGEU:
              begin
                   if(inputAinputB) 
                       flag=1;
                   else 
                       flag=0;
               end
               
             

    endcase
      end
endmodule
