`timescale 1ns / 1ps
/*******************************************************************
*
* Module: register.v
* Project: RISC-V FPGA Implementation and Testing 
* Author: 
* Ahmed Ibrahim  ahmeddibrahim@aucegypt.edu
* Abd El-Salam   solomspd@aucegypt.edu
* Andrew Kamal   andrewk.kamal@aucegypt.edu
* Rinal Mohamed  rinalmohamed@aucegypt.edu
* Description: This module is the core of our implememntaion is it the "top" module that conects everything together
*
* Change history: 09/17/2019 03:07:59 PM - Module created by Abd *El-Salam in the lab
* 17/9/19 - created by Abdelsalam in the lab
* 31/9/19 - adapted datapath to ALU and immediate modules provided by project material. Elaborated and implemented shift module as outlined in provided ALU
* 32/9/19 - fixed zero flag. anded and fixe brnch module
* 26/10/19 - modified control signals according to new control signals.
* 28/10/19 - polish. added jump muxes. lots of bug fixes.
* 29/10/19 - added muxes for break and call. bug fixes.
* 8/11/2019 - implemented the pipelined data path
* 10/11/2019- Tested the pipelined data path and added the *forwarding unit and modified the data path accordingly
* 11/11/2019- Added the unified single ported memory and tested it. Also, tested the whole module
**********************************************************************/
`include "defines.v"
module data_path(input clk, input rst, output [31:0]inst_out_ext, output branch_ext, mem_read_ext, mem_to_reg_ext, mem_write_ext, alu_src_ext, reg_write_ext,
 output [1:0]alu_op_ext, output z_flag_ext, output [4:0]alu_ctrl_out_ext, output [31:0]PC_inc_ext, output [31:0]pc_gen_out_ext, output [31:0]PC_ext, output [31:0]PC_in_ext,
 output [31:0]data_read_1_ext, output [31:0]data_read_2_ext, output [31:0]write_data_ext, output [31:0]imm_out_ext, output [31:0]shift_ext, output [31:0]alu_mux_ext
 ,output [31:0]alu_out_ext, output [31:0]data_mem_out_ext);
 
    wire neg_clk = ~clk;

    wire [31:0] jump_mux; 
    wire [31:0]PC;
    wire [31:0]new_PC_in;
    wire [31:0]final_pc;
    wire [31:0]PC_in;
    wire [31:0]inst_out;
    wire can_branch, mem_read, mem_to_reg, mem_write, alu_src, reg_write, pc_gen_sel, sys;
    wire [1:0]alu_op, rd_sel;
    wire [31:0]write_data;
    wire [31:0]read_data_1;
    wire [31:0]imm_out;
    wire [31:0]read_data_2;
    wire carry_flag, zero_flag, over_flag, sign_flag;
    wire [31:0]alu_mux_out;
    wire [4:0] alu_ctrl_out;
    wire [31:0]alu_out;
    wire should_branch;
    wire [31:0]data_mem_out;
    wire [31:0]pc_gen_out;
    wire dummy_carry;
    wire [31:0]pc_gen_in;
    wire [31:0]pc_inc_out;
    wire dummy_carry_2;
	wire [1:0] forwardA, forwardB;
	wire [31:0] inputA, inputB; 
	wire stall ;

    
    
    
// wires declarations for the pipelined implementation 
    wire [31:0] IF_ID_PC, IF_ID_Inst;
  //                                                                                                                                                                                                                                                                                                       ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff                                            fffffffffff                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttdddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd                                                                                                       assign select_instruction= (stall)? 32'h33000000:inst_out;

