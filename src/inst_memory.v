`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/01/2019 02:22:39 PM
// Design Name: 
// Module Name: inst_memory
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


module InstMem (input [5:0] addr, output [31:0] data_out);
    reg [7:0] mem [(4*1024-1):0];
    
     assign data_out = {mem[addr+3], mem[addr+2], mem[addr+1], mem[addr]};    
    initial begin

        $readmemh("C:/Users/solomspd/project_1/rarspls.mem", mem);  
        //    end
    end

endmodule

