module controlUnit (mips_top.controlUnit controlUnit_if);
//	input controlUnit_if.rst_i_top,
//	input controlUnit_if.clk_i_top,
//	input [5:0] controlUnit_if.instr[31:26],
//	input [5:0] controlUnit_if.instr[5:0],
//	output controlUnit_if.fetch_en,
//	output controlUnit_if.IorD,
//	output controlUnit_if.MemWrite,
//	output [3:0] controlUnit_if.IRWrite ,
//	output controlUnit_if.RegWrite ,
//	output controlUnit_if.ALUSrcA ,
//	output [1:0] controlUnit_if.ALUSrcB ,
//	output [1:0] controlUnit_if.ALUOp ,
//	output [1:0] controlUnit_if.PCSrc ,
//	output controlUnit_if.Branch ,
//	output controlUnit_if.PCWrite ,
//	output controlUnit_if.RegDst ,
//	output controlUnit_if.MemtoReg 
//);

bit fetch_en = 'x;
bit IorD = 'x;
bit MemWrite = 'x;
logic [3:0] IRWrite = 'x;
bit RegWrite = 'x;
bit ALUSrcA = 'x; 
logic [1:0] ALUSrcB = 'x;
logic [1:0] ALUOp = 'x;
logic [1:0] PCSrc = 'x;
bit Branch = 'x;
bit PCWrite = 'x;
bit RegDst = 'x; 
bit MemtoReg = 'x;

enum logic [3:0] {
	RESET,
	STATE1,
	STATE2, 
	STATE3,
	REG_FETCH,
	MEM_ADRR_COMPUTATION,
	MEM_ACCESS_LW,
	WRITE_BACK,
	MEM_ACCESS_SW,
	EXECUTION,
	R_TYPE_COMPLETION,
	BRANCH_COMPLETION,
	JUMP_COMPLETION
} state, next_state;


//State will be changed at the positive edge of clk signal 
always_ff @(posedge controlUnit_if.clk_i_top)
	if(controlUnit_if.rst_i_top)
		state <= RESET;
	else
		state <= next_state;

assign controlUnit_if.fetch_en = fetch_en;
assign controlUnit_if.IorD = IorD;
assign controlUnit_if.MemWrite =  MemWrite;
assign controlUnit_if.IRWrite = IRWrite;
assign controlUnit_if.RegWrite = RegWrite;
assign controlUnit_if.ALUSrcA = ALUSrcA;
assign controlUnit_if.ALUSrcB = ALUSrcB;
assign controlUnit_if.ALUOp = ALUOp;
assign controlUnit_if.PCSrc = PCSrc;
assign controlUnit_if.Branch = Branch;
assign controlUnit_if.PCWrite = PCWrite;
assign controlUnit_if.RegDst = RegDst;
assign controlUnit_if.MemtoReg = MemtoReg;

