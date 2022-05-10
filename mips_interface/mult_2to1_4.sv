module mult_2to1_4 (mips_top.mult_2to1_4 mult_2to1_4_if);
//	input [31:0] mult_2to1_4_if.PC,
//	input [31:0] mult_2to1_4_if.ALUOut,
//	input mult_2to1_4_if.IorD,
//	output logic [31:0] mult_2to1_4_if.Adr
//);

always_comb
	case (mult_2to1_4_if.IorD)
		1'b1: mult_2to1_4_if.Adr = mult_2to1_4_if.ALUOut;
		1'b0: mult_2to1_4_if.Adr = mult_2to1_4_if.PC;
	endcase
endmodule
