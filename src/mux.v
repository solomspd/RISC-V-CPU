`timescale 1ns / 1ps
/*******************************************************************
*
* Module: mux.v
* Project: RISC-V FPGA Implementation and Testing 
* Author: 
* Ahmed Ibrahim  ahmeddibrahim@aucegypt.edu
* Abd El-Salam   solomspd@aucegypt.edu
* Andrew Kamal   andrewk.kamal@aucegypt.edu
* Rinal Mohamed  rinalmohamed@aucegypt.edu
* Description: This module just creates a multiplexer module to *be used later in the data path whenever needed. We just *instantiate from that module and use it right away
*
* Change history: 09/17/2019 03:07:59 PM - Module created by Abd *El-Salam in the lab
*
**********************************************************************/

module mux(input a, input b, input sel, output c);
    assign c = sel ? b : a;
endmodule
