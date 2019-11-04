`timescale 1ns / 1ps

`include "defines.v"

module compressed (input [15:0]in, output reg [31:0]out);

always @(*) begin
    out[`IR_funct3] = in[13:15];
    case (in[0:1])
        2'b00: begin
            out[`IR_rs1] = in[7:9] + 4'b1000;
            case (in[13:15])
                3'b010: begin
                        out[`IR_csr] = {2'b00, in[6], in[10:12], in[5]};
                        out[`IR_rd] = in[2:4] + 4'b1000;
                        out[`IR_opcode] = `OPCODE_Load;
                    end
                3'b110: begin
                        out[`IR_rd] = {2'b00, in[4], in[10:11]};
                        out[`IR_csr] = {in[12], in[5]};
                        out[`IR_rs2] = in[2:4] + 4'b1000;
                        out[`IR_opcode] = `OPCODE_Store;
                    end
            endcase
         end
    endcase
end
endmodule