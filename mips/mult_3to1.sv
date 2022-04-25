module mult_3to1 (
	input p00_i,
	input p01_i,
	input p10_i,
	input sel_i,
	output res_o
);

always_comb
	case (sel_i)
		2'b00: res_o = p00_i;
		2'b01: res_o = p01_i;
		2'b10: res_o = p10_i;
	endcase
endmodule
