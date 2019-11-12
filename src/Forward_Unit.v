`timescale 1ns / 1ps
/*******************************************************************

*

* Module: shifter.v

* Project: RISC-V FPGA Implementation and Testing 

* Author: 

* Ahmed Ibrahim  ahmeddibrahim@aucegypt.edu

* Abd El-Salam   solomspd@aucegypt.edu

* Andrew Kamal   andrewk.kamal@aucegypt.edu

* Rinal Mohamed  rinalmohamed@aucegypt.edu

* Description: This module is just a forwarding unit that is responsible for handling data hazards.

* Change history: 10/11/2019 module added to the project 
*
**********************************************************************/


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
