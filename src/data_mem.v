`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 26/10/2019 02:35:50 PM
// Design Name: 
// Module Name: data_mem
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module DataMem (input clk, input MemRead, input MemWrite, input [5:0] addr,input [2:0]func, input [31:0] data_in, output [31:0] data_out);

  reg [7:0] datamemory [0:63];  
  wire [7:0] addr1,addr;
  wire [7:0] addr2;
  wire [7:0] addr3;
     assign addr=data_in[7:0];
     assign addr1=data_in[15:8];
     assign addr2=data_in[24:16];
     assign addr3=data_in[31:24];  
     
    always @(posedge clk) begin

        if (MemWrite & ~MemRead)
	if (func3 == 3'b010) 
            mem[addr] <= addr;
		 mem[addr+1]<=addr1;
		 mem[addr+2]<=addr2;
		 mem[addr+3]<=addr3;
      else if (fun3 == 3'b001)
		 mem[addr] <= addr;
 		 mem[addr+1] <= addr1;
      else
   		 me[addr] <= addr;

    end

always @(posedge clk)
    begin          
if (MemRead & ~MemWrite)

 if (func3 == 3'b010) //LW
    assign data_out[7:0] = mem[addr];
    assign data_out[15:8] = mem[addr+1];
    assign data_out[24:16] = mem[addr+2];
    assign data_out[24:16] = mem[addr+3];

 else if (func3 == 3'b001)//LH
    assign data_out[7:0] = mem[addr];
    assign data_out[15:8] = mem[addr+1];

else if (func3 == 3'b101)//Halfword unsigned
    assign data_out= {16'b0,mem[addr],mem[addr+1]}

else if (func3 == 3'b100)//BYTE unsigned
    assign data_out= {24'b0,mem[addr]}


 else //lb
    assign data_out[7:0] = mem[addr];

    end
       
endmodule

