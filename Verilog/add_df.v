`timescale 1ns / 1ps
`include "df.v"
module add (input clk,input [3:0] a,b, output [3:0] dsum, output reg c5);

reg [3:0] p,g,sum;
reg [4:0] c;
wire [3:0] da,db;
reg r;
initial begin
	c[0:0] = 0;
	r=0;
end

df rA (a,da,r,clk);
df rB (b,db,r,clk);
df rS (sum,dsum,r,clk);

always @ (da,db)
begin
	p = da ^ db;
	g = da & db;
	c[1] = (p[0] & c[0]) | g[0] ;
	c[2] = (p[1] & c[1]) | g[1] ;
	c[3] = (p[2] & c[2]) | g[2] ;
	c[4] = (p[3] & c[3]) | g[3] ;
	sum = p ^ c;
	c5 = c[4:4];
end

endmodule
