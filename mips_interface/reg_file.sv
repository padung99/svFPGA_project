module reg_file (mips_top.reg_file reg_file_if);
//	input reg_file_if.clk_i_top,
//	input [4:0] reg_file_if.instr[25:21],
//	input [4:0] reg_file_if.instr[20:16],
//	input [4:0] reg_file_if.A3,
//	input reg_file_if.RegWrite,
//	input [31:0] reg_file_if.WD3,
//	output logic [31:0] reg_file_if.A,
//	output logic [31:0] reg_file_if.WriteData	
//);												//    [31:0]		

logic [31:0] mem_reg_file [31:0]  = '{32'h00000000,		//31
												  32'h00000001,		//30
												  32'h00000002,		//29
												  32'h00000003,		//28
												  32'h00000004,		//27
												  32'h00000005,		//26
												  32'h00000006,		//25
												  32'h00000007,   	//24
												  32'h00000008,		//23
												  32'h00000009,		//22
												  32'h0000000A,		//21
												  32'h0000000B,   	//20
												  32'h0000000C,		//19
												  32'h0000000D,		//18
												  32'h0000000E,		//17
												  32'h0000000F,   	//16
											     32'h00000010,		//15
												  32'h00000011,		//14
												  32'h00000012,		//13
												  32'h00000013,   	//12
												  32'h00000014,		//11
												  32'h00000015,		//10
												  32'h00000016,		//9
												  32'h00000017,   	//8
											     32'h00000018,		//7
												  32'h00000019,		//6
												  32'h0000001A,		//5
												  32'h0000001B,		//4
												  32'h0000001C,		//3
												  32'h0000001D,		//2
												  32'h0000001E,		//1
												  32'h0000001F};		//0

always_ff @(posedge reg_file_if.clk_i_top)
		if (reg_file_if.RegWrite)
			begin
				mem_reg_file[reg_file_if.A3] <= reg_file_if.WD3;
				reg_file_if.A <= mem_reg_file[reg_file_if.instr[25:21]];
				reg_file_if.WriteData <= mem_reg_file[reg_file_if.instr[20:16]];
			end
		else	
			begin
				reg_file_if.A <= mem_reg_file[reg_file_if.instr[25:21]];
				reg_file_if.WriteData <= mem_reg_file[reg_file_if.instr[20:16]];
			end
			
endmodule




