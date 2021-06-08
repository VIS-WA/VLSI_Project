module adder(clock, a, b, sum);

input clock;
input [3:0] a, b;
output reg [4:0]sum;

reg [3:0] p, g;
reg [4:0] carry;
initial carry[0]=0;

always @(posedge clock)
begin
	//This is the structural part. We can write this also in another 
	//module but since our goal is to verify simulations, we use directly
	p=a^b;  
	g=a&b;

		
	//carry[1]=g[0];
	//carry[2]=(g[1]) | (p[1] & g[0]);
	//carry[3]=(g[2]) | (p[2] & g[1]) | (p[2] & p[1] & p[0]);
	//carry[4]=(g[3]) | (p[3] & g[2]) | (p[3] & p[2] & g[1]) | (p[3]&p[2]&p[1]&g[0]);
	

	carry[1]=g[0]|(p[0]&carry[0]);
	carry[2]=g[1]|(p[1]&carry[1]);
	carry[3]=g[2]|(p[2]&carry[2]);
	carry[4]=g[3]|(p[3]&carry[3]);

	sum[0]=p[0]^carry[0];
	sum[1]=p[1]^carry[1];
	sum[2]=p[2]^carry[2];
	sum[3]=p[3]^carry[3];
	sum[4]=carry[4];


end


endmodule
