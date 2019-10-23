`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/24/2019 03:11:13 PM
// Design Name: 
// Module Name: regfile_tb
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


module RegFile_tb();
reg clk, rst;
reg [4:0] readreg1, readreg2, writereg;
reg [31:0] writedata;
reg regwrite;
wire [31:0] readdata1, readdata2;
// instantiate device under test
RegFile dut(clk, rst, readreg1, readreg2, writereg, writedata, regwrite,
readdata1, readdata2);
// apply clock
initial begin
clk = 0;
forever #50 clk = ~clk;
end
// apply inputs one at a time
// checking results
initial begin
// check that registers contents = 0 when rst = 1
$display("test 1 ");
rst = 1; readreg1 = 10; readreg2 = 20;
regwrite = 0;
#100
if(readdata1 != 0 || readdata2 != 0)
$display("failed");
// check that data is not written and read on readreg1 if regwrite = 0
$display("test 2 ");
rst = 0;
writedata = 78894131; writereg = 15;
readreg1 = 15;
#100
if(readdata1 != 0 || readdata2 != 0)
$display("failed");
// check that new data is written and read on readreg1 if regwrite = 1
$display("test 3 ");
regwrite = 1;
#100
if(readdata1 != 78894131 || readdata2 != 0)
$display("failed");
// check that data is not written and read on readreg2 if regwrite = 0
$display("test 4 ");
writedata = 98765; writereg = 25;
readreg2 = 25;
regwrite = 0;
#100
if(readdata1 != 78894131 || readdata2 != 0)
$display("failed");
// check that new data is written and read on readreg2 if regwrite = 1
$display("test 5 ");
regwrite = 1;
#100
if(readdata1 != 78894131 || readdata2 != 98765)
$display("failed");
end
endmodule
