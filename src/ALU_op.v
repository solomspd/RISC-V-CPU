`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/29/2019 04:25:18 PM
// Design Name: 
// Module Name: ALU_op
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

`include "defines.v"
module ALU_op(input [1:0]op_in, input [2:0]inst_1, input inst_2, output reg [3:0]op_out);

always @(*) begin
    
    case (op_in)
        2'b00: op_out = `ALU_ADD;
        2'b01: op_out = `ALU_SUB;
        // R Format 
        2'b10: case (inst_1)
            // if intruction30 ==1 ALU_SUB else ALU_ADD
            `F3_ADD: op_out = inst_2 ? `ALU_SUB : `ALU_ADD;
            
            `F3_AND: op_out =  `ALU_AND; 
            
            `F3_OR: op_out =  `ALU_OR; 
            
            `F3_XOR: op_out= `ALU_XOR;
            // if instruction30==1 ALU_SRA else ALU_SRL
            `F3_SRL: op_out = ints_2?`ALU_SRA:`ALU_SRL;

            `F3_SLL: op_out= `ALU_SLL;

            `F3_SLT: op_out= `ALU_SLT;

            `F3_STLU:op_out= `ALU_SLTU;
		
		endcase
            
 	  2'b11: case (inst_1)
		 `F3_ADD: op_out = `ALU_ADD;
            
            `F3_AND: op_out =  `ALU_AND; 
            
            `F3_OR: op_out =  `ALU_OR; 
            
            `F3_XOR: op_out= `ALU_XOR;
            // if instruction30==1 ALU_SRA else ALU_SRL
            `F3_SRL: op_out = ints_2?`ALU_SRA:`ALU_SRL;

            `F3_SLL: op_out= `ALU_SLL;

            `F3_SLT: op_out= `ALU_SLT;

            `F3_STLU:op_out= `ALU_SLTU;


            default: op_out = `ALU_PASS; //error
        endcase
        default: op_out = `ALU_PASS; //error
    endcase
end
endmodule
