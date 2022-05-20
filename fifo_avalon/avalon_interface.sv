interface avalon_interface #(
	parameter DATABITS_PER_SYMBOL    = 8,
	parameter BEATS_PER_CYCLE 	  	 = 1,
	parameter SYMBOLS_PER_BEAT       = 4, 
	parameter WIDTH 				 = SYMBOLS_PER_BEAT * DATABITS_PER_SYMBOL,
	parameter DEPTH 				 = 4, //2^4 = 16 addresses
	
	parameter READY_LATENCY			 = 1,
	parameter READY_ALLOWANCE		 = 2
	) ( input bit clk, rst );
	
	localparam TEST_DATA			 = 20;
	localparam TIMEOUT 				 = 50;
	
	// bit 				clk;
	// bit 				rst;
	
	//Writing 
	logic [WIDTH-1:0]  data_wr; 	//In writing mode, external device(src) ----> FIFO(sink)	
	logic 			   ready_wr;  //!full (sink --> src) 	
	logic  			   valid_wr;  //write_en (src --> sink)
	
	//Reading 
	logic [WIDTH-1:0]  data_rd; 	  //In reading mode, FIFO(src) ----> ext device(sink)	
	logic  			   ready_rd; 	  //read_en (sink --> src)		
	logic 			   valid_rd ;   //!empty (src --> sink)
		
	
	default clocking cb
	  @ (posedge clk);
	endclocking
	
	modport fifo( input  data_wr , ready_wr, ready_rd, clk, rst,
				  output valid_wr, data_rd , valid_rd
				);
	
	//---------------------------Generating numbers-----------------------	
	task gen_data (input int test_cnt,
				   mailbox #( logic [WIDTH-1:0] ) data );

	logic [WIDTH-1:0] data_wr_to_fifo;

		for( int i = 0; i < TEST_DATA; i++ )
			begin
				data_wr_to_fifo = $urandom_range( 2**10-1,0 );
				data.put( data_wr_to_fifo );
				$display( "[%0d] mailbox data: %0d",i ,data_wr_to_fifo );
			end
	endtask

					
	//----------------------------Writing task----------------------------
	task wr_fifo ( mailbox #( logic [WIDTH-1:0] ) data, 
				   mailbox #( logic [WIDTH-1:0] ) wr_data
				 );
		
		logic [WIDTH-1:0] data_wr_fifo;
		int 			  pause_wr;
		
		while( data.num() )
			begin
				pause_wr = $urandom_range( 10,0 );	
				data.get( data_wr_fifo );
				
				
				ready_wr = 1'b1;
				data_wr  = data_wr_fifo;
				##1;
				
				if ( valid_wr && ready_wr )
					begin
						wr_data.put( data_wr_fifo );
						$display( "[%0d] data in fifo: %0d", wr_data.num(), data_wr_fifo );
					end
					
				ready_wr = 1'b0;
				##(pause_wr);

			end
		//ready_wr <= 1'b0;
		
	endtask


	//-----------------------------Reading task----------------------------
	task rd_fifo ( mailbox #( logic [WIDTH-1:0] ) rd_from_fifo,
				   int 							  empty_timeout
				  );

		logic [WIDTH-1:0] data_rd_fifo;
		int 			  pause_rd;
		
		forever
			begin
				if( valid_rd )
					begin 
						pause_rd = $urandom_range(10,0);
						ready_rd = 1'b1;		
						
						rd_from_fifo.put( data_rd );
						$display( "[%0d] fifo read: %0d", rd_from_fifo.num(), data_rd );
						
						//When fifo is delaying, data_rd is still pushing out, when delay times is over, data_rd jumped to another value
						##(pause_rd); 
						
						ready_rd      = 1'b0;	
						empty_timeout = 0;

					end
				else
					begin	
						if( empty_timeout == TIMEOUT )
							break;
						else
							empty_timeout++;

					end
				##1;
			end
		
	endtask

endinterface



