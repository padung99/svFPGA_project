interface avalon_interface 
#(
	parameter DATABITS_PER_SYMBOL    = 8,
	parameter BEATS_PER_CYCLE 	  	 = 1,
	parameter SYMBOLS_PER_BEAT       = 4, 
	
	parameter READY_LATENCY			 = 2,
	parameter READY_ALLOWANCE		 = 2
)
	( input bit clk, rst );
	
	localparam TEST_DATA			 = 20;
	localparam TIMEOUT 				 = 50;
	parameter WIDTH 				 = SYMBOLS_PER_BEAT * DATABITS_PER_SYMBOL;
	parameter DEPTH 				 = 4; //2^4 = 16 addresses

	logic [WIDTH-1:0]  data; 	  //In reading mode, FIFO(src) ----> ext device(sink)	
	logic  			   ready; 	  //read_en (sink --> src)		
	logic 			   valid;   //!empty (src --> sink)
		
	//read
	modport source( input  ready, clk, rst,
				    output valid, data
				  );
	
	modport sink( input  valid, data, clk, rst,
				  output ready
				);
	
	// //---------------------------Generating numbers-----------------------	
	// task gen_data (input int test_cnt,
	// 			   mailbox #( logic [WIDTH-1:0] ) data );

	// logic [WIDTH-1:0] data_wr_to_fifo;

	// 	for( int i = 0; i < TEST_DATA; i++ )
	// 		begin
	// 			data_wr_to_fifo = $urandom_range( 2**10-1,0 );
	// 			data.put( data_wr_to_fifo );
	// 			$display( "[%0d] mailbox data: %0d",i ,data_wr_to_fifo );
	// 		end
	// endtask


	// //----------------------------Writing task----------------------------
	// task wr_fifo ( mailbox #( logic [WIDTH-1:0] ) data_task, 
	// 			   mailbox #( logic [WIDTH-1:0] ) wr_data
	// 			 );
		
	// 	logic [WIDTH-1:0] data_wr_fifo;
	// 	int 			  pause_wr;
		
	// 	while( data_task.num() )
	// 		begin
	// 			pause_wr = $urandom_range( 10,0 );	
	// 			data_task.get( data_wr_fifo );
				
	// 			ready = 1'b1;
	// 			data  = data_wr_fifo;
	// 			##(pause_wr);
						
	// 			if ( valid && ready )
	// 				begin
	// 					wr_data.put( data_wr_fifo );
	// 					$display( "[%0d] data in fifo: %0d", wr_data.num(), data_wr_fifo );
	// 				end
					
	// 			ready = 1'b0;	
	// 			##1;

	// 		end
	// 	//ready_wr <= 1'b0;
		
	// endtask


	// //-----------------------------Reading task----------------------------
	// task rd_fifo ( mailbox #( logic [WIDTH-1:0] ) rd_from_fifo,
	// 			   int 							  empty_timeout
	// 			 );

	// 	logic [WIDTH-1:0] data_rd_fifo;
	// 	int 			  pause_rd;
		
	// 	forever
	// 		begin
	// 			// if( valid_rd )
	// 				begin 
	// 					pause_rd = $urandom_range(10,0);
	// 					ready = 1'b1;		
						
	// 					rd_from_fifo.put( data );
	// 					$display( "[%0d] fifo read: %0d", rd_from_fifo.num(), data );
						
	// 					//When fifo is delaying, data_rd is still pushing out, when delay times is over, data_rd jumped to another value
	// 					##(pause_rd); 
						
	// 					ready      = 1'b0;	
	// 					empty_timeout = 0;

	// 				end
	// 			// else
	// 			// 	begin	
	// 			// 		if( empty_timeout == TIMEOUT )
	// 			// 			break;
	// 			// 		else
	// 			// 			empty_timeout++;

	// 			// 	end
	// 			 ##1;
	// 		end
		
	// endtask

endinterface



