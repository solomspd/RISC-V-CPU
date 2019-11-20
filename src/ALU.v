`timescale 1ns / 1ps
/*******************************************************************
*
* Module: ALU.v
* Project: RISC-V FPGA Implementation and Testing 
* Author: 
* Ahmed Ibrahim  ahmeddibrahim@aucegypt.edu
* Abd El-Salam   solomspd@aucegypt.edu
* Andrew Kamal   andrewk.kamal@aucegypt.edu
* Rinal Mohamed  rinalmohamed@aucegypt.edu
* Description: This module creates the ALU that will handle all *the executions that need to be processed in the processor just *as add, sub, xor, or any other operation that needs handling. *This module is responsible for all the operations 
*
* Change history: 09/17/2019 03:07:59 PM - Module created by Abd *El-Salam in the lab
* 25/10/2019 - Module modified accodring to the defines that were *uploaded by the professor. 
* All the operations were added and handled accordingly in the *ALU control unit

**********************************************************************/

`include "defines.v"
module prv32_ALU(
	input   wire [31:0] a, b,
	input   wire [4:0]  shamt,
	output  reg  [31:0] r,
	output  wire        cf, zf, vf, sf,
	input   wire [4:0]  alufn
);

    wire [31:0] add, sub, op_b;
    wire cfa, cfs;
    
    assign op_b = (~b);
    
    assign {cf, add} = alufn[0] ? (a + op_b + 1'b1) : (a + b);
    
    assign zf = (add == 0);
    assign sf = add[31];
    assign vf = (a[31] ^ (op_b[31]) ^ add[31] ^ cf);
    
    wire[31:0] sh;
    shifter shifter0(a, shamt, alufn[1:0], sh);
    reg[63:0]m,ms,msu;
//    assign m = a*b; // unsigned
//    assign ms= ;
//assign msu= $signed(a)* b;
    always @ * begin
        r = 0;
        (* parallel_case *)
        case (alufn)
            // arithmetic
            `ALU_ADD: r = add;
            `ALU_SUB : r = add;
            `ALU_SUB : r = add;
            `ALU_PASS : r = b;
            // logic
            `ALU_OR:  r = a | b;
            `ALU_AND:  r = a & b;
            `ALU_XOR:  r = a ^ b;
            // shift
            `ALU_SRL:  r=sh;
            `ALU_SLL:  r=sh;
            `ALU_SRA:  r=sh;
            // slt & sltu
            `ALU_SLT:  r = {31'b0,(sf != vf)}; 
            `ALU_SLTU:  r = {31'b0,(~cf)};  
            
            
            `ALU_MUL :  
            begin
                 ms=$signed(a) *$signed(b);
                r=ms[31:0]; // signed mul
             end
            `ALU_MULHU:
             begin
                 m = a*b;
                 r=m[63:32];// unsigned
              end
            `ALU_MULH:  
            begin
                 ms=$signed(a) *$signed(b);
                r=ms[63:32];// high signed
             end
            `ALU_MULHSU: 
            begin
                msu= $signed(a)* b; 
                r=msu[63:32];// signed and unsigned
            end
            
            `ALU_DIV:
            begin 
            if(b!=0)
            r= $signed(a)/$signed(b);// signed div
            end
            `ALU_DIVU:
             begin 
               if(b!=0)
                r= a/b;// unsigned div
               end
           
            `ALU_REM: r= $signed(a)%$signed(b);// signed rem
            `ALU_REMU:r= a%b;// unsigned div
            default: r = 32'b0;
        endcase
    end
endmodule
