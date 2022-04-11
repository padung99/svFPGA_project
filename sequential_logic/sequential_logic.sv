module sequential_logic (
	input clk_i,
	input [7:0] a_i,
	input [7:0] b_i,
	input  c_i,
	input  d_i,
	output logic res_o
);

logic [8:0] e;
logic e_or;
logic f;
logic g;

always_ff @(posedge clk_i)
	begin
		e <= a_i +b_i;
		e_or <= |e;
		f <= c_i ^ d_i;
		g <= f && !e_or;
		res_o <= g;
	end
endmodule