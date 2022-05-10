module sign_extend (mips_top.sign_extend sign_extend_if);
//	input [15:0] sign_extend_if.instr[15:0],
//	output [31:0] sign_extend_if.Imm
//);


assign sign_extend_if.Imm = 32'(unsigned'(sign_extend_if.instr[15:0]));

endmodule
