module alu (mips_top.alu ALU_if);
//	//input clk_i,
//	input [31:0] ALU_if.srcA,
//	input [31:0] ALU_if.srcB,
//	input [2:0] aluControl_i,
//	output logic  zero_o,
//	output logic [31:0] ALU_if.ALUResult
//);

always_comb
	begin
		case (ALU_if.aluControl_top)
			3'b010: begin
					ALU_if.Zero = (ALU_if.srcA == ALU_if.srcB)?1:0;
					ALU_if.ALUResult = ALU_if.srcA + ALU_if.srcB; //ADD
				end
				
			3'b110: begin
					ALU_if.Zero = (ALU_if.srcA == ALU_if.srcB)?1:0;
					ALU_if.ALUResult = ALU_if.srcA - ALU_if.srcB; //SUB
				end
				
			3'b000: begin
					ALU_if.Zero = (ALU_if.srcA == ALU_if.srcB)?1:0;
					ALU_if.ALUResult = ALU_if.srcA & ALU_if.srcB; //AND
				end
				
			3'b001: begin
					ALU_if.Zero = (ALU_if.srcA == ALU_if.srcB)?1:0;
					ALU_if.ALUResult = ALU_if.srcA | ALU_if.srcB; //OR
				end
				
			3'b111: begin
					ALU_if.Zero = (ALU_if.srcA == ALU_if.srcB)?1:0;
					ALU_if.ALUResult = ALU_if.srcA < ALU_if.srcB?1:0; //SLT
				end
			default: begin
					ALU_if.Zero = (ALU_if.srcA == ALU_if.srcB)?1:0;
					ALU_if.ALUResult = ALU_if.srcA < ALU_if.srcB?1:0; //SLT
				end
		endcase
	end
//assign zero_o = (ALU_if.srcA == ALU_if.srcB)?1:0;
endmodule

