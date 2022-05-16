module top(mips_top tif);

	controlUnit u1 (tif.controlUnit);

	instr_reg u2 (tif.instr_reg);

	instr_memory u3 (tif.instr_memory);

	reg_file u4 (tif.reg_file);

	alu u5 (tif.alu);

	ALUControl u6 (tif.ALUControl);

	ProgramCounter u7 (tif.ProgramCounter);

	mult_2to1_4 u8 (tif.mult_2to1_4);

	mult_2to1_3 u9 (tif.mult_2to1_3);

	mult_2to1_2 u10 (tif.mult_2to1_2);

	mult_2to1_1 u11 (tif.mult_2to1_1);

	mult_3to1 u12 (tif.mult_3to1);


	mult_4to1 u13 (tif.mult_4to1);

	sign_extend u14 (tif.sign_extend);


	multiplyBy4 u15 (tif.multiplyBy4); 

endmodule