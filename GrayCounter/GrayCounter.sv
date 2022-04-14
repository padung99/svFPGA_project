module GrayCounter #(parameter SIZE = 16, parameter BIT_SIZE = 4, parameter INCREMENT = 1)(
	input clk_i,
	input rst_i,
	output [BIT_SIZE-1:0] cnt_o
);

logic [BIT_SIZE-1:0] gray_i, gray_o, bin_i, bin_o, gray_reg_i, gray_reg_o;

//1st variant (Using many combinational logic gates)
//always_ff @(posedge clk_i)
//	begin
//		if (rst_i)
//			gray_reg_o <= (BIT_SIZE)'(0);
//		else
//			gray_reg_o <= gray_reg_i;
//	end
//
//assign gray_i = gray_reg_o;
//
//
//always_comb
//	begin
//		//Gray to binary converter
//		for (int i =0; i < BIT_SIZE; i++)
//				gray_o[i] = ^(gray_i >> i);
//		
//		bin_i = gray_o;
//		bin_i = bin_i + INCREMENT;
//		
//		//Binary to gray convertor
//		bin_o = bin_i ^ (bin_i >> 1);
//		gray_reg_i = bin_o; 
//	end
//	
//assign cnt_o =  gray_reg_o;

/////////////////////////////////////////////////////
//always_ff @(posedge clk_i)
//	begin
//		if (rst_i)
//			bin_o <= 0;
//		else
//			bin_o <= bin_o + INCREMENT;
//	end
//	
//
////Binary to gray convertor
//assign gray_i = (bin_o >> 1) ^ bin_o;
//	
//assign cnt_o = gray_i;

////////////////////
logic [BIT_SIZE-1:0] bin, bnext, gray, gnext;
always_ff @(posedge clk_i)
	begin
		if (rst_i)
			{bin, gray} <= 0;
		else
			{bin, gray} <= {bnext, gnext};
	end
	
	assign bnext = bin + INCREMENT;
	assign gnext = (bnext >>1 ) ^ bnext;
	
assign cnt_o = gray;

endmodule

