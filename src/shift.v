`timescale 1ns / 1ps
/*******************************************************************

*

* Module: shift.v

* Project: RISC-V FPGA Implementation and Testing 

* Author: 

* Ahmed Ibrahim  ahmeddibrahim@aucegypt.edu

* Abd El-Salam   solomspd@aucegypt.edu

* Andrew Kamal   andrewk.kamal@aucegypt.edu

* Rinal Mohamed  rinalmohamed@aucegypt.edu

* Description: This module just creates one instance of a *shift that takes an input and shifts it to the left by 2.
*

* Change history: 09/17/2019 03:07:59 PM - Module created by Abd *El-Salam in the lab

* 10/24/19 – Ahmed, Andrew, Abd El-Salam, and Rinal worked on the *module to make it compatible with the other modules modified in *the sources files

* 10/29/19- Ahmed, Andrew, Abd El-Salam, and Rinal made the final modificaions to the module

*

**********************************************************************/


module shift(input [31:0]in, output [31:0]out);
    assign out[31:0] = {in[30:0],1'b0};
endmodule
