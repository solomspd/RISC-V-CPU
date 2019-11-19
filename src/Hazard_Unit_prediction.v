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
input [4:0] inst_rs1,inst_rs2,IF_ID_RegisterRd,
input branch,
output reg stall
    );
    always@(*)
    begin
    if (( (inst_rs1==IF_ID_RegisterRd) || (inst_rs2==IF_ID_RegisterRd))  && (IF_ID_RegisterRd != 0)&& (branch))
    stall = 1;
    else 
    stall = 0; 
    end 
    
endmodule
