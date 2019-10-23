`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/29/2019 05:00:50 PM
// Design Name: 
// Module Name: control_tb
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


module control_tb();
reg [4:0]in;
wire br,memR,memTR,MW,Src,RW;
wire [1:0]ALUOp;
control_unit cu(in, br, memR, memTR, MW, Src, RW, ALUOp);
initial begin 

in= 5'b01100;
#100
in= 5'b00000;
#100
in= 5'b01000;
#100
in= 5'b11000;






end
endmodule
