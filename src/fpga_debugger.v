`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/01/2019 04:02:07 PM
// Design Name: 
// Module Name: fpga_debugger
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


module fpga_debugger(input seg_clk, input clk, input rst, input [1:0]led_sel, input [3:0]seg_sel, output [6:0]seg, output [0:3]anode, output reg [0:15]led);

wire [31:0]inst_out;
wire branch, mem_read, mem_to_reg, mem_write, alu_src, reg_write;
wire [1:0]alu_op;
wire z_flag;
wire [3:0]alu_ctrl_out;
wire [31:0]PC_inc;
wire [31:0]PC_gen_out;
wire [31:0]PC, PC_in;
wire [31:0]data_read_1, data_read_2, write_data, imm_out, shift, alu_mux, alu_out, data_mem_out;

data_path(clk, rst, inst_out, branch, mem_read, mem_to_reg, mem_write, alu_src, reg_write,
alu_op, z_flag, alu_ctrl_out, PC_inc, PC_gen_out, PC, PC_in,
data_read_1, data_read_2, write_data, imm_out, shift, alu_mux
 ,alu_out, data_mem_out);

always @(*) begin
    case (led_sel)
        2'b00: led = inst_out[15:0];
        2'b01: led = inst_out[31:16];
        2'b10: led = {branch, mem_read, mem_to_reg, mem_write, alu_src, reg_write, alu_op, z_flag};
        2'b11: led = 16'hffff;
    endcase
end

reg [12:0]disp;

Four_Digit_Seven_Segment_Driver_2 segger (seg_clk, disp, anode, seg);


always @(*) begin

    case(seg_sel)
        4'b0000: disp = PC;
        4'b0001: disp = PC_inc;
        4'b0010: disp = PC_gen_out;
        4'b0011: disp = PC_in;
        4'b0100: disp = data_read_1;
        4'b0101: disp = data_read_2;
        4'b0110: disp = write_data;
        4'b0111: disp = imm_out;
        4'b1000: disp = shift;
        4'b1001: disp = alu_mux;
        4'b1010: disp = alu_out;
        4'b1011: disp = data_mem_out;
        default: disp = 32'hffffffff;
    endcase
end


endmodule
