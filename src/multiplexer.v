`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/17/2019 03:24:07 PM
// Design Name: 
// Module Name: multiplexer
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


module multiplexer(input [31:0]a, input [31:0]b, input sel, output [31:0]out);

    genvar i;
    generate
        for (i = 0; i < 32; i = i + 1) begin
            mux muxest(a[i], b[i], sel, out[i]);
        end
    endgenerate
endmodule
