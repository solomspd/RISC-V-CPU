
module datapath_tb();
reg clk, rst; wire [31:0]inst_out_ext; wire branch_ext, mem_read_ext, mem_to_reg_ext, mem_write_ext, alu_src_ext, reg_write_ext;
 wire [1:0]alu_op_ext; wire z_flag_ext; wire [31:0]alu_ctrl_out_ext; wire [31:0]PC_inc_ext; wire [31:0]PC_gen_out_ext; wire [31:0]PC_ext; wire [31:0]PC_in_ext;
 wire [31:0]data_read_1_ext; wire [31:0]data_read_2_ext; wire [31:0]write_data_ext; wire [31:0]imm_out_ext; wire [31:0]shift_ext; wire [31:0]alu_mux_ext;
 wire [31:0]alu_out_ext; wire [31:0]data_mem_out_ext;
 
 data_path  dp(clk, rst, inst_out_ext, branch_ext, mem_read_ext, mem_to_reg_ext, mem_write_ext, alu_src_ext, reg_write_ext,
  alu_op_ext,  z_flag_ext,  alu_ctrl_out_ext,  PC_inc_ext,  PC_gen_out_ext,  PC_ext,  PC_in_ext, 
  data_read_1_ext, data_read_2_ext, write_data_ext, imm_out_ext,  shift_ext, alu_mux_ext, alu_out_ext, data_mem_out_ext);
 
 
 initial begin
 clk=0;
 forever #10 clk=~clk;
 end
 initial begin
 rst=1;
 #20
 rst=0;

 end
endmodule
