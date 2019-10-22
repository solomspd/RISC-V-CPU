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
        2'b00: op_out = 4'b0010;
        2'b01: op_out = 4'b0110;
        2'b10: case (inst_1)
            3'b000: op_out = inst_2 ? 4'b0110 : 4'b0010;
            3'b111: op_out = inst_2 ? 4'b1111111111 : 4'b0000; //b1111111111 = error
            3'b110: op_out = inst_2 ? 4'b1111111111 : 4'b0001; //b1111111111 = error
            default: op_out = 4'b1111111111; //error
        endcase
        default: op_out = 4'b1111111111; //error
    endcase
end
endmodule
