module fifo_tb;

localparam DATABITS_PER_SYMBOL_TB  = 8;
localparam BEATS_PER_CYCLE_TB 	   = 1;
localparam SYMBOLS_PER_BEAT_TB     = 4;
localparam WIDTH_TB 			   = SYMBOLS_PER_BEAT_TB * DATABITS_PER_SYMBOL_TB;
localparam DEPTH_TB 			   = 4;

localparam READY_LATENCY_TB		   = 2;
localparam READY_ALLOWANCE_TB	   = 3;
localparam TEST_DATA			   = 20;
localparam TIMEOUT 				   = 50;

bit 	   clk_tb, rst_tb;
initial
	forever
		#5 clk_tb = !clk_tb;

	default clocking cb
	  @ (posedge clk_tb);
	endclocking

	avalon_interface ast_fifo_tb( clk_tb, rst_tb );

	fifo_avalon #(
				.DATABITS_PER_SYMBOL  ( DATABITS_PER_SYMBOL_TB ),
				.BEATS_PER_CYCLE      ( BEATS_PER_CYCLE_TB     ),
				.SYMBOLS_PER_BEAT     ( SYMBOLS_PER_BEAT_TB    ), 
				.READY_LATENCY		  ( READY_LATENCY_TB	   ),
				.READY_ALLOWANCE	  ( READY_ALLOWANCE_TB     ) 
				) dut ( ast_fifo_tb, ast_fifo_tb.sink, ast_fifo_tb.source );

	
	//Generating data source to send to fifo
	mailbox #( logic [WIDTH_TB-1:0] ) generate_data = new();

	//Copy data source to new fifo(mailbox), because when data is being pushed to module fifo
	//data will be lost, so we need to create a mailbox to copy all data for testing.
	mailbox #( logic [WIDTH_TB-1:0] ) wr_to_fifo    = new();

	//Saving data received from module fifo
	mailbox #( logic [WIDTH_TB-1:0] ) rd_from_fifo  = new();
	
	int 				 		      cnt_empty     = 0;

//---------------------------Generating numbers-----------------------	
	task gen_data (input int test_cnt,
				   mailbox #( logic [WIDTH_TB-1:0] ) data );

	logic [WIDTH_TB-1:0] data_wr_to_fifo;

		for( int i = 0; i < TEST_DATA; i++ )
			begin
				data_wr_to_fifo = $urandom_range( 2**10-1,0 );
				data.put( data_wr_to_fifo );
				$display( "[%0d] mailbox data: %0d",i ,data_wr_to_fifo );
			end
	endtask


	//----------------------------Writing task----------------------------
	task wr_fifo ( mailbox #( logic [WIDTH_TB-1:0] ) 	   data_task, 
				   mailbox #( logic [WIDTH_TB-1:0] ) 	   wr_data,
				   virtual interface avalon_interface.sink ast_wr
				//    logic							 valid_wr_t, ready_wr_t,
				//    logic [WIDTH_TB-1:0]			  	 data_wr_t
				 );
		
		logic [WIDTH_TB-1:0] data_wr_fifo;
		int 			  pause_wr;
		
		while( data_task.num() )
			begin
				pause_wr = $urandom_range( 10,0 );	
				data_task.get( data_wr_fifo );
				
				ast_wr.valid = 1'b1;
				ast_wr.data  = data_wr_fifo;
				##(pause_wr);
						
				if (ast_wr.ready && ast_wr.valid )
					begin
						wr_data.put( data_wr_fifo );
						$display( "[%0d] data in fifo: %0d", wr_data.num(), data_wr_fifo );
					end
					
				ast_wr.valid = 1'b0;	
				##1;

			end
		//ready_wr <= 1'b0;
		
	endtask


	//-----------------------------Reading task----------------------------
	task rd_fifo ( mailbox #( logic [WIDTH_TB-1:0] ) 		 rd_from_fifo,
				   int 							  	 		 empty_timeout,
				   virtual interface avalon_interface.source ast_rd
				 );

		logic [WIDTH_TB-1:0] data_rd_fifo;
		int 			  pause_rd;
		
		forever
			begin
				// if( valid_rd )
					begin 
						pause_rd = $urandom_range(10,0);
						ast_rd.ready = 1'b1;		
						
						// rd_from_fifo.put( data );
						// $display( "[%0d] fifo read: %0d", rd_from_fifo.num(), data );
						
						//When fifo is delaying, data_rd is still pushing out, when delay times is over, data_rd jumped to another value
						##(pause_rd); 
						
						ast_rd.ready      = 1'b0;	
						empty_timeout = 0;

					end
				// else
				// 	begin	
				// 		if( empty_timeout == TIMEOUT )
				// 			break;
				// 		else
				// 			empty_timeout++;

				// 	end
				 ##1;
			end
		
	endtask


initial 
	begin
		#2;
		rst_tb   <= '1;
		#4;
		rst_tb	 <= '0;
		
		gen_data   ( TEST_DATA, generate_data  );
		
		fork
			 wr_fifo ( generate_data, wr_to_fifo, ast_fifo_tb.sink );
			 rd_fifo ( rd_from_fifo, cnt_empty, ast_fifo_tb.source );
		join
		
		//$stop();
		//check ( wr_to_fifo, rd_from_fifo );

	end
endmodule
