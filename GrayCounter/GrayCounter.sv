module GrayCounter #(parameter SIZE = 10, parameter BIT_SIZE = 4, parameter INCREMENT = 1)(
	input clk_i,
	input rst_i,
	output [BIT_SIZE-1:0] cnt_o
);

logic [BIT_SIZE-1:0] gray_i, gray_o, bin_i, bin_o, gray_reg_i, gray_reg_o;

always_ff @(posedge clk_i)
	begin
		if (rst_i)
			gray_reg_o <= (BIT_SIZE)'(0);
		else
			gray_reg_o <= gray_reg_i;
	end

assign gray_i = gray_reg_o;

always_comb
	begin
		//Gray to binary converter
		for (int i =0; i < BIT_SIZE; i++)
				gray_o[i] = ^(gray_i >> i);
		
		bin_i = gray_o;
		bin_i = bin_i + INCREMENT;
		
		//Binary to gray convertor
		bin_o = bin_i ^ (bin_i >> 1);
		gray_reg_i = bin_o; 
	end
	
assign cnt_o =  gray_reg_o;
endmodule
