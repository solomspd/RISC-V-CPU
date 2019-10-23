`include "defines.v"

module branch (input [2:0]func3, input zero, input carry, input overflow, input sign, output reg out);

always @(*) begin
    case (func3)
        `BR_BEQ: out = zero;
        `BR_BNE: out = ~zero;
        `BR_BLT: out = (sign != overflow);
        `BR_BGE: out = (sign == overflow);
        `BR_BLTU: out = ~carry;
        `BR_BGEU: out = carry;
    endcase
end

endmodule
