module mult_2to1_1 (mips_top.mult_2to1_1 mult_2to1_1_if);
//	input [31:0] mult_2to1_1_if.A_if.PC,
//	input [31:0] mult_2to1_1_if.A,
//	input mult_2to1_1_if.sel_i,
//	output logic [31:0] mult_2to1_1_if.srcA
//);

always_comb
	case (mult_2to1_1_if.sel_i)
		1'b1: mult_2to1_1_if.srcA = mult_2to1_1_if.A;
		1'b0: mult_2to1_1_if.srcA = mult_2to1_1_if.PC;
	endcase
endmodule
