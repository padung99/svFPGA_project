module top_tb;

parameter SIZE_tb = 10;
parameter BIT_SIZE_tb = 4;
parameter INCREMENT_tb = 1;

bit clk_tb;
bit rst_tb;

initial 
	forever
	 #5 clk_tb = !clk_tb;

logic [BIT_SIZE_tb-1: 0] cnt_tb;

GrayCounter #(.SIZE(SIZE_tb), .BIT_SIZE(BIT_SIZE_tb), .INCREMENT(INCREMENT_tb)) GrayCounter_inst(
	.clk_i(clk_tb),
	.rst_i(rst_tb),
	.cnt_o (cnt_tb)
);

initial
	begin
		#50;
		
		@(posedge clk_tb)
		#1;
		rst_tb <= 1;
		@(posedge clk_tb)
		#1;
		rst_tb <= 0;
		#18;
		@(posedge clk_tb)
		#1;
		rst_tb <= 1;
		
		@(posedge clk_tb)
		#1;
		rst_tb <= 0;
	end
endmodule
