module fifo_tb;

localparam DATABITS_PER_SYMBOL_TB  = 8;
localparam BEATS_PER_CYCLE_TB 	   = 1;
localparam SYMBOLS_PER_BEAT_TB     = 4;
localparam WIDTH_TB 			   = SYMBOLS_PER_BEAT_TB * DATABITS_PER_SYMBOL_TB;
localparam DEPTH_TB 			   = 8;

localparam READY_LATENCY_TB		   = 2;
localparam READY_ALLOWANCE_TB	   = 3;
localparam TEST_DATA			   = 20;
localparam TIMEOUT 				   = 50;

bit 		  clk_tb, rst_tb;
initial
	forever
		#5 clk_tb = !clk_tb;

	avalon_interface avlif_tb( clk_tb, rst_tb );
	
	fifo_avalon #(
				.DATABITS_PER_SYMBOL  ( DATABITS_PER_SYMBOL_TB ),
				.BEATS_PER_CYCLE      ( BEATS_PER_CYCLE_TB     ),
				.SYMBOLS_PER_BEAT     ( SYMBOLS_PER_BEAT_TB    ), 
				.WIDTH 				  ( WIDTH_TB 			   ),
				.DEPTH 				  ( DEPTH_TB			   ), //2^4 = 16 addresses
				.READY_LATENCY		  ( READY_LATENCY_TB	   ),
				.READY_ALLOWANCE	  ( READY_ALLOWANCE_TB     ) 
				) dut ( avlif_tb.fifo );

	
	//Generating data source to send to fifo
	mailbox #( logic [WIDTH_TB-1:0] ) generate_data = new();

	//Copy data source to new fifo(mailbox), because when data is being pushed to module fifo
	//data will be lost, so we need to create a mailbox to copy all data for testing.
	mailbox #( logic [WIDTH_TB-1:0] ) wr_to_fifo    = new();

	//Saving data received from module fifo
	mailbox #( logic [WIDTH_TB-1:0] ) rd_from_fifo  = new();
	
	int 				 		      cnt_empty     = 0;


initial 
	begin
		#2;
		rst_tb   <= '1;
		#4;
		rst_tb	 <= '0;
		
		avlif_tb.gen_data   ( TEST_DATA, generate_data  );
		
		fork
			avlif_tb.wr_fifo ( generate_data, wr_to_fifo );
			avlif_tb.rd_fifo ( rd_from_fifo, cnt_empty 	);
		join
		
		$stop();
		//check ( wr_to_fifo, rd_from_fifo );

	end
endmodule
