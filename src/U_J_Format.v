//`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////////////////////////
//// Company: 
//// Engineer: 
//// 
//// Create Date: 07/21/2019 01:08:22 PM
//// Design Name: 
//// Module Name: Uinst
//// Project Name: 
//// Target Devices: 
//// Tool Versions: 
//// Description: 
//// 
//// Dependencies: 
//// 
//// Revision:
//// Revision 0.01 - File Created
//// Additional Comments:
//// 
////////////////////////////////////////////////////////////////////////////////////


module U_J_Format(input [6:0] opcode, input [31:0] imm, pc, PC_Imm, mux, output reg[31:0] write_Data);

    always@(*) begin
  
 if (opcode== 7'b0110111)  // lui
write_Data = imm>> 12;

else if (opcode== 7'b0010111)   // auipc
//out = (imm>> 12)+pc;
write_Data = PC_Imm;

else if (opcode== 7'b1100111) // jal
write_Data = pc;

else if (opcode== 7'b1100111) // jalr
write_Data = pc;

else 
write_Data=mux; 

end 
endmodule