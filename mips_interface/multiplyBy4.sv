module multiplyBy4(mips_top.multiplyBy4 multiplyBy4_if);
//	input [31:0] multiplyBy4_if.Imm,
//	output logic [31:0] multiplyBy4_if.Immx4
//); 

assign multiplyBy4_if.Immx4 =  multiplyBy4_if.Imm << 2;

endmodule
