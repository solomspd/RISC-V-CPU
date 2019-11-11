`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/05/2019 05:05:31 PM
// Design Name: 
// Module Name: Forward_Unit
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


module Forward_Unit(
input EX_MEM_RegWrite, MEM_WB_RegWrite,
input [4:0 ]EX_MEM_RegisterRd, ID_EX_RegisterRs1,ID_EX_RegisterRs2,MEM_WB_RegisterRd,
output reg [1:0] forwardA, forwardB
    );
    
 always @(*) 
 begin
 if ( EX_MEM_RegWrite && (EX_MEM_RegisterRd != 0) && (EX_MEM_RegisterRd == ID_EX_RegisterRs1) )
 forwardA = 2'b10;
 
 else if (( EX_MEM_RegWrite & (MEM_WB_RegisterRd != 0) & (MEM_WB_RegisterRd == ID_EX_RegisterRs1) )&  !( EX_MEM_RegWrite & (EX_MEM_RegisterRd != 0) & (EX_MEM_RegisterRd == ID_EX_RegisterRs1)))
 forwardA = 2'b01;
 
 else if ( EX_MEM_RegWrite & (EX_MEM_RegisterRd != 0) & (EX_MEM_RegisterRd == ID_EX_RegisterRs2) )
 forwardB = 2'b10;
 
 else if (
 ( MEM_WB_RegWrite & (MEM_WB_RegisterRd != 0) & (MEM_WB_RegisterRd == ID_EX_RegisterRs2) )
 & !( MEM_WB_RegWrite & (EX_MEM_RegisterRd != 0) & (EX_MEM_RegisterRd == ID_EX_RegisterRs2)))
 forwardB = 2'b01;
 
 else begin 
forwardA = 2'b00;
forwardB = 2'b00;
 end 
 
 end   
    
    
    
    
    
endmodule
