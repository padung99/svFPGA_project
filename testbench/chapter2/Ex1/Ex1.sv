module Ex1;
byte my_byte;
integer my_integer = 32'b000_1111_xxxx_zzzz;
int my_int = my_integer;
bit [15:0] my_bit = 16'h8000;
shortint my_short_int1 = my_bit;
shortint my_short_int2 = my_short_int1-1;

initial
	begin
		$display("1. Range of value my_byte: %0d", 2**$bits(my_byte));
		$display("2. Vale of my_int in hex: %h", my_integer);
		$display("3. Value of my_bit in decimal: %0d", my_bit);
		$display("4. Value of my_short_int1 in decimal: %0d", my_short_int1);
		$display("5. Value of my_short_int2 in decimal: %0d", my_short_int2);
	end
endmodule