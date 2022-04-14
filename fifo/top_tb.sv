module top_tb;
parameter WIDTH_TB = 4;
parameter DEPTH_BIT_TB = 2;

bit clk_tb;

logic [WIDTH_TB-1:0] wr_data_i_tb;
bit wr_req_i_tb;
bit rd_req_i_tb;
logic [WIDTH_TB-1:0] rd_data_o_tb;
bit full_o_tb;
bit empty_o_tb;

initial
	forever
		#5 clk_tb = !clk_tb;

fifo #(.DEPTH_BIT(DEPTH_BIT_TB), .WIDTH(WIDTH_TB)) fifo_inst(
	.clk_i(clk_tb),
	.wr_data_i(wr_data_i_tb),
	.wr_req_i(wr_req_i_tb),
	.rd_req_i(rd_req_i_tb),
	.rd_data_o(rd_data_o_tb),
	.full_o(full_o_tb),
	.empty_o(empty_o_tb)
);

initial
	begin	
	wr_data_i_tb = 4'b0;
	wr_req_i_tb = 1;
	rd_req_i_tb = 0;
	
	@(posedge clk_tb)
	#1;
	wr_data_i_tb = 4'b0001;
	wr_req_i_tb = 1;
	rd_req_i_tb = 0;
		
	@(posedge clk_tb)
	#1;
	wr_data_i_tb = 4'b0010;
	wr_req_i_tb = 1;
	rd_req_i_tb = 0;
	
	@(posedge clk_tb)
	#1;
	wr_data_i_tb = 4'b0011;
	wr_req_i_tb = 1;
	rd_req_i_tb = 0;
	
	@(posedge clk_tb)
	wr_req_i_tb = 0;
	rd_req_i_tb = 0;
	@(posedge clk_tb)
	#1;
	rd_req_i_tb = 1;
	wr_req_i_tb = 0;
	end
endmodule
	