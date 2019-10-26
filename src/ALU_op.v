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

module ALU_op(input [1:0]op_in, input [2:0]inst_1, input inst_2, output reg [3:0]op_out);

always @(*) begin
    
    case (op_in)
        2'b00: op_out = `ALU_ADD;
        2'b01: op_out = `ALU_SUB;
        2'b10: case (inst_1)
            // if intruction30 ==1 ALU_SUB else ALU_ADD
            3'b000: op_out = inst_2 ? `ALU_SUB : `ALU_ADD;
            // if intruction30 ==1 ALU_PASS else ALU_AND
            3'b111: op_out = inst_2 ? `ALU_PASS : `ALU_AND; 
            // if intruction30 ==1 ALU_PASS else ALU_OR
            3'b110: op_out = inst_2 ? `ALU_PASS : `ALU_OR; 
            default: op_out = `ALU_PASS; //error
        endcase
        default: op_out = `ALU_PASS; //error
    endcase
end
endmodule