// IF-ID register initialization
    register #(64) IF_ID (clk,
    {PC,
    inst_out},
    rst,
    ~stall,
    {IF_ID_PC,
    IF_ID_Inst} );
    // wires declarations for the pipelined implementation 
    wire [31:0] ID_EX_PC, ID_EX_RegR1, ID_EX_RegR2, ID_EX_Imm;
    wire ID_EX_can_branch, ID_EX_mem_read, ID_EX_mem_to_reg, ID_EX_mem_write, ID_EX_alu_src, ID_EX_reg_write, ID_EX_pc_gen_sel, ID_EX_sys;
    wire [1:0] ID_EX_alu_op, ID_EX_rd_sel; 
    wire [3:0] ID_EX_Func;
    wire [4:0] ID_EX_Rs1, ID_EX_Rs2, ID_EX_Rd;
    wire ID_Ex_Func25;
    register #(160) ID_EX (neg_clk,
    {reg_write,
    mem_to_reg,
    can_branch,
    mem_read,
    mem_write,
    alu_op,
    alu_src,
    pc_gen_sel,
    sys,
    rd_sel,
    IF_ID_PC,
    read_data_1,
    read_data_2,
    imm_out,
    IF_ID_Inst[25],
    IF_ID_Inst[30],
    IF_ID_Inst[`IR_funct3],
    IF_ID_Inst[`IR_rs1],
    IF_ID_Inst[`IR_rs2],
    IF_ID_Inst[`IR_rd]}, 
    rst,
    1'b1,                                                                                                           
    {ID_EX_reg_write,
    ID_EX_mem_to_reg,
    ID_EX_can_branch,
    ID_EX_mem_read,
    ID_EX_mem_write,
    ID_EX_alu_op,
    ID_EX_alu_src,
    ID_EX_pc_gen_sel,
    ID_EX_sys,
    ID_EX_rd_sel,
    ID_EX_PC,
    ID_EX_RegR1,
    ID_EX_RegR2,
    ID_EX_Imm,
    ID_Ex_Func25,
    ID_EX_Func,
    ID_EX_Rs1,
    ID_EX_Rs2,
    ID_EX_Rd});

    wire [31:0] EX_MEM_BranchAddOut, EX_MEM_ALU_out, EX_MEM_RegR2;
    wire EX_MEM_reg_write, EX_MEM_mem_to_reg, EX_MEM_can_branch, EX_MEM_mem_read, EX_MEM_mem_write, EX_MEM_pc_gen_sel, EX_MEM_sys;
    wire [4:0] EX_MEM_Rd;
    wire [3:0] EX_MEM_branch;
    wire [2:0]EX_MEM_func;
    register #(115) EX_MEM (clk,
    {
    ID_EX_reg_write,
    ID_EX_mem_to_reg,
    ID_EX_can_branch,
    ID_EX_mem_read,
    ID_EX_mem_write,
    ID_EX_pc_gen_sel,
    ID_EX_sys,
    pc_gen_out,
    carry_flag,
    zero_flag,
    over_flag,
    sign_flag,
    jump_mux,
    ID_EX_Func[2:0],
    ID_EX_RegR2,
    ID_EX_Rd
    },
    rst,
    1'b1,
    {
     EX_MEM_reg_write,
     EX_MEM_mem_to_reg,
     EX_MEM_can_branch,
     EX_MEM_mem_read,
     EX_MEM_mem_write,
     EX_MEM_pc_gen_sel,
     EX_MEM_sys,
     EX_MEM_BranchAddOut,   //pb
     EX_MEM_branch,
     EX_MEM_ALU_out,
     EX_MEM_func,
     EX_MEM_RegR2,
     EX_MEM_Rd}
       );
       
    wire [31:0] MEM_WB_Mem_out, MEM_WB_ALU_out;
    wire MEM_WB_reg_write, MEM_WB_mem_to_reg, MEM_WB_sys;
    wire [4:0] MEM_WB_Rd;
    
    register #(72) MEM_WB (neg_clk,
    {
    EX_MEM_reg_write,
    EX_MEM_mem_to_reg,
    EX_MEM_sys,
    data_mem_out,
    EX_MEM_ALU_out,
    EX_MEM_Rd
    },
    rst,
    1'b1,
    {
    MEM_WB_reg_write,
    MEM_WB_mem_to_reg,
    MEM_WB_sys,   
    MEM_WB_Mem_out,
    MEM_WB_ALU_out,
    MEM_WB_Rd} );


    assign PC_ext = PC;
    
    assign PC_in_ext = PC_in;
    register#(32)program_counter (neg_clk, final_pc, rst, ~stall, PC);
    
    
    wire [31:0]mem_addr;
    wire final_mem_read;
    wire final_mem_write;
    wire [2:0]final_mem_func;
    assign mem_addr = ~clk ? PC : EX_MEM_ALU_out + 6'd48;
    assign final_mem_read = ~clk ? 1'b1 : EX_MEM_mem_read;
    assign final_mem_write = ~clk ? 1'b0 : EX_MEM_mem_write;    
    assign final_mem_func = ~clk ? 3'b010 : EX_MEM_func;
    
    assign inst_out_ext = inst_out;
    wire [31:0]mem_out;
    wire [31:0]mem_inst_out;
    DataMem inst_mem (~clk, final_mem_read, final_mem_write, mem_addr, final_mem_func, EX_MEM_RegR2, mem_out);
    assign mem_inst_out = ~clk & ~stall ? mem_out : 32'h00_00_00_33;
    assign data_mem_out = ~clk ? mem_out : 1'b1;
    
    wire [31:0]decompressed;
    compressed decompressor (mem_inst_out, decompressed);
    assign inst_out = mem_inst_out[1:0] == 2'b11 ? mem_inst_out : decompressed; 
    
    assign branch_ext = can_branch;
    assign mem_read_ext = mem_read;
    assign mem_to_reg_ext = mem_to_reg;
    assign mem_write_ext = mem_write; 
    assign alu_src_ext = alu_src;
    assign reg_write_ext = reg_write;
    
    assign alu_op_ext = alu_op;
   
    control_unit controlUnit (IF_ID_Inst[6:2], can_branch, mem_read, mem_to_reg, mem_write, alu_src, reg_write,sys, alu_op, rd_sel, pc_gen_sel);
     
