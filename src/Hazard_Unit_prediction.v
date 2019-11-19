`timescale 1ns / 1ps
 `include "defines.v"
//`include "defines.v"

//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/05/2019 06:14:03 PM
// Design Name: 
// Module Name: Hazard_Unit
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


module Hazard_Unit_prediction(
input [4:0] IF_ID_RegisterRs1,ID_EX_RegisterRd,IF_ID_RegisterRs2,
input [31:0]IF_ID_Inst,
input ID_EX_MemRead,
output reg stall
    );
    always@(*)
    begin
    if (((IF_ID_RegisterRs1==ID_EX_RegisterRd) || (IF_ID_RegisterRs2==ID_EX_RegisterRd)) && ID_EX_MemRead && (ID_EX_RegisterRd != 0)&& (IF_ID_Inst[4:0]==`OPCODE_Branch))
    stall = 1;
    else 
    stall = 0; 
    end 
    
endmodule
