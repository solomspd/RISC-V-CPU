module shifter (input [31:0]in, input [4:0]shamt, input [1:0]alu, output [31:0]out);

always @(*) begin
    case (alu) begin
        2'b00: out = in << shamt;
        2'b01: out = in >>> shamt;
        2'b10: out = in >> shamt;
    end
end

endmodule