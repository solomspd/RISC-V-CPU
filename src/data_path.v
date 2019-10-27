`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/01/2019 03:02:58 PM
// Design Name: 
// Module Name: data_path
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

module data_path(input clk, input rst, output [31:0]inst_out_ext, output branch_ext, mem_read_ext, mem_to_reg_ext, mem_write_ext, alu_src_ext, reg_write_ext,
 output [1:0]alu_op_ext, output z_flag_ext, output [31:0]alu_ctrl_out_ext, output [31:0]PC_inc_ext, output [31:0]pc_gen_out_ext, output [31:0]PC_ext, output [31:0]PC_in_ext,
 output [31:0]data_read_1_ext, output [31:0]data_read_2_ext, output [31:0]write_data_ext, output [31:0]imm_out_ext, output [31:0]shift_ext, output [31:0]alu_mux_ext
 ,output [31:0]alu_out_ext, output [31:0]data_mem_out_ext);
        
    wire [31:0]PC;
    assign PC_ext = PC;
    wire [31:0]PC_in;
    assign PC_in_ext = PC_in;
    register program_counter (clk, PC_in, rst, 1'b1, PC);
    
    wire [31:0]inst_out;
    assign inst_out_ext = inst_out;
    InstMem inst_mem (PC >> 2, inst_out);
    
    wire can_branch, mem_read, mem_to_reg, mem_write, alu_src, reg_write;
    assign branch_ext = can_branch;
    assign mem_read_ext = mem_read;
    assign mem_to_reg_ext = mem_to_reg;
    assign mem_write_ext = mem_write;
    assign alu_src_ext = alu_src;
    assign reg_write_ext = reg_write;
    wire [1:0]alu_op;
    assign alu_op_ext = alu_op;
    control_unit controlUnit (inst_out[`IR_opcode], can_branch, mem_read, mem_to_reg, mem_write, alu_src, reg_write, alu_op);
    
    wire [31:0]write_data;
    assign write_data_ext = write_data;
    wire [31:0]read_data_1;
    assign data_read_1_ext = read_data_1;
    wire [31:0]read_data_2;    
    assign data_read_2_ext = read_data_2;
    RegFile reg_file (clk, rst, inst_out[`IR_rs1], inst_out[`IR_rs2], inst_out[`IR_rd], write_data, reg_write, read_data_1, read_data_2);
    
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
    branch branch_mod (inst_out[30:14], zero_flag, carry_flag, over_flag, sign_flag, should_branch);
    
    wire [31:0]data_mem_out;
    assign data_mem_out_ext = data_mem_out;
    DataMem data_mem (clk, mem_read, mem_write, alu_out, inst_out[`IR_funct3] ,read_data_2, data_mem_out);

    multiplexer write_back (alu_out, data_mem_out, mem_to_reg, write_data);
    
    wire [31:0]shift_out;
    assign shift_ext = shift_out;
    shift pc_shift (imm_out, shift_out);
    
    wire [31:0]pc_gen_out;
    assign pc_gen_out_ext = pc_gen_out;
    wire dummy_carry;
    ripple pc_gen (PC, imm_out, pc_gen_out, dummy_carry);
    
    wire [31:0]pc_inc_out;
    assign PC_inc_ext = pc_inc_out;
    wire dummy_carry_2;
    ripple pc_inc (PC, 4'b100, pc_inc_out, dummy_carry_2);
    
    multiplexer pc_mux (pc_inc_out, pc_gen_out, can_branch & should_branch, PC_in);

endmodule
