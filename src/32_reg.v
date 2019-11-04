`timescale 1ns / 1ps
/*******************************************************************
*
* Module: register.v
* Project: RISC-V FPGA Implementation and Testing 
* Author: 
* Ahmed Ibrahim  ahmeddibrahim@aucegypt.edu
* Abd El-Salam   solomspd@aucegypt.edu
* Andrew Kamal   andrewk.kamal@aucegypt.edu
* Rinal Mohamed  rinalmohamed@aucegypt.edu
* Description: This module just creates one instance of a *register to be used later in the registers file module to create *the 32 registers required for the processor
*
* Change history: 09/17/2019 03:07:59 PM - Module created by Abd *El-Salam in the lab
* 10/24/19 – Ahmed, Andrew, Abd El-Salam, and Rinal worked on the *module to make it compatible with the other modules modified in *the sources files
* 10/29/19- Ahmed, Andrew, Abd El-Salam, and Rinal made the final modificaions to the module
*
**********************************************************************/

module register #(parameter n = 32) (input clk, input [n-1:0]in, input rst, input load, output [n-1:0]out);
    
    wire [n-1:0]muxer;
    genvar i;
    generate
        for (i = 0; i < n; i = i + 1) begin
            DFlipFlop flip(clk, rst, muxer[i], out[i]);
            mux muxie(out[i], in[i], load, muxer[i]);
        end 
    endgenerate
endmodule
