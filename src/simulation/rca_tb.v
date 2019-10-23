

module rca_tb();
reg [31:0]a;
reg [31:0]b;
wire [31:0]out;
wire cout;

ripple rca(a,b,out,cout);

initial begin

a=2;
b=2;
#100
a=2;
b=3;



end
endmodule
