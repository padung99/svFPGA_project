module mult_3to1 (mips_top.mult_3to1 mult_3to1_if);
//	input [31:0] mult_3to1_if.WriteData,
//	input [31:0] mult_3to1_if.ALUOut,
//	input [31:0] mult_3to1_if.Immx4,
//	input [31:0] mult_3to1_if.PC,
//	input logic [1:0] mult_3to1_if.PCSrc,
//	output logic [31:0] mult_3to1_if.PCNext
//);

always_comb
	begin
		//mult_3to1_if.PCNext =  '0;
		case (mult_3to1_if.PCSrc)
			2'b00: mult_3to1_if.PCNext = mult_3to1_if.ALUResult;
			2'b01: mult_3to1_if.PCNext = mult_3to1_if.ALUOut;
			2'b10: mult_3to1_if.PCNext = mult_3to1_if.Immx4;
			2'b11: mult_3to1_if.PCNext = mult_3to1_if.PC; //connect 1 more wire to save pre value counter
			default: mult_3to1_if.PCNext = '0;
		endcase
	end
endmodule
