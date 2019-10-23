`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/17/2019 04:31:45 PM
// Design Name: 
// Module Name: imm_tb
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


module imm_tb();

reg [31:0]in;
wire [31:0]out;

imm_gen iggy(in, out);

initial begin
    in = 32'h4D62A303;
    #100;
    in = 32'hDCA7AF23;
    #100
    in = 32'h18E18F63;
end
endmodule
