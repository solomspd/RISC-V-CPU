`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/29/2019 04:37:11 PM
// Design Name: 
// Module Name: alu_op_tb
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


                                                                                module alu_op_tb();
reg [1:0]x;
reg [2:0]y;
reg z;
wire [3:0]result;
ALU_op alu(x,y,z,result); 
initial begin
x=2'b00;
y=3'b001;
z=1'b0;
#100
x=2'b01;
y=3'b110;
z=1'b1;
#100
x=2'b10;
y=3'b110;
z=1'b0;
#100
x=2'b10;
y=3'b000;
z=1'b0;
#100
x=2'b10;
y=3'b000;
z=1'b1;
#100
x=2'b10;
y=3'b111;
z=1'b0;






end
endmodule
