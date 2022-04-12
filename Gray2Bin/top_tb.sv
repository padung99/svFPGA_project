module top_tb;
bit clk;

parameter SIZE_TB = 4;
logic [SIZE_TB-1:0] gray_tb;
logic [SIZE_TB-1:0] bin_tb;

initial
	forever
	#5 clk = !clk;
	
Gray2Bin #(.SIZE (SIZE_TB)) Gray2Bin_inst (
	.Gray_i(gray_tb),
	.Bin_o(bin_tb)
);

initial
	begin
		#12;
		gray_tb = 4'b0110;
	
		#10;
		gray_tb = 4'b0101;
		
		#11;
		gray_tb = 4'b1001;
		
		#13;
		gray_tb = 4'b1101;
		
		#14;
		gray_tb = 4'b1111;
		
	end
endmodule
