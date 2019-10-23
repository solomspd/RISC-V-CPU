

module data_mem_tb();
reg clk,mr,mw;
reg [31:0]data_in;
reg [5:0]addr;
wire [31:0]data_out;


DataMem DM(clk, mr, mw, addr, data_in, data_out);

initial begin
forever #50 clk = ~clk;
end

initial begin

clk=0;

mr=0;
mw=1;
addr=1;
data_in=10;
#100
mr=0;
mw=1;
addr=2;
data_in=55;
#100
mr=1;
mw=0;
addr=1;
#100
mr=1;
mw=0;
addr=2;

end 

endmodule
