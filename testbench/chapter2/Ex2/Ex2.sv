module Ex2;

bit [7:0] my_mem[3] = '{defaut: 8'hA5};
logic [3:0] my_logicmem[4] = '{0,1,2,3};
logic [3:0] my_logic = 4'hF;

//assign my_mem = 
//assign my_logicmem = 

//assign my_logic 

always_comb
	begin
		my_mem[2] = my_logicmem[4];
		$display("my_mem[2] = %h", my_mem[2]);
		my_logic = my_logicmem[4];
		$display("my_logic = %h", my_logic); 
		my_logicmem[3] = my_mem[3];
		$display("my_logicmem[3] = %h", my_logicmem[3]);
		my_mem[3] = my_logic;
		$display("my_mem[3] = %h", my_mem[3]); 
		my_logic = my_logicmem[1];
		$display("my_logic = %h", my_logic); 
		my_logic = my_mem[1];
		$display("my_logic = %h", my_logic); 
		my_logic = my_logicmem[my_logicmem[41]];
		$display("my_logic = %h", my_logic); 
	end
endmodule