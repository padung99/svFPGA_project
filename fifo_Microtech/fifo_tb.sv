module fifo_tb;
parameter DATA_W_TB = 5;
parameter ADDR_W_TB = 4;

bit clk_tb, rst_i_tb, wr_req_i_tb, full_o_tb, empty_o_tb, rd_req_i_tb;
logic [DATA_W_TB-1:0] wr_data_i_tb, rd_data_o_tb;
initial 
	forever 
	#5 clk_tb = !clk_tb;
	
fifo_Microtech #(
  .DATA_W (DATA_W_TB),
  .ADDR_W (ADDR_W_TB)
) fifo_ins(
  .clk_i (clk_tb),
  .s_rst_i(rst_i_tb),

  .wr_req_i(wr_req_i_tb),
  .wr_data_i(wr_data_i_tb),
  .full_o(full_o_tb),

  .rd_req_i(rd_req_i_tb),
  .rd_data_o(rd_data_o_tb),
  .empty_o(empty_o_tb)
);	

initial 
	begin
		wr_data_i_tb = 4'b0;
		wr_req_i_tb = 1;
		rd_req_i_tb = 0;
		rst_i_tb = 1;
		
		
		@(posedge clk_tb)
		wr_data_i_tb <= 4'b0001;
		wr_req_i_tb <= 1;
		rd_req_i_tb <= 0;
		rst_i_tb <= 0;
			
		@(posedge clk_tb)
		wr_data_i_tb <= 4'b0010;
		wr_req_i_tb <= 1;
		rd_req_i_tb <= 0;
		rst_i_tb <= 0;
		
		@(posedge clk_tb)
		wr_data_i_tb <= 4'b0011;
		wr_req_i_tb <= 1;
		rd_req_i_tb <= 0;
		rst_i_tb <= 0;
		
		@(posedge clk_tb)
		wr_req_i_tb <= 0;
		rd_req_i_tb <= 0;
		rst_i_tb <= 0;
		
		@(posedge clk_tb)
		wr_req_i_tb <= 0;
		rd_req_i_tb <= 1;
		rst_i_tb <= 0;
		
		@(posedge clk_tb)
		//wr_data_i_tb = 4'b0100;
		wr_req_i_tb <= 0;
		rd_req_i_tb <= 1;
		rst_i_tb <= 0;
		
		@(posedge clk_tb)
		//wr_data_i_tb = 4'b0101;
		wr_req_i_tb <= 0;
		rd_req_i_tb <= 1;
		rst_i_tb <= 0;	
		
		@(posedge clk_tb)
		//wr_data_i_tb = 4'b0111;
		wr_req_i_tb <= 0;
		rd_req_i_tb <= 1;
		rst_i_tb <= 0;
		
		@(posedge clk_tb)
		//wr_data_i_tb = 4'b1110;
		wr_req_i_tb <= 0;
		rd_req_i_tb <= 1;
		rst_i_tb <= 0;
		
		@(posedge clk_tb)
		//wr_data_i_tb = 4'b1000;
		wr_req_i_tb <= 0;
		rd_req_i_tb <= 1;
		rst_i_tb <= 0;
		
		@(posedge clk_tb)
		wr_data_i_tb <= 4'b1111;
		wr_req_i_tb <= 1;
		rd_req_i_tb <= 1;
		rst_i_tb <= 0;
	end
	
endmodule
