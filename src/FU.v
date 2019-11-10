`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/31/2019 04:52:32 PM
// Design Name: 
// Module Name: FU
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


module FU(input [4:0]rs1,input [4:0]rs2,input [4:0]rdMEM, input [4:0]rdWB,input RWMEM,input RWWB,output reg [1:0]rs1s, output reg [1:0]rs2s);
always @(*)
begin

if(((RWMEM==1)&&(rdMEM!=0))&&((rdMEM==rs1)))
rs1s = 2'b10;
else if (((RWWB==1)&&(rdWB!=0))&&((rdWB==rs1)))
rs1s = 2'b01;
else
rs1s = 2'b00;


if(((RWMEM)&&(rdMEM!=0))&&((rdMEM==rs2)))
rs2s = 2'b10;
else if(((RWWB)&&(rdWB!=0))&&((rdWB==rs2)))
rs2s = 2'b01;
else
rs2s = 2'b00;
end

endmodule