//    module Hazard_Unit_prediction(
//    input [4:0] IF_ID_RegisterRs1,ID_EX_RegisterRd,IF_ID_RegisterRs2,
//    input [31:0]IF_ID_Inst,
//    input ID_EX_MemRead,
//    output reg stall
//        );

    Hazard_Unit_prediction hazard_detection(IF_ID_Inst[`IR_rs1], IF_ID_Inst[`IR_rs2],ID_EX_Rd,can_branch,stall   );
    assign write_data_ext = write_data;
    assign data_read_1_ext = read_data_1;
       
    assign data_read_2_ext = read_data_2;
    RegFile reg_file (clk, rst, IF_ID_Inst[`IR_rs1],IF_ID_Inst[`IR_rs2], MEM_WB_Rd,
    write_data, MEM_WB_reg_write, read_data_1, read_data_2);
    wire flag_comp;
    
//    comparators(input [2:0]func3,lmar
//   input [31:0] inputA, inputB, output reg flag
//       );
    comparators comp(IF_ID_Inst[`IR_funct3], can_branch, read_data_1, read_data_2, flag_comp );
  
    
    assign imm_out_ext = imm_out;
    imm_gen immGen (IF_ID_Inst , imm_out);
    
    
    assign alu_mux_ext = alu_mux_out;
    multiplexer alu_mux (inputB, ID_EX_Imm, ID_EX_alu_src, alu_mux_out);
    
   
    assign alu_ctrl_out_ext = alu_ctrl_out;
    ALU_op aluOp (ID_EX_alu_op ,ID_Ex_Func25,ID_EX_Func[2:0],ID_EX_Func[3],alu_ctrl_out);
    
    
    assign z_flag_ext = zero_flag;
    
    assign alu_out_ext = alu_out;
    
    prv32_ALU alu (inputA, alu_mux_out, imm_out[4:0], alu_out, carry_flag, zero_flag, over_flag, sign_flag, alu_ctrl_out);

    
   // branch branch_mod (ID_EX_Func[2:0] , EX_MEM_branch[3], EX_MEM_branch[2], EX_MEM_branch[1], EX_MEM_branch[0], should_branch);
    
    
    assign data_mem_out_ext = data_mem_out;
   
    
    
//    assign shift_ext = shift_out;
//    shift pc_shift (ID_EX_Imm, shift_out);
    
   
    assign pc_gen_out_ext = pc_gen_out;
    assign pc_gen_in = EX_MEM_pc_gen_sel ?   ID_EX_RegR1 : EX_MEM_BranchAddOut;
     
    ripple pc_gen (IF_ID_PC, imm_out, pc_gen_out, dummy_carry);
      
//     ripple pc_gen (IF_ID_PC, imm_out, pc_gen_out, dummy_carry);
    
    
    assign PC_inc_ext = pc_inc_out;
   
    ripple pc_inc (PC, inst_out[1:0] ?  3'd4 : 3'd2, pc_inc_out, dummy_carry_2);

    
    
    multiplexer write_back (MEM_WB_ALU_out, MEM_WB_Mem_out, MEM_WB_mem_to_reg, write_data);
        

    Forward_Unit FU (EX_MEM_reg_write, MEM_WB_reg_write,EX_MEM_Rd,ID_EX_Rs1,ID_EX_Rs2,MEM_WB_Rd,forwardA, forwardB);
    
    assign inputA = (forwardA == 2'b10)? EX_MEM_ALU_out : (forwardA == 2'b01)? write_data: ID_EX_RegR1;
    
    
    assign inputB = (forwardB == 2'b10)? EX_MEM_ALU_out : (forwardB == 2'b01)? write_data: ID_EX_RegR2;



    assign jump_mux = (ID_EX_rd_sel == 2'b00) ? alu_out : (ID_EX_rd_sel == 2'b01) ? pc_gen_out : (ID_EX_rd_sel == 2'b10) ? (ID_EX_PC + 4) : ID_EX_RegR2;
    
    multiplexer pc_mux (pc_inc_out, pc_gen_out, flag_comp , PC_in);
    assign new_PC_in = pc_gen_sel ? PC_in & -2 : PC_in;
    assign final_pc = (MEM_WB_sys & inst_out[20])? PC : new_PC_in;
endmodule