module reg_file (
	input clk_i,
	input [4:0] addr1_i,
	input [4:0] addr2_i,
	input [4:0] addr3_i,
	input we3_en_i,
	input [31:0] wd3_i,
	output logic [31:0] rd1_o,
	output logic [31:0] rd2_o	
);

logic [31:0] mem_reg_file [31:0]  = '{32'h00000000, 32'h00000001, 32'h00000002, 32'h00000003, 32'h00000004, 32'h00000005,32'h00000006,32'h00000007,
												  32'h00000008, 32'h00000009, 32'h0000000A, 32'h0000000B, 32'h0000000C, 32'h0000000D,32'h0000000E,32'h0000000F,
											     32'h00000010, 32'h00000011, 32'h00000012, 32'h00000013, 32'h00000014, 32'h00000015,32'h00000016,32'h00000017,
											     32'h00000018, 32'h00000019, 32'h0000001A, 32'h0000001B, 32'h0000001C, 32'h0000001D,32'h0000001E,32'h0000001F};

always_ff @(posedge clk_i)
		if (we3_en_i)
			begin
				mem_reg_file[addr3_i] <= wd3_i;
				rd1_o <= mem_reg_file[addr1_i];
				rd2_o <= mem_reg_file[addr2_i];
			end
		else	
			begin
				rd1_o <= mem_reg_file[addr1_i];
				rd2_o <= mem_reg_file[addr2_i];
			end
			
endmodule




