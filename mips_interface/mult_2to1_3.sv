module mult_2to1_3 (mips_top.mult_2to1_3 mult_2to1_3_if);
//	input [31:0] mult_2to1_3_if.instr[20:16],
//	input [31:0] mult_2to1_3_if.instr[15:11],
//	input mult_2to1_3_if.RegDst,
//	output logic [31:0] mult_2to1_3_if.A3
//);

always_comb
	case (mult_2to1_3_if.RegDst)
		1'b1: mult_2to1_3_if.A3 = mult_2to1_3_if.instr[15:11];
		1'b0: mult_2to1_3_if.A3 = mult_2to1_3_if.instr[20:16];
	endcase
endmodule
