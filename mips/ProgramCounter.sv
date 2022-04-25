module ProgramCounter (
	input clk_i,
	input en_i,
	input addr_i,
	output addr_o
);

logic o_addr;

always_ff @(posedge clk_i)
		if (en_i)
			o_addr <= addr_i;

assign addr_o = o_addr;
endmodule


