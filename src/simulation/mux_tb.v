`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/17/2019 03:49:09 PM
// Design Name: 
// Module Name: mux_tb
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


module mux_tb();
reg [31:0]a;
reg [31:0]b;
reg sel;
wire [31:0]out;
multiplexer mtb(a,b,sel,out);


initial begin
a=32'h0000ffff;
b=32'haaaa0000;

sel=1;
#100

sel=0;







end
endmodule
