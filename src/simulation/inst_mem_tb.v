/////////////////////////////////////////////////////////////////////


module inst_mem_tb();
reg [5:0]addr;
wire [31:0]inst;

InstMem IM(addr,inst);

initial begin

addr=1;
#100
addr=5;
#100
addr=7;
#100
addr=10;
#100
addr=12;



end
endmodule
