module Ex1;

integer array[512];
logic 		 [8:0] addr;

task automatic my_task(const ref integer array_t[512],
			 input logic [8:0] addr_t);
	print_int(array_t[addr_t]);
	
	print_int(array_t[addr_t-1]);
endtask

function print_int(integer element);
		$display("[%0t] input: %0d", $time, element);
endfunction

initial
	begin
		array[511] = 5;
		my_task(array, 511);
	end
endmodule
