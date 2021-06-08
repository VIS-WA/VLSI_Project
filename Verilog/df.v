`timescale 1ns / 1ps

module df( input [3:0] d, output reg [3:0] q, input r , input clk);
always @ (posedge clk) 

begin 
if (r == 1 ) 
	q <= 0 ; 
else 
	q <= d ; 

end 


endmodule
