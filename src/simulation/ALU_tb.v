`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/24/2019 03:55:45 PM
// Design Name: 
// Module Name: ALU_tb
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


module ALU_tb();


reg [31:0]a;
reg [31:0]b;
reg [3:0]sel;
wire [31:0]r;
wire z;
 
ALU32bit alu(a,b,sel,r,z);

initial begin
a=2;
b=2;
sel=4'b0010;
#50

a=4'b1010;
b=4'b0101;
sel=4'b0000;
#50

a=100;
b=55;
sel=4'b0110;
#50
a=100;
b=55;
sel=4'b0001;
#50
a=10;
b=5;
sel=4'b0001;





end
endmodule
