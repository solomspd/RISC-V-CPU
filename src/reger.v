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



* Description: This module just creates one instance of a *registerFile that assigns rs1 and rs2 according to the inputs and gives the load a value according to regwrite and writereg.

*



* Change history: 09/17/2019 03:07:59 PM - Module created by Abd *El-Salam in the lab



* 10/24/19 – Ahmed, Andrew, Abd El-Salam, and Rinal worked on the *module to make it compatible with the other modules modified in *the sources files



* 10/29/19- Ahmed, Andrew, Abd El-Salam, and Rinal made the final modificaions to the module



*



**********************************************************************/


module RegFile (
input clk, rst, input [4:0] readreg1, readreg2, writereg, input [31:0] writedata, input regwrite, output [31:0] readdata1, readdata2 );

    wire [31:0]load;
    wire [31:0]out[0:31];
    
    genvar i;
    generate
        for (i = 0; i < 32; i = i + 1) begin
            register regriar(clk, writedata, rst, load[i], out[i]);
        end
    endgenerate
    
//    assign readdata1 = readreg1 != 5'b0 ? out[readreg1] : 5'b0;
    assign readdata1 = out[readreg1];
    assign readdata2 = out[readreg2];
//    assign readdata2 = readreg2 != 5'b0 ? out[readreg2] : 5'b0;
        
    assign load = regwrite && writereg ? 1 << writereg : 0;
    
endmodule

