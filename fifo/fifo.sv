module fifo #(parameter DEPTH_BIT = 2, parameter WIDTH = 4)
(
	input clk_i,
	input [WIDTH-1:0] wr_data_i,
	input wr_req_i,
	input rd_req_i,
	input rst_i,
	output[WIDTH-1:0] rd_data_o,
	output full_o,
	output empty_o
);

localparam EXTEND_ADDR =  DEPTH_BIT +1;

logic [WIDTH-1: 0] p0_data_i, p1_data_o;
logic [EXTEND_ADDR-1:0] p0_wr_addr_i = 0, p1_rd_addr_i = 0;
bit empty, full;
logic [2**DEPTH_BIT-1:0]mem[WIDTH-1:0] ; 

always_ff @(posedge clk_i or posedge rst_i)
	if (rst_i)
		begin
			p0_wr_addr_i <= '0;
			p1_rd_addr_i <= '0;
		end
	else
		begin
			if (wr_req_i && !full_o)
				p0_wr_addr_i <= p0_wr_addr_i +1;
			if (rd_req_i && !empty_o)
				p1_rd_addr_i <= p1_rd_addr_i +1;
		end

always_ff @(posedge clk_i)
	begin
		if (wr_req_i )
				mem[p0_wr_addr_i] <= wr_data_i;
	end


always_ff @(posedge clk_i)
	begin
		if (rd_req_i)			
				p1_data_o <= mem[p1_rd_addr_i];				
	end


assign rd_data_o = p1_data_o;
assign empty_o = (p0_wr_addr_i == p1_rd_addr_i)?1:0;
assign full_o = ((p0_wr_addr_i[DEPTH_BIT-1:0] == p1_rd_addr_i[DEPTH_BIT-1:0])
						&& (p0_wr_addr_i[EXTEND_ADDR-1] != p1_rd_addr_i[EXTEND_ADDR-1]))?1:0;

endmodule
