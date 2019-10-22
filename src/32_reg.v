`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/17/2019 03:11:55 PM
// Design Name: 
// Module Name: 32_reg
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


module register(input clk, input [31:0]in, input rst, input load, output [31:0]out);
    
    wire [31:0]muxer;
    genvar i;
    generate
        for (i = 0; i < 32; i = i + 1) begin
            DFlipFlop flip(clk, rst, muxer[i], out[i]);
            mux muxie(out[i], in[i], load, muxer[i]);
        end 
    endgenerate
endmodule
