module top_tb;
parameter SIZE_tb = 4;

logic [SIZE_tb-1:0] Bin_i_tb;
logic [SIZE_tb-1:0] Gray_o_tb;

Bin2Gray #(.SIZE(SIZE_tb)) Bin2Gray_inst(
 .bin_i (Bin_i_tb),
 .gray_o (Gray_o_tb)
);


initial 
	begin
		#12;
		Bin_i_tb = 4'b0110;
	
		#10;
		Bin_i_tb = 4'b0101;
		
		#11;
		Bin_i_tb = 4'b1001;
		
		#13;
		Bin_i_tb = 4'b1101;
		
		#14;
		Bin_i_tb = 4'b1111;
	end
endmodule
