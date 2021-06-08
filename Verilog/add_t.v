`timescale 1ns / 1ps
module add_t;

reg [3:0] a,b;
reg clk;
wire c;
wire [3:0] sum;

add uut (clk, a, b, sum, c);

initial begin
	$dumpfile ("add_o.vcd");
	$dumpvars (0,add_t);
	clk = 0;
	#10;
	a=4;b=3;
	#10 a=5; b=5;
	#10 a=8;b=2;
	#20;
	$finish;
end
always #5  clk = ~clk ;

//initial begin
//	$monitor("a=%d b=%d y=%d\n",a,b,y);
	//$display("a=%d b=%d y=%d\n",a,b,y);
//end

endmodule

