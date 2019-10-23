`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/17/2019 03:38:57 PM
// Design Name: 
// Module Name: reg_tb
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


module muxer_tb();

reg rst,clk,load;
reg [31:0]in;
wire [31:0]out;

register tb(clk,in,rst,load,out);

always begin #10 clk=~clk; end

initial begin
rst = 1;
load = 0;
#10
rst = 1;
clk = 0;

load = 1;
rst = 0;
in = 32'h00000000;
#100


load = 1;
rst = 1;
in = 32'hFFFFFFFF;
#100


load = 1;
rst = 0;
in = 32'hFFFFFFFF;
#100


load = 0;
rst = 0;
in = 32'h00001111;



end
endmodule

