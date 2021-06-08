`timescale 1ns / 1ps
module add (input clk,input [3:0] da,db, output reg [3:0] sum, output reg c5);

reg [3:0] p,g,a,b;
reg [4:0] c;
reg [4:0] temp;
initial c[0:0] = 0;

always @ (posedge clk)
begin
	sum = temp[3:0]; c5 = temp[4:4];
	a = da; b = db;
	p = a ^ b;
	g = a & b;
	c[1] = (p[0] & c[0]) | g[0] ;
	c[2] = (p[1] & c[1]) | g[1] ;
	c[3] = (p[2] & c[2]) | g[2] ;
	c[4] = (p[3] & c[3]) | g[3] ; 
	temp[3:0] = p ^ c;
	temp[4:4] = c[4:4];
end


endmodule
