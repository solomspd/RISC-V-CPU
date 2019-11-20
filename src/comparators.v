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


module comparators(input [2:0]func3,input branch,
input [31:0] inputA, inputB, output reg flag
    );
    always@(*) begin
        if(branch)
        begin
             case (func3 )
               `BR_BEQ: flag = $signed(inputA)==$signed(inputB);
               `BR_BNE: flag = $signed(inputA)!=$signed(inputB);
               `BR_BLT: flag = $signed(inputA)<$signed(inputB);
               `BR_BGE: flag = $signed(inputA)>=$signed(inputB);
               `BR_BLTU: flag = inputA < inputB;
               `BR_BGEU: flag = inputA >= inputB;
               default: flag = 1'b0;
              endcase
          end else begin
            flag = 0;
          end
      end
endmodule
