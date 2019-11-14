`timescale 1ns / 1ps

`include "defines.v"

module compressed (input [15:0]in, output reg [31:0]out);

always @(*) begin
    out[`IR_funct3] = in[13:15];
    case (in[0])
        2'b0: begin // load and store
            out[`IR_rs1] = in[7:9] + 4'b1000;
            case (in[13:15])
                3'b010: begin // LW
                        out[`IR_rd] = in[2:4] + 4'b1000;
                        out[`IR_opcode] = `OPCODE_Load;
                        out[`IR_csr] = {in[5], in[12:10], in[6], 2'b00};
                    end
                3'b110: begin // SW
                        out[`IR_rs2] = in[2:4] + 4'b1000;
                        out[`IR_opcode] = `OPCODE_Store;
                        out[`IR_funct7] = in[12];
                        out[`IR_rd] = {in[11:10], in[6], 2'b00};
                    end
            endcase
         end
         2'b1: begin
            case (in[15:13])
                3'b000: begin // ADDI
                        out[`IR_csr] = {in[12], in[6:2]};
                        out[`IR_opcode] = `OPCODE_Arith_I;
                        out[`IR_rd] = in[11:7];
                        out[`IR_rs1] = in[11:7];
                    end
                3'b001: begin // JAL
                        out[`IR_csr] = {in[12], in[8], in[10:9], in[6], in[7], in[2], in[11], in[5:3], 1'b0};
                        out[31:11] = {, 1'b0};
                        out[`IR_rs1] = 5'b0;
                    end
                3'b010: begin // LUI
                        out[`IR_csr] = {in[12], in[5:2]};
                        out[`IR_rd] = {in[11:7]}
                    end
            endcase
         end
    endcase
end
endmodule
