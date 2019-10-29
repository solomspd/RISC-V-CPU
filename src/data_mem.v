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
* 26/10/19 - made memory byte addressable and added all instructions (sb,lb, etc..) 
* 29/10/19 - made memory 4k bytes big. now input memeory from file
*
**********************************************************************/

module DataMem (input clk, input MemRead, input MemWrite, input [5:0] addr,input [2:0]func3, input [31:0] data_in, output reg [31:0]  data_out);
    reg [7:0] mem [(4*1024-1):0]; 
    
    always @(posedge clk) 
    begin
        if (MemWrite & ~MemRead)
            if (func3 == 3'b010)//SW
            begin
                mem[addr] <= data_in[7:0];
                mem[addr+1]<=data_in[15:8];
                mem[addr+2]<=data_in[24:16];
                mem[addr+3]<=data_in[31:24];
            end

            else if (func3 == 3'b001)//SH
            begin
                mem[addr] <= data_in[7:0];
                mem[addr+1] <= data_in[15:8];
            end
            else if (func3==3'b000)// SB
            mem[addr] <= data_in[7:0];
    end


    always @(*)
    begin
        if (MemRead & ~MemWrite) begin
            if (func3 == 3'b010) //LW
                data_out={mem[addr+3],mem[addr+2],mem[addr+1],mem[addr]};

            else if (func3 == 3'b001)//LH
                data_out={{16{mem[addr+1][7]}},mem[addr+1],mem[addr]};

            else if (func3 == 3'b101)//Halfword unsigned
                data_out= {16'b0,mem[addr],mem[addr+1]};

            else if (func3 == 3'b100)//BYTE unsigned
                data_out= {24'b0,mem[addr]};

            else if(func3==3'b000)// LB
                data_out={{24{mem[addr][7]}},mem[addr]};
         end
    end
    
    initial begin
        {mem[3],mem[2],mem[1],mem[0]} = 32'd17;
        {mem[7],mem[6],mem[5],mem[4]} = 32'd9;
        {mem[11],mem[10],mem[9],mem[8]} = 32'd25;
    end
      
endmodule