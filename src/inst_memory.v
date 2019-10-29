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
* Description: this module stores instructions that will be executed.
*
* Change history: 09/17/2019 03:07:59 PM - Module created by Abd *El-Salam in the lab
* 29/10/2019 - made memory byte addressable and can now input from file
*
**********************************************************************/


module InstMem (input [5:0] addr, output [31:0] data_out);
    reg [7:0] mem [(4*1024-1):0];
    
     assign data_out = {mem[addr+3], mem[addr+2], mem[addr+1], mem[addr]};    
    initial begin

        $readmemh("C:/Users/solomspd/project_1/rarspls.mem", mem);  
        //    end
    end

endmodule

