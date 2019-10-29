`timescale 1ns / 1ps
/*******************************************************************

*

* Module: shifter.v

* Project: RISC-V FPGA Implementation and Testing 

* Author: 

* Ahmed Ibrahim  ahmeddibrahim@aucegypt.edu

* Abd El-Salam   solomspd@aucegypt.edu

* Andrew Kamal   andrewk.kamal@aucegypt.edu

* Rinal Mohamed  rinalmohamed@aucegypt.edu

* Description: This module just creates one instance of a *shifter to be used to shift the input with the shift amount value and has a 2 bit selection line input alu.
*

* Change history: 09/17/2019 03:07:59 PM - Module created by Abd *El-Salam in the lab

* 10/24/19 – Ahmed, Andrew, Abd El-Salam, and Rinal worked on the *module to make it compatible with the other modules modified in *the sources files

* 10/29/19- Ahmed, Andrew, Abd El-Salam, and Rinal made the final modificaions to the module

*

**********************************************************************/
module shifter (input [31:0]in, input [4:0]shamt, input [1:0]alu, output reg [31:0]out);

always @(*) begin
    case (alu)
        2'b00: out = in << shamt;
        2'b01: out = in >>> shamt;
        2'b10: out = in >> shamt;
    endcase
end

endmodule
