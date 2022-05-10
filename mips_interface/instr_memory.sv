module instr_memory (mips_top.instr_memory instr_memory_if);
//	input instr_memory_if.clk_i_top,
//	input instr_memory_if.MemWrite,
//	input [31:0] instr_memory_if.Adr,
//	input [31:0] instr_memory_if.WriteData,
//	output logic [7:0] instr_memory_if.instr8bit_top
//);

//logic [7:0] mem [35:0] = '{8'h08,8'h00,8'h03,8'h20,    8'h01,8'h00,8'h04,8'h20,   8'hff,8'hff,8'h05,8'h20,   8'h04,8'h00,8'h60,8'h10,
//									8'h20,8'h20,8'h85,8'h00,    8'h22,8'h28,8'h85,8'h00,   8'hff,8'hff,8'h63,8'h20,   8'h00,8'h00,8'h00,8'h08, 
//									8'hff,8'h00,8'h04,8'h2b};

logic [7:0] mem [3:0] = '{8'h20,8'h20,8'h85,8'h00};
//'{32'h20030008, 32'h20040001, 32'h2005ffff, 32'h10600004, 32'h00852020, 32'h00852822, 32'h2063ffff, 32'h08000003, 32'ha00400ff};
//Fibonacci
//addi $3, $0, 		8 001000 00000 00011 0000000000001000 20030008
//addi $4, $0, 	 	1 001000 00000 00100 0000000000000001 20040001
//addi $5, $0, -1 	001000 00000 00101 1111111111111111 2005ffff
//beq $3, $0, end 	000100 00011 00000 0000000000000100 10600004
//add $4, $4, $5 	000000 00100 00101 00100 00000 100000 00852020
//sub $5, $4, $5 	000000 00100 00101 00101 00000 100010 00852822
//addi $3, $3, -1 	001000 00011 00011 1111111111111111 2063ffff
//j loop 				000010 0000000000000000000000000011 08000003
//sb $4, 255($0) 	101000 00000 00100 0000000011111111 a00400ff

always_ff @(posedge instr_memory_if.clk_i_top)
	begin
		if (instr_memory_if.MemWrite)
				begin
					mem[instr_memory_if.Adr] <= instr_memory_if.WriteData[7:0]; //1st byte
					mem[instr_memory_if.Adr+1] <= instr_memory_if.WriteData[15:8]; //2nd byte
					mem[instr_memory_if.Adr+2] <= instr_memory_if.WriteData[23:16]; //3rd byte
					mem[instr_memory_if.Adr+3] <= instr_memory_if.WriteData[31:24]; //4th byte
				end
		else
			instr_memory_if.instr8bit_top <= mem[instr_memory_if.Adr];
	end
	
endmodule

