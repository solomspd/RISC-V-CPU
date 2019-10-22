`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/24/2019 01:43:37 PM
// Design Name: 
// Module Name: reger
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


module RegFile (
input clk, rst, input [4:0] readreg1, readreg2, writereg, input [31:0] writedata, input regwrite, output [31:0] readdata1, readdata2 );

    wire [31:0]load;
    wire [31:0]out[0:31];
    
    genvar i;
    generate
        for (i = 0; i < 32; i = i + 1) begin
            register regriar(clk, writedata, rst, load[i], out[i]);
        end
    endgenerate
    
    assign readdata1 = readreg1 != 5'b0 ? out[readreg1] : 5'b0;
    assign readdata2 = readreg2 != 5'b0 ? out[readreg2] : 5'b0;
        
    assign load = regwrite ? 1'b1 << writereg : 0;
    
endmodule

