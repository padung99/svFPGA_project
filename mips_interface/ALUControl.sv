module ALUControl (mips_top.ALUControl ALUControl_if);
//	input [1:0] ALUControl_if.ALUOp,
//	input [5:0] ALUControl_if.instr[5:0],
//	output logic [2:0] ALUControl_if.aluControl_top
//);

always_comb
	begin
	ALUControl_if.aluControl_top = 3'bxxx;
		case (ALUControl_if.ALUOp)
			2'b00: ALUControl_if.aluControl_top = 3'b010;
			2'b01: ALUControl_if.aluControl_top = 3'b110;
			2'b10:
				begin
					if (ALUControl_if.instr[5:0] == 6'b100000)
						ALUControl_if.aluControl_top = 3'b010;
					if (ALUControl_if.instr[5:0] == 6'b100010)
						ALUControl_if.aluControl_top = 3'b110;
					if (ALUControl_if.instr[5:0] == 6'b100100)
						ALUControl_if.aluControl_top = 3'b000;
					if (ALUControl_if.instr[5:0] == 6'b100101)
						ALUControl_if.aluControl_top = 3'b001;
					if (ALUControl_if.instr[5:0] == 6'b101010)
						ALUControl_if.aluControl_top = 3'b111;
				end
			2'b11: ALUControl_if.aluControl_top = 3'bxxx;
		endcase
	end 

endmodule

