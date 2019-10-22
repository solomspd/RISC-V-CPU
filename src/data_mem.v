`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/01/2019 02:35:50 PM
// Design Name: 
// Module Name: data_mem
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


module DataMem (input clk, input MemRead, input MemWrite, input [5:0] addr, input [31:0] data_in, output [31:0] data_out);

    reg [31:0] mem [0:63];
     
    always @(posedge clk) begin
        if (MemWrite & ~MemRead)
            mem[addr] <= data_in;
    end

    assign data_out = MemRead & ~MemWrite ? mem[addr]:0;
    
    initial begin
        mem[0]=32'd1;
        mem[1]=32'd256;
    end
    
endmodule

