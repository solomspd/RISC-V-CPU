`include "defines.v"

/*******************************************************************
*
* Module: control_unit.v
* Project: RISC-V FPGA Implementation and Testing 
* Author: 
* Ahmed Ibrahim  ahmeddibrahim@aucegypt.edu
* Abd El-Salam   solomspd@aucegypt.edu
* Andrew Kamal   andrewk.kamal@aucegypt.edu
* Rinal Mohamed  rinalmohamed@aucegypt.edu
* Description: This module was created to cascade control signals *to all of the other units in the data path to instruct them how *they will behave in all of the instructions 
*
* Change history: 24/10/2019 - Module created and adapted it to *required modules
*26/10/2019 - control unit updated according to the new *instructions that were added
*27/10/2019 - control unit updated for other new instructions

**********************************************************************/


module control_unit(input [4:0]inst, output reg branch, memRead, memtoReg, memWrite, ALUSrc, RegWrite, sys, output reg [1:0]ALUOp,rd_sel, output reg pc_gen_sel);

always @(*) begin
    case(inst) 
        
        
        `OPCODE_Arith_R: begin // ASSUMING THAT MUL IS ALSO AN R INSTRUCTION
            branch=0;
            memRead=0;
            memtoReg=0;
            ALUOp=2'b10;
            memWrite=0;
            ALUSrc=0;
            RegWrite=1;
            pc_gen_sel=0;
            rd_sel=2'b00;
            sys=0;
            end
        `OPCODE_Load: begin
            branch=0;
            memRead=1;
            memtoReg=1;
            ALUOp=2'b00;
            memWrite=0;
            ALUSrc=1;
            RegWrite=1;
            pc_gen_sel=0;
            rd_sel=2'b00;
            sys=0;
            end
        `OPCODE_Store: begin
            branch=0;
            memRead=0;
            ALUOp=2'b00;
            memWrite=1;
            ALUSrc=1;
            RegWrite=0;
            pc_gen_sel=0;
            memtoReg=1;
            rd_sel=2'b00;
            sys=0;
            end 
        `OPCODE_Branch: begin
            branch=1;
            memRead=0;
            memtoReg=0;
            ALUOp=2'b01;
            memWrite=0;
            ALUSrc=0;
            RegWrite=1;
            pc_gen_sel=0;
            rd_sel=2'b00;
            sys=0;
            end

        `OPCODE_Arith_I: begin
            branch=0;
            memRead=0;
            ALUOp=2'b11;
            memWrite=0;
            ALUSrc=1;
            RegWrite=1;
            pc_gen_sel=0;
            memtoReg=0;
            rd_sel=2'b00;
            sys=0;
            end
            
        `OPCODE_JALR: begin
                branch=0;
                memRead=0;
                ALUOp=2'b00;
                memWrite=0;
                ALUSrc=0;
                RegWrite=1;
                pc_gen_sel=1;
                memtoReg=0;
                rd_sel=2'b10;
                sys=0;
                end 
        `OPCODE_JAL: begin
                branch=0;
                memRead=0;
                ALUOp=2'b00;
                memWrite=0;
                ALUSrc=0;
                RegWrite=1;
                pc_gen_sel=0;
                memtoReg=0;
                rd_sel=2'b10;
                sys=0;
                end
        `OPCODE_AUIPC: begin
                branch=0;
                memRead=0;
                ALUOp=2'b00;
                memWrite=0;
                ALUSrc=0;
                RegWrite=1;
                pc_gen_sel=0;
                memtoReg=0;
                rd_sel=2'b01;
                sys=0;
                end           
        `OPCODE_LUI: begin
                branch=0;
                memRead=0;
                ALUOp=2'b00;
                memWrite=0;
                ALUSrc=0;
                RegWrite=1;
                pc_gen_sel=0;
                memtoReg=0;
                rd_sel=2'b11;
                sys=0;
                end 

        `OPCODE_SYSTEM: begin
                branch=0;
                memRead=0;
                ALUOp=2'b00;
                memWrite=0;
                ALUSrc=0;
                RegWrite=0;
                pc_gen_sel=0;
                memtoReg=0;
                rd_sel=2'b00;
                sys=1;
                end
    
         default: begin 
            branch = 0;
            memRead = 0;
            ALUOp=2'b01;
            memWrite=0;
            ALUSrc=0;
            RegWrite=0;
            memtoReg=0;
            pc_gen_sel=0;
            end
                                             
    endcase
end
endmodule