`timescale 1ns / 1ps
/*******************************************************************
*
* Module: ALU_op.v
* Project: RISC-V FPGA Implementation and Testing 
* Author: 
* Ahmed Ibrahim  ahmeddibrahim@aucegypt.edu
* Abd El-Salam   solomspd@aucegypt.edu
* Andrew Kamal   andrewk.kamal@aucegypt.edu
* Rinal Mohamed  rinalmohamed@aucegypt.edu
* Description: This module was created to control the ALU module *by basically giving a code to each operation that will later be *passed to the ALU to handle the operation accordingly
*
* Change history: 09/17/2019 03:07:59 PM - Module created by Abd *El-Salam in the lab
*25/10/2019 - Module modified to abide by the defines that were *uploaded to the project
*All the operations were given a code that will be used in the *ALU
**********************************************************************/

`include "defines.v"
module ALU_op(input [1:0]op_in,input ID_Ex_Func25,input [2:0]inst_1, input inst_2, output reg [4:0]op_out);

always @(*) begin
    
    case (op_in)
        2'b00:
           op_out = `ALU_ADD;
         
        2'b01: op_out = `ALU_SUB;
        
        // R Format 
        2'b10: 
         if(ID_Ex_Func25==1'b1)
                    begin
                    case(inst_1)
                      `F3_MUL: op_out= `ALU_MUL;
                      `F3_MULH:op_out= `ALU_MULH;
                      `F3_MULHSU:op_out= `ALU_MULHSU;
                      `F3_MULHU:op_out= `ALU_MULHU;
                      `F3_DIV :op_out= `ALU_DIV;
                      `F3_DIVU:op_out= `ALU_DIVU;
                      `F3_REM: op_out= `ALU_REM;
                      `F3_REMU:op_out= `ALU_REMU;
                      default: op_out= 32'b0;
                      endcase
                      end
                      
                   else
        case (inst_1)
            // if intruction30 ==1 ALU_SUB else ALU_ADD
            `F3_ADD: op_out = inst_2 ? `ALU_SUB : `ALU_ADD;
            
            `F3_AND: op_out =  `ALU_AND; 
            
            `F3_OR: op_out =  `ALU_OR; 
            
            `F3_XOR: op_out= `ALU_XOR;
            // if instruction30==1 ALU_SRA else ALU_SRL
            `F3_SRL: op_out = inst_2?`ALU_SRA:`ALU_SRL;

            `F3_SLL: op_out= `ALU_SLL;

            `F3_SLT: op_out= `ALU_SLT;

            `F3_SLTU:op_out= `ALU_SLTU;
		    default: op_out= 32'b0;
		endcase
            
 	  2'b11: 
 	  
 	  case (inst_1)
		    `F3_ADD: op_out = `ALU_ADD;
            
            `F3_AND: op_out =  `ALU_AND; 
            
            `F3_OR: op_out =  `ALU_OR; 
            
            `F3_XOR: op_out= `ALU_XOR;
            // if instruction30==1 ALU_SRA else ALU_SRL
            `F3_SRL: op_out = inst_2?`ALU_SRA:`ALU_SRL;

            `F3_SLL: op_out= `ALU_SLL;

            `F3_SLT: op_out= `ALU_SLT;

            `F3_SLTU:op_out= `ALU_SLTU;


            default: op_out = `ALU_PASS; //error
        endcase
        default: op_out = `ALU_PASS; //error
    endcase
end
endmodule
