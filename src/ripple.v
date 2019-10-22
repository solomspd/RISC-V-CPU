`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/10/2019 02:40:36 PM
// Design Name: 
// Module Name: ripple
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

module ripple#(parameter n = 31)(input [n:0]a, input [n:0]b, output [n:0]out, output cout);
    wire [n+1:0]carry;
    genvar i;
    assign carry[0] = 0;
    generate
        for (i = 0; i < n+1; i = i + 1) begin
            FA adder(a[i], b[i], carry[i], out[i], carry[i+1]);
        end 
    endgenerate
    assign cout = carry[n+1];
endmodule
