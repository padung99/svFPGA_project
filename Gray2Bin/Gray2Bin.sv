module Gray2Bin #(parameter SIZE  = 4)
(
	input [SIZE-1:0] Gray_i,
	output [SIZE-1: 0] Bin_o
	
);


logic [SIZE-1:0] bin;
logic tmp;

//formular
//bin[0] = gray[3] ^  gray[2] ^ gray[1] ^ gray[0]
//bin[1] = gray[3] ^  gray[2] ^ gray[1] 
//bin[2] = gray[3] ^  gray[2] 
//bin[3] = gray[3]

//1-st variant
//always_comb
//	begin
//		for (int i = 0; i < SIZE ; i++)
//		begin
//			for (int j = SIZE - 1; j >= i; j--)
//				begin
//					if(j == SIZE - 1)
//						begin
//							tmp = Gray_i[SIZE - 1];
//							continue;
//						end
//					tmp = tmp ^ Gray_i[j];
//				end
//			bin[i] = tmp;
//		end
//	end
//assign Bin_o = bin;

////2-nd variant
always_comb
	for (int i = 0; i < SIZE; i++)
		bin[i] = ^(Gray_i >> i);
assign Bin_o = bin;
endmodule
