module fifo_tb;

localparam DATABITS_PER_SYMBOL_TB  = 8;
localparam BEATS_PER_CYCLE_TB 	  = 1;
localparam SYMBOLS_PER_BEAT_TB     = 4;
localparam WIDTH_TB 					  = SYMBOLS_PER_BEAT_TB * DATABITS_PER_SYMBOL_TB;
localparam DEPTH_TB 					  = 8;

localparam READY_LATENCY_TB		  = 0;
localparam READY_ALLOWANCE_TB		  = 3;
localparam TEST_DATA					  = 20;
localparam TIMEOUT 					= 50;
bit 				 clk_i_tb, rst_i_tb, valid_wr_o_tb, ready_wr_i_tb, ready_rd_i_tb, valid_rd_o_tb;
logic [WIDTH_TB-1:0] data_wr_i_tb, data_rd_o_tb;
int 				 cnt_empty = 0;
//Generating data source to send to fifo
mailbox #( logic [WIDTH_TB-1:0] ) generate_data = new();

//Copy data source to new fifo(mailbox), because when data is being pushed to module fifo
//data will be lost, so we need to create a mailbox to copy all data for testing.
mailbox #( logic [WIDTH_TB-1:0] ) wr_to_fifo = new();

//Saving data received from module fifo
mailbox #( logic [WIDTH_TB-1:0] ) rd_from_fifo = new();

//mailbox #( logic [WIDTH_TB-1:0] ) bufer_fifo   = new();


initial 
	forever
		#5 clk_i_tb = !clk_i_tb;

default clocking cb
  @ (posedge clk_i_tb);
endclocking

fifo_avalon #( .DATABITS_PER_SYMBOL	( DATABITS_PER_SYMBOL_TB ),
					.BEATS_PER_CYCLE 	  	( BEATS_PER_CYCLE_TB	 	 ),
					.SYMBOLS_PER_BEAT    ( SYMBOLS_PER_BEAT_TB 	 ), 
					.WIDTH 					( WIDTH_TB					 ),
					.DEPTH 					( DEPTH_TB	 				 ), 
						
					.READY_LATENCY			( READY_LATENCY_TB	 	 ),
					.READY_ALLOWANCE		( READY_ALLOWANCE_TB	 	 )
					)  fifo_inst (
					.clk_i					( clk_i_tb   				 ), //input
					.rst_i					( rst_i_tb  				 ), //input
					
					//----------------write---------------------		
					.data_wr_i				( data_wr_i_tb    		 ), //input
					.valid_wr_o				( valid_wr_o_tb   		 ), //input
					.ready_wr_i				( ready_wr_i_tb   		 ), 
					
					//----------------read----------------------
					.data_rd_o				( data_rd_o_tb  			 ), //input
					.ready_rd_i				( ready_rd_i_tb   		 ), //input
					.valid_rd_o				( valid_rd_o_tb   	 	 )  
					);

//---------------------------Generating numbers-----------------------	
task gen_data (input int test_cnt,
			   mailbox #( logic [WIDTH_TB-1:0] ) data );

logic [WIDTH_TB-1:0] data_wr_to_fifo;

	for( int i = 0; i < TEST_DATA; i++ )
		begin
			data_wr_to_fifo = $urandom_range(2**10-1,0);
			data.put( data_wr_to_fifo );
			$display( "[%0d] mailbox data: %0d",i ,data_wr_to_fifo );
		end
endtask

				
//----------------------------Writing task----------------------------
task wr_fifo ( mailbox #( logic [WIDTH_TB-1:0] ) data, 
			   mailbox #( logic [WIDTH_TB-1:0] ) wr_data
			   );
	
	logic [WIDTH_TB-1:0] data_wr_fifo;
	int 				 pause_wr;
	
	while( data.num() )
		begin
			pause_wr = $urandom_range( 10,0 );	
			data.get( data_wr_fifo );
			
			
			ready_wr_i_tb = 1'b1;
			data_wr_i_tb  = data_wr_fifo;
			##1;
			
			if ( valid_wr_o_tb && ready_wr_i_tb )
				begin
					wr_data.put( data_wr_fifo );
					$display( "[%0d] data in fifo: %0d", wr_data.num(), data_wr_fifo );
				end
				
			ready_wr_i_tb = 1'b0;
			##(pause_wr);

		end
	//ready_wr_i_tb <= 1'b0;
	
endtask


//-----------------------------Reading task----------------------------
task rd_fifo ( mailbox #( logic [WIDTH_TB-1:0] ) rd_from_fifo,
			   int 								 empty_timeout
			  );

	logic [WIDTH_TB-1:0] data_rd_fifo;
	
	int pause_rd;
	
	forever
		begin
			if( valid_rd_o_tb )
				begin
					pause_rd = $urandom_range(10,0);
					ready_rd_i_tb = 1'b1;		
					
					rd_from_fifo.put( data_rd_o_tb );
					$display( "[%0d] fifo read: %0d", rd_from_fifo.num(), data_rd_o_tb );
					
					##(pause_rd); //When fifo is delaying, data_rd_o 's still running out, when delay times is over, data_rd_o jumped to another value
					
					ready_rd_i_tb = 1'b0;	
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

//Purpose of creating reading and writing task is
//creating random signal ready_wr and ready_rd automatically
//and make this 2 tasks run concurrently

//----------------------------check data-----------------------------
task check ( mailbox #( logic [WIDTH_TB-1:0] ) wr_data,
			 mailbox #( logic [WIDTH_TB-1:0] ) rd_data
			 );
	// if( wr_data.num() > rd_data.num( ))
	
//$display("Start checking...............");
logic [WIDTH_TB-1:0] rd_tmp;
logic [WIDTH_TB-1:0] wr_tmp;
int 				 i;
	if( wr_data.num() == rd_data.num() )
		for( i = 0; i < rd_data.num(); i++ )
			begin
				wr_data.get( wr_tmp );
				rd_data.get( rd_tmp );
				if( wr_tmp != rd_tmp )
					begin
						$display( "Error: Receiving wrong data" );
						$display( "[%0d] wr_data: %0d, rd_data: %0d", i, wr_tmp, rd_tmp );
						$stop();
					end
			end
	else
		begin
			$display( "Error: Not receive enough data!" );
			$display( "FIFO size: %0d, Total receiving: %0d", wr_data.num(), rd_data.num() );
			$stop();
		end
	
	$display( "Testing completed!!!" );
	$display( "<No error found>" );
	$stop();
	
endtask

initial 
	begin
		#2;
		rst_i_tb <= '1;
		#4;
		rst_i_tb <= '0;
		
		gen_data ( TEST_DATA, generate_data );
		
		fork
			wr_fifo ( generate_data, wr_to_fifo );
			rd_fifo ( rd_from_fifo, cnt_empty );
		join
		
		check ( wr_to_fifo, rd_from_fifo );

	end
endmodule
