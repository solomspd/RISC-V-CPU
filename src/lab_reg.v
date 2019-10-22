`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/23/2019 05:21:02 PM
// Design Name: 
// Module Name: lab_reg
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


module lab_reg #(parameter n = 8) (input clk, input [n:0]in, input rst, input load, input shift, output [n:0]outer);
    wire [n:0]muxer;
    wire [n:0]out;
    genvar i;
    generate
    for (i = 0; i < n; i = i + 1) begin
        DFlipFlop flip(clk, rst, muxer[i], out[i]);
        mux muxie(in[i], out[i], load, muxer[i]);
    end
    endgenerate
    
    assign outer = (shift & ~load) ? {out[n-1:1],1'b0} : out;
    
endmodule
