`include "defines.v"
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/17/2019 09:26:08 PM
// Design Name: 
// Module Name: branch_predictor
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
module branch_predictor(input[31:0]PC, imm_gen_out, previous_pc,previous_predicted_pc,
 input[1:0]state_in, output reg  [1:0]state,output reg [31:0]new_pc,
output reg flush, flag);
// assuming that it is initialized as slightly taken prediction
//wire flag;
//reg [1:0] states [64:0];
// need to have just one entry for saving the belongings of the //previous instructions.
// need to handle flushing instructions based on the new flag
// need to keep a buffer for the PC
always@(*)
begin
if (flag&&(state_in==`strongly_taken))
begin
state= `strongly_taken ;
new_pc=PC+imm_gen_out;
end

else if (~flag&&(state_in==`strongly_taken))
begin
state= `slightly_taken;
new_pc=PC+imm_gen_out;
end
else if (flag&&(state_in==`slightly_taken))
begin
state= `strongly_taken;
new_pc=PC+imm_gen_out;
end
else if (~flag&&(state_in==`slightly_taken))
begin
state= `slightly_NT;
new_pc=PC+4;
end
else if (flag&&(state_in==`slightly_NT))
begin
state= `strongly_NT;
new_pc=PC+4;
end
else if (~flag&&(state_in==`slightly_NT))
begin
state= `slightly_taken;
new_pc=PC+imm_gen_out;
end
else if (flag&&(state_in==`strongly_NT))
begin
state=  `strongly_NT;
new_pc=PC+4;
end
else if (~flag&&(state_in==`strongly_NT))
begin
state=  `slightly_NT;
new_pc=PC+4;
end

end
always@(*)
begin
flag=(previous_pc==previous_predicted_pc)? 1'b1:1'b0;
if(flag)
flush=0;
else
flush= 1'b1;
end 
endmodule