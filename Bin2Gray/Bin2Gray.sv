module Bin2Gray #(parameter SIZE = 4) 
(
	input [SIZE-1:0] bin_i,
	output [SIZE-1:0] gray_o
);

//Formular:
//gray[0] = bin[0] ^ bin[1]
//gray[1] = bin[1] ^ bin[2]
//gray[2] = bin[2] ^ bin[3]
//gray[3] = bin[3] ^ 1'b0


//	bin[3]	  bin[2]  bin[1]  bin[0]
//^
//	1'b0		  bin[3]  bin[2]  bin[1]
//	-------------------------------
//	gray[3]    gray[2] gray[1] gray[0]
	

logic [SIZE-1:0] gray;
assign gray = (bin_i>>1) ^ bin_i;

endmodule
