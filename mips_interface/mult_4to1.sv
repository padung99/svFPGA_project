module mult_4to1 (mips_top.mult_4to1 mult_4to1_if);
//	input [31:0] mult_4to1_if.WriteData,
//	input [31:0] mult_4to1_if.p01_i_4to1,
//	input [31:0] mult_4to1_if.Imm,
//	input [31:0] mult_4to1_if.Immx4,
//	input [1:0] mult_4to1_if.ALUSrcB,
//	output logic [31:0] mult_4to1_if.srcB
//);

always_comb
	case (mult_4to1_if.ALUSrcB)
		2'b00: mult_4to1_if.srcB = mult_4to1_if.WriteData;
		2'b01: mult_4to1_if.srcB = mult_4to1_if.p01_i_4to1;
		2'b10: mult_4to1_if.srcB = mult_4to1_if.Imm;
		2'b11: mult_4to1_if.srcB = mult_4to1_if.Immx4;
	endcase
endmodule
