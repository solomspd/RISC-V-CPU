module control_unit(input [4:0]inst, output reg branch, memRead, memtoReg, memWrite, ALUSrc, RegWrite, output reg [1:0]ALUOp);

always @(*) begin
    case(inst) 
        5'b01100: begin
            branch=0;
            memRead=0;
            memtoReg=0;
            ALUOp=2'b10;
            memWrite=0;
            ALUSrc=0;
            RegWrite=1;
            end
        5'b00000: begin
            branch=0;
            memRead=1;
            memtoReg=1;
            ALUOp=2'b00;
            memWrite=0;
            ALUSrc=1;
            RegWrite=1;
            end
        5'b01000: begin
            branch=0;
            memRead=0;
            ALUOp=2'b00;
            memWrite=1;
            ALUSrc=1;
            RegWrite=0;
            end 
        5'b11000: begin
            branch=1;
            memRead=0;
            ALUOp=2'b01;
            memWrite=0;
            ALUSrc=0;
            RegWrite=0;
            end
         default: begin 
            branch = 0;
            memRead = 0;
            ALUOp=2'b01;
            memWrite=0;
            ALUSrc=0;
            RegWrite=0;
            memtoReg=0;
            end
                                             
    endcase
end
endmodule