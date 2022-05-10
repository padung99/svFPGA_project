module ProgramCounter (mips_top.ProgramCounter ProgramCounter_if);
//	input ProgramCounter_if.clk_i_top,
//	input ProgramCounter_if.PCEn,
//	input [31:0] ProgramCounter_if.PCNext,
//	output logic [31:0] ProgramCounter_if.PC
//);

logic [31:0] addr_out;

always_ff @(posedge ProgramCounter_if.clk_i_top)
		if (ProgramCounter_if.PCEn)
			addr_out <= ProgramCounter_if.PCNext;

assign ProgramCounter_if.PC = addr_out;
endmodule


