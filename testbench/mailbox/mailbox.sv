module mailbox;
mailbox #(int) my_mb = new();

initial
	begin
		forever 
			begin
				#1;
				my_mb.put($urandom_range(10,1));
				//my_mb.put($urandom_range(10,1));
				$display("[%0t] Thread 0: %0d elements", $time, my_mb.num());
			end
	end
int value;

initial
	begin
		forever
			begin
				#5;
				my_mb.get(value);
				$display("[%0t] Thread 1: %0d", $time, value);
			end
	end
endmodule