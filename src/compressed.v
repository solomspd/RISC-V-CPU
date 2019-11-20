`timescale 1ns / 1ps
`include "defines.v"
module compressed (input [15:0]in, output reg [31:0]out);
always @(*) begin
    out[`IR_funct3] = in[15:13];
    out[1:0] = 2'b11;
    case (in[1:0])
        2'b00: begin // load and store
            out[`IR_rs1] = in[9:7] + 4'b1000;
            case (in[15:13])
                3'b010: begin // LW
                        out[`IR_funct3] = 3'b010;
                        out[`IR_rd] = in[4:2] + 4'b1000;
                        out[`IR_opcode] = `OPCODE_Load;
                        out[`IR_csr] = {in[5], in[12:10], in[6], 2'b00};
                    end
                3'b110: begin // SW
                        out[`IR_funct3] = 3'b010;
                        out[`IR_rs2] = in[4:2] + 4'b1000;
                        out[`IR_opcode] = `OPCODE_Store;
                        out[`IR_funct7] = in[12];
                        out[`IR_rd] = {in[11:10], in[6], 2'b00};
                    end
                default: out = 32'b0;
            endcase
         end
         2'b01: begin
            case (in[15:13])
                3'b000: begin // ADDI
                        out[`IR_funct3] = 3'b000;
                        out[`IR_csr] = $signed({in[12], in[6:2]});
                        out[`IR_opcode] = `OPCODE_Arith_I;
                        out[`IR_rd] = in[11:7];
                        out[`IR_rs1] = in[11:7];
                    end
                3'b001: begin // JAL
                        out[20] = in[12];
                        out[29:21] = {in[10:9], in[6], in[7], in[2], in[11], in[5:3]};
                        out[`IR_rs1] = 5'b0;
                        out[`IR_opcode] = `OPCODE_JAL;
                    end
                3'b010: begin // LUI
                        out[31:12] = $signed({in[12], in[6:2]});
                        out[`IR_rd] = {in[11:7]};
                        out[`IR_opcode] = `OPCODE_LUI;
                    end
                3'b100: begin // R-format and I-format
                        case (in[11:10])
                            2'b00: begin // SRLI
                                    out[`IR_funct3] = 3'b101;
                                    out[`IR_funct7] = 7'b0000000;
                                    out[`IR_rs2] = {in[12], in[6:2]};
                                    out[`IR_rd] = in[9:7] + 4'b1000;
                                    out[`IR_rs1] = in[9:7] + 4'b1000;
                                    out[`IR_opcode] = `OPCODE_Arith_I;
                                end
                            2'b01: begin // SRAI
                                    out[`IR_funct3] = 3'b101;
                                    out[`IR_funct7] = 7'b0100000;
                                    out[`IR_rs2] = {in[12], in[6:2]};
                                    out[`IR_rd] = in[9:7] + 4'b1000;
                                    out[`IR_rs1] = in[9:7] + 4'b1000;
                                    out[`IR_opcode] = `OPCODE_Arith_I;
                                end
                            2'b10: begin // ANDI
                                    out[`IR_funct3] = 3'b111;
                                    out[`IR_csr] = $signed({in[12], in[6:2]});
                                    out[`IR_rd] = in[9:7] + 4'b1000;
                                    out[`IR_rs1] = in[9:7] + 4'b1000;
                                    out[`IR_opcode] = `OPCODE_Arith_I;
                                end
                            2'b11: begin // R-format
                                    out[`IR_rd] = in[9:7] + 4'b1000;
                                    out[`IR_rs1] = in[9:7] + 4'b1000;
                                    out[`IR_rs2] = in[4:2] + 4'b1000;
                                    out[`IR_opcode] = `OPCODE_Arith_R;
                                    case (in[6:5])
                                        2'b00: begin // SUB
                                                out[`IR_funct3] = 3'b000;
                                                out[`IR_funct7] = 7'b0100000;
                                            end
                                        2'b01: begin // XOR
                                                out[`IR_funct3] = 3'b100;
                                                out[`IR_funct7] = 7'b0000000;
                                            end
                                        2'b10: begin // OR
                                                out[`IR_funct3] = 3'b110;
                                                out[`IR_funct7] = 7'b0000000;
                                            end
                                        2'b11: begin // AND
                                                out[`IR_funct3] = 3'b111;
                                                out[`IR_funct7] = 3'b0000000;
                                            end
                                        default: out = 32'b0;
                                    endcase
                                end
                                default: out = 32'b0;
                        endcase
                    end
                3'b110: begin // BEQ
                        out[`IR_funct3] = 3'b000;
                        out[`IR_rd] = {in[11:10], in[4:3], in[12]};
                        out[31:25] = $signed({in[12], in[6:5], in[2]});
                        out[`IR_rs1] = in[9:7] + 4'b1000;
                        out[`IR_rs2] = 5'b00000;
                        out[`IR_opcode] = `OPCODE_Branch;
                    end
                3'b111: begin // BNE
                        out[`IR_funct3] = 001;
                        out[`IR_rd] = {in[11:10], in[4:3], in[12]};
                        out[28:25] = $signed({in[12], in[6:5], in[2]});
                        out[`IR_rs1] = in[9:7] + 4'b1000;
                        out[`IR_rs2] = 5'b00000;
                        out[`IR_opcode] = `OPCODE_Branch;
                    end
                    
                    default: out = 32'b0;

            endcase
            end
            2'b10: begin
                    case(in[15:13])
                        3'b000: begin // SLLI
                                out[`IR_funct3] = 3'b001;
                                out[`IR_funct7] = 7'b0000000;
                                out[`IR_rs2] = {in[12], in[6:2]};
                                out[`IR_rd] = in[9:7];
                                out[`IR_rs1] = in[9:7];
                                out[`IR_opcode] = `OPCODE_Arith_I;
                            end
                        3'b100: begin
                                if (in[11:7] == 0 && in[6:2] == 0) begin // SLLI
                                    out[`IR_csr] = 12'b1;
                                    out[`IR_opcode] = `OPCODE_SYSTEM;
                                    out[`IR_funct3] = 3'b0;
                                    out[`IR_rd] = 5'b0;
                                    out[`IR_rs1] = 5'b0;
                                end
                                if (in[11:7] != 0 && in[6:2] == 0) begin // JALR
                                    out[`IR_rs1] = in[11:7];
                                    out[`IR_opcode] = `OPCODE_Arith_I;
                                    out[`IR_csr] = 12'b0;
                                    out[`IR_rd] = 5'b1;
                                    out[`IR_funct3] = 3'b000;
                                end
                                if (in[11:7] != 0 && in[6:2] != 0) begin // ADD
                                    out[`IR_rs1] = in[11:7];
                                    out[`IR_rd] = in[11:7];
                                    out[`IR_rs1] = in[6:2];
                                    out[`IR_opcode] = `OPCODE_Arith_R;
                                    out[`IR_funct3] = 3'b000;
                                    out[`IR_funct7] = 7'b0000000;
                                end
                            end
                        default: out = 32'b0;
                    endcase
                end
                default: out = 32'b0;
    endcase
end
endmodule