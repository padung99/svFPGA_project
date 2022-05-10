module mult_2to1_2 (mips_top.mult_2to1_2 mult_2to1_2_if);
//	input [31:0] mult_2to1_2_if.ALUOut,
//	input [31:0] mult_2to1_2_if.instr,
//	input mult_2to1_2_if.MemtoReg,
//	output logic [31:0] mult_2to1_2_if.WD3
//);

always_comb
	case (mult_2to1_2_if.MemtoReg)
		1'b1: mult_2to1_2_if.WD3 = mult_2to1_2_if.instr;
		1'b0: mult_2to1_2_if.WD3 = mult_2to1_2_if.ALUOut;
	endcase
endmodule
