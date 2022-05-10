module Ex11;

typedef enum {Add = 2'b00, Sub = 2'b01, Bit_wise_invert = 2'b10, Reduction_Or = 2'b11} opcode_e;

opcode_e opcode;
initial
begin
	//$display("opcode = %0s", opcode);
	do
		begin
			$display("opcode = %0d/%0s", opcode, opcode); //opcode.name()
			opcode = opcode.next();
		end
	while(opcode != opcode.first);
end
endmodule