always_comb
	begin
		next_state = state;
		ALUSrcA = 'x;
		IorD = 'x;
		IRWrite = 'x;
		ALUSrcB = 'x;
		ALUOp = 'x;
		PCWrite  = 1'b1;
		PCSrc  = 'x;
		fetch_en  = 'x;
		Branch = 'x;
		RegDst = 'x;
		RegWrite = 'x;
		MemtoReg = 'x;
		MemWrite= 'x;
		
		case (state)
			RESET:
				begin
					ALUSrcA = 1'b0;
					IorD = 1'b0;
					IRWrite = 4'b0001;
					ALUSrcB = 2'b01;
					ALUOp = 2'b00;
					PCWrite  = 1'b1;
					PCSrc  = 2'b00;
					fetch_en  = 1'b0;
					
					next_state = STATE1;
				end
			
			STATE1:
				begin
					ALUSrcA  = 1'b0;
					IorD  = 1'b0;
					IRWrite  = 4'b0010;
					ALUSrcB  = 2'b01;
					ALUOp  = 2'b00;
					PCWrite  = 1'b1;
					PCSrc  = 2'b00;
					fetch_en  = 1'b0;
					
					next_state = STATE2;
				end

			STATE2:
				begin
					ALUSrcA  = 1'b0;
					IorD  = 1'b0;
					IRWrite  = 4'b0100;
					ALUSrcB  = 2'b01;
					ALUOp  = 2'b00;
					PCWrite  = 1'b1;
					PCSrc  = 2'b00;
					fetch_en  = 1'b0;	
					
					next_state = STATE3;
				end
				
			STATE3:
				begin
					ALUSrcA  = 1'b0;
					IorD  = 1'b0;
					IRWrite  = 4'b1000;
					ALUSrcB  = 2'b01;
					ALUOp  = 2'b00;
					PCWrite  = 1'b1;
					PCSrc  = 2'b00;
					fetch_en  = 1'b0;
					
					next_state = REG_FETCH;
				end
			
			REG_FETCH:
				begin
					ALUSrcA  = 1'b0;
					ALUSrcB  = 2'b11;
					ALUOp  = 2'b00;
					PCWrite  = 1'b0;
					fetch_en  = 1'b1;
					PCSrc  = 2'b11;
					
					if(controlUnit_if.instr[31:26] == 6'h0)
						next_state = EXECUTION;
					else if (controlUnit_if.instr[31:26] == 6'h4)
						next_state = BRANCH_COMPLETION;
					else if (controlUnit_if.instr[31:26] == 6'h2)
						next_state = JUMP_COMPLETION;
					else if (controlUnit_if.instr[31:26] == 6'h2b || controlUnit_if.instr[31:26] == 6'h23)  //lw(load word): 0x23, sw (store word): 0x2b
						next_state = MEM_ADRR_COMPUTATION;
				end
			
			EXECUTION:
				begin
					ALUSrcA  = 1'b1;
					ALUSrcB  = 2'b00;
					ALUOp  = 2'b10;
					PCSrc  = 2'b11;
					
					next_state = R_TYPE_COMPLETION;
				end
			
			R_TYPE_COMPLETION:
				begin
					RegDst  = 1'b1;
					RegWrite  = 1'b1;
					MemtoReg  = 1'b0;
					PCSrc  = 2'b11;
					
					next_state = RESET;
				end
			
			BRANCH_COMPLETION:
				begin
					ALUSrcA  = 1'b1;
					ALUSrcB  = 2'b00;
					ALUOp  = 2'b01;	
					Branch  = 1'b1;
					PCSrc  = 2'b01;
					
					next_state = RESET;
				end
			
			JUMP_COMPLETION:
				begin
					PCWrite  = 1'b1;
					PCSrc  = 2'b10;
					
					next_state = RESET;
				end
			
			MEM_ADRR_COMPUTATION:
				begin
					ALUSrcA  = 1'b1;
					ALUSrcB  = 2'b10;
					ALUOp  = 2'b00;
					PCSrc  = 2'b11;
					
					if(controlUnit_if.instr[31:26] == 6'h2b)
						next_state = MEM_ACCESS_SW;
					else if(controlUnit_if.instr[31:26] == 6'h23)
						next_state = MEM_ACCESS_LW;
				end
			
			MEM_ACCESS_SW:
				begin
					IorD  = 1'b1;
					MemWrite  = 1'b1;
					PCSrc  = 2'b11;
					
					next_state = RESET;
				end
			
			MEM_ACCESS_LW:
				begin
					IorD  = 1'b1;
					PCSrc  = 2'b11;
					
					next_state = WRITE_BACK;
				end
			
			WRITE_BACK:
				begin
					RegDst  = 1'b0;
					RegWrite  = 1'b1;
					MemtoReg = 1'b1;
					PCSrc  = 2'b11;
					
					next_state = RESET;
				end
			
			default: next_state = RESET;
		endcase
	end
	
	
endmodule
