module top_tb;

bit clk;
logic [6:0] led_segment_o;
logic [3:0] digit_o;

initial
	forever
		#5 clk =!clk;
	
Timer #(.cnt_before_1sec (100)) timer_inst ( //override parameters in module
	.clk_i (clk),
	.led_segment_o(led_segment_o),
	.digit_o(digit_o)
);


initial
	begin
		#5;
		 $display( led_segment_o );
		 $display( digit_o );
	end
endmodule
