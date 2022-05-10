module instr_reg (mips_top.instr_reg instr_reg_if);
//	input [3:0] instr_reg_if.IRWrite,
//	input [7:0] instr_reg_if.instr8bit_top,
//	input bit instr_reg_if.fetch_en, 
//	output logic [31:0] instr_reg_if.instr	
//);

logic [3:0][7:0] instr_data;
bit IRWrite0_i, IRWrite1_i, IRWrite2_i, IRWrite3_i;

always_comb
	begin	
		if (instr_reg_if.fetch_en)
			instr_reg_if.instr = instr_data;
		else
			begin
				if(instr_reg_if.IRWrite[3])
					instr_data[0] =  instr_reg_if.instr8bit_top;
				if(instr_reg_if.IRWrite[2])
					instr_data[1] =  instr_reg_if.instr8bit_top;
				if(instr_reg_if.IRWrite[1])
					instr_data[2] =  instr_reg_if.instr8bit_top;
				if(instr_reg_if.IRWrite[0])
					instr_data[3] =  instr_reg_if.instr8bit_top;
				instr_reg_if.instr = instr_data;
			end
	end

endmodule


