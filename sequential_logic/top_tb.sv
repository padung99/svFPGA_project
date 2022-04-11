module top_tb;

bit clk;
logic [7:0] a_i;
logic [7:0] b_i;
bit c_i;
bit d_i;

logic g;

initial 
	forever
	#5 clk = !clk;

sequential_logic DUT (
	.clk_i (clk),
	.a_i(a_i),
	.b_i(b_i),
	.c_i(c_i),
	.d_i(d_i),
	.res_o(g)
);

initial
	begin
	#4;	
	a_i <= 0;
	b_i <= 0;
	c_i <= 1'b0;
	d_i <= 1'b0;
	
	//@(posedge clk)
	#9
	a_i <= 1;
	b_i <= 4;
	c_i <= 1'b1;
	d_i <= 1'b0;
	//@(posedge clk)
	#14
	
	a_i <= 2;
	b_i <= 5;
	c_i <= 1'b0;
	d_i <= 1'b0;
	//@(posedge clk)
	a_i <= 2;
	b_i <= 5;
	c_i <= 1'b1;
	d_i <= 1'b1;
	#19;
	
	a_i <= 3;
	b_i <= 6;
	c_i <= 1'b0;
	d_i <= 1'b1;
	#24;
	end
endmodule
	
	
	
	
	
	