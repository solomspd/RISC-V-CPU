`timescale 1ns / 1ps
/*******************************************************************

*

* Module: program_counter.v

* Project: RISC-V FPGA Implementation and Testing 

* Author: 

* Ahmed Ibrahim  ahmeddibrahim@aucegypt.edu

* Abd El-Salam   solomspd@aucegypt.edu

* Andrew Kamal   andrewk.kamal@aucegypt.edu

* Rinal Mohamed  rinalmohamed@aucegypt.edu

* Description: This module just creates one instance of a *program_counter that creates a register for the pc with clk, reset, and pc_in as inputs. pc_out is its only output.
*

* Change history: 09/17/2019 03:07:59 PM - Module created by Abd *El-Salam in the lab

* 10/24/19 – Ahmed, Andrew, Abd El-Salam, and Rinal worked on the *module to make it compatible with the other modules modified in *the sources files

* 10/29/19- Ahmed, Andrew, Abd El-Salam, and Rinal made the final modificaions to the module

*

**********************************************************************/


module program_counter(input clk, input rst, input [31:0]pc_in, output [31:0]pc_out);
    register pc_reg (clk, pc_in, rst, 1'b1, pc_out);
endmodule
