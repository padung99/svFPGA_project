module alu (
	input clk_i,
	input [31:0] srcA_i,
	input [31:0] srcB_i,
	input [2:0] aluControl_i,
	output zero_o,
	output logic [31:0] aluResult_o
);

always_ff @(posedge clk_i)
begin
	case (aluControl_i)
		3'b010: aluResult_o <= srcA_i + srcB_i; //ADD
		3'b110: aluResult_o <= srcA_i - srcB_i; //SUB
		3'b000: aluResult_o <= srcA_i & srcB_i; //AND
		3'b001: aluResult_o <= srcA_i | srcB_i; //OR
		3'b111: aluResult_o <= srcA_i < srcB_i?1:0; //SLT
	endcase
end
	assign zero_o = (srcA_i == srcB_i)?1:0;
endmodule

