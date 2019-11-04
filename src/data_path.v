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
*
**********************************************************************/

`include "defines.v"

module data_path(input clk, input rst, output [31:0]inst_out_ext, output branch_ext, mem_read_ext, mem_to_reg_ext, mem_write_ext, alu_src_ext, reg_write_ext,
 output [1:0]alu_op_ext, output z_flag_ext, output [31:0]alu_ctrl_out_ext, output [31:0]PC_inc_ext, output [31:0]pc_gen_out_ext, output [31:0]PC_ext, output [31:0]PC_in_ext,
 output [31:0]data_read_1_ext, output [31:0]data_read_2_ext, output [31:0]write_data_ext, output [31:0]imm_out_ext, output [31:0]shift_ext, output [31:0]alu_mux_ext
 ,output [31:0]alu_out_ext, output [31:0]data_mem_out_ext);
    wire [31:0] write_data_in;    
    wire [31:0]PC;
    wire [31:0]new_PC_in;
    wire [31:0] final_pc;

    assign PC_ext = PC;
    wire [31:0]PC_in;
    assign PC_in_ext = PC_in;
    register program_counter (clk, final_pc, rst, 1'b1, PC);
    
    wire [31:0]inst_out;
    assign inst_out_ext = inst_out;
    InstMem inst_mem (PC, inst_out);
    
    wire can_branch, mem_read, mem_to_reg, mem_write, alu_src, reg_write, pc_gen_sel, sys;
    assign branch_ext = can_branch;
    assign mem_read_ext = mem_read;
    assign mem_to_reg_ext = mem_to_reg;
    assign mem_write_ext = mem_write;
    assign alu_src_ext = alu_src;
    assign reg_write_ext = reg_write;
    wire [1:0]alu_op;
    assign alu_op_ext = alu_op;
    wire [1:0]rd_sel;
    control_unit controlUnit (inst_out[`IR_opcode], can_branch, mem_read, mem_to_reg, mem_write, alu_src, reg_write,sys, alu_op, rd_sel, pc_gen_sel);
    
    wire [31:0]write_data;
      assign write_data_ext = write_data_in;
    wire [31:0]read_data_1;
    assign data_read_1_ext = read_data_1;
    wire [31:0]read_data_2;    
    assign data_read_2_ext = read_data_2;
    RegFile reg_file (clk, rst, inst_out[`IR_rs1], inst_out[`IR_rs2], inst_out[`IR_rd], write_data_in, reg_write, read_data_1, read_data_2);
    
  
    
    wire [31:0]imm_out;
    assign imm_out_ext = imm_out;
    imm_gen immGen (inst_out, imm_out);
    
    wire [31:0]alu_mux_out;
    assign alu_mux_ext = alu_mux_out;
    multiplexer alu_mux (read_data_2, imm_out, alu_src, alu_mux_out);
    
    wire [3:0] alu_ctrl_out;
    assign alu_ctrl_out_ext = alu_ctrl_out;
    ALU_op aluOp (alu_op, inst_out[`IR_funct3], inst_out[30], alu_ctrl_out);
    
    wire carry_flag, zero_flag, over_flag, sign_flag;
    assign z_flag_ext = zero_flag;
    wire [31:0]alu_out;
    assign alu_out_ext = alu_out;
    prv32_ALU alu (read_data_1, alu_mux_out, imm_out[4:0], alu_out, carry_flag, zero_flag, over_flag, sign_flag, alu_ctrl_out);

    wire should_branch;
    branch branch_mod (inst_out[`IR_funct3], zero_flag, carry_flag, over_flag, sign_flag, should_branch);
    
    wire [31:0]data_mem_out;
    assign data_mem_out_ext = data_mem_out;
    DataMem data_mem (clk, mem_read, mem_write, alu_out, inst_out[`IR_funct3] ,read_data_2, data_mem_out);

   
    
    wire [31:0]shift_out;
    assign shift_ext = shift_out;
    shift pc_shift (imm_out, shift_out);
    
    wire [31:0]pc_gen_out;
    assign pc_gen_out_ext = pc_gen_out;
    wire dummy_carry;
    wire [31:0]pc_gen_in;
    assign pc_gen_in = pc_gen_sel ? read_data_1 : PC;
    ripple pc_gen (pc_gen_in, imm_out, pc_gen_out, dummy_carry);
    
    
    
    wire [31:0]pc_inc_out;
    assign PC_inc_ext = pc_inc_out;
    wire dummy_carry_2;
    ripple pc_inc (PC, 4'b100, pc_inc_out, dummy_carry_2);
    
    
    multiplexer write_back (alu_out, data_mem_out, mem_to_reg, write_data);
    
//    mux4x1 write_data_mux (write_data, pc_gen_out, pc_inc_out, read_data_1, rd_sel, write_data_in);
    
    assign write_data_in = (rd_sel == 2'b00) ? write_data : (rd_sel == 2'b01) ? pc_gen_out : (rd_sel == 2'b10) ? pc_inc_out : read_data_1;
    
    multiplexer pc_mux (pc_inc_out, pc_gen_out, (can_branch & should_branch) , PC_in);

    assign new_PC_in = pc_gen_sel ? PC_in >> 2 : PC_in;  
    assign final_pc = (sys & inst_out[20])? PC : new_PC_in;
//    assign pc_in = pc_gen_sel ? pc_gen_out >> 2 : pc_inc_out;

endmodule
