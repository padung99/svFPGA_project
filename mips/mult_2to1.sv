module mult_2to1 (
	input p0_i,
	input p1_i,
	input sel_i,
	output res_o
);

always_comb
	case (sel_i)
		1'b1: res_o = p1_i;
		1'b0: res_o = p0_i;
	endcase
endmodule
