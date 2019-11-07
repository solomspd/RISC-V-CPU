`include "defines.v"
/*******************************************************************
*
* Module: branch.v
* Project: RISC-V FPGA Implementation and Testing 
* Author: 
* Ahmed Ibrahim  ahmeddibrahim@aucegypt.edu
* Abd El-Salam   solomspd@aucegypt.edu
* Andrew Kamal   andrewk.kamal@aucegypt.edu
* Rinal Mohamed  rinalmohamed@aucegypt.edu
* Description: This module was created to handle all the branch *instructions that will be handled by the processor
*
* Change history: 24/10/2019 - Module created and modified based *on the needs of each branch instruction
*25/10/2019 - fixed branch module
**********************************************************************/


module branch (input [2:0]func3, input carry, input zero, input overflow, input sign, output reg out);

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
