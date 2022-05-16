interface mips_top(input clk_i_top);

	bit fetch_en, rst_i_top;
	bit IorD;
	bit MemWrite;
	logic [3:0] IRWrite;
	bit RegWrite;
	bit ALUSrcA; 
	logic [1:0] ALUSrcB;
	logic [1:0] ALUOp;
	logic [1:0] PCSrc;
	bit Branch;
	bit PCWrite;
	bit RegDst; 
	bit MemtoReg;
	bit [31:0] p01_i_4to1;
	//logic Adr;
	logic [31:0] instr, A, WriteData, srcA, srcB, ALUResult, ALUOut, PCNext, Data, WD3, Imm, Immx4, PC, Adr, PCNext2;
	logic [3:0] MemData;
	bit Zero;
	logic [7:0] instr8bit_top;
	logic [2:0] aluControl_top;
	bit PCEn;
	logic [4:0] A3;

	assign PCEn = PCWrite | (Zero & Branch);
	assign p01_i_4to1 = 32'h00000001;
	
	modport controlUnit (
		input  clk_i_top,
				 instr,
				 rst_i_top,
		output fetch_en,
				 IorD,
				 MemWrite,
				 IRWrite,
				 RegWrite,
				 ALUSrcA,
				 ALUSrcB,
				 ALUOp,
				 PCSrc,
				 Branch,
				 PCWrite,
				 RegDst,
				 MemtoReg 
	);

	modport instr_reg (
		input  IRWrite, instr8bit_top, fetch_en, 
		output instr
	);

	modport instr_memory (
		input  clk_i_top, MemWrite, Adr, WriteData,
		output instr8bit_top
	);

	modport reg_file (
		input clk_i_top, instr, A3, RegWrite, WD3, //////////
		output A, WriteData
	);

	modport alu (
		//.clk_i(clk_i_top),
		input  srcA, srcB, aluControl_top,
		output Zero, ALUResult
	);

	modport ALUControl (
		input  ALUOp, instr, 
		output aluControl_top
	);

	modport ProgramCounter (
		input  clk_i_top, PCEn, PCNext,
		output PC
	);

	modport mult_2to1_4 (
		input  PC, ALUOut, IorD,
		output Adr
	);

	modport mult_2to1_3 (
		input instr, RegDst,
		output A3
	);

	modport mult_2to1_2 (
		input ALUOut, instr, MemtoReg,
		output WD3
	);

	modport mult_2to1_1 (
		input PC, A, ALUSrcA,
		output srcA
	);

	modport mult_3to1 (
		input ALUResult, ALUOut, Immx4, PC, PCSrc,
		output PCNext
	);


	modport mult_4to1 (
		input WriteData, p01_i_4to1, Imm, Immx4, ALUSrcB,
		output srcB
	);

	modport sign_extend (
		input instr,
		output Imm
	);


	modport multiplyBy4 (
		input Imm,
		output Immx4
	); 

	always_ff @(posedge clk_i_top)
		ALUOut <= ALUResult;
endinterface 