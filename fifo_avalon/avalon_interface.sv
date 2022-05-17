interface avalon_interface #(
	parameter DATABITS_PER_SYMBOL    = 8,
	parameter BEATS_PER_CYCLE 	  	 = 1,
	parameter SYMBOLS_PER_BEAT       = 4, 
	parameter WIDTH 				 = SYMBOLS_PER_BEAT * DATABITS_PER_SYMBOL,
	parameter DEPTH 				 = 4, //2^4 = 16 addresses
	
	parameter READY_LATENCY			 = 1,
	parameter READY_ALLOWANCE		 = 2
	) 
	( input clk, rst);

	
	//Writing 
	logic [WIDTH-1:0] data_wr; //In writing mode, external device(src) ----> FIFO(sink)	
	logic 			   ready_wr; // !full (sink --> src) 	
	logic  			   valid_wr; // write_en (src --> sink)
	
	//Reading 
	logic [WIDTH-1:0] data_rd; //In reading mode, FIFO(src) ----> ext device(sink)	
	logic  			   ready_rd; // read_en (sink --> src)		
	logic 			   valid_rd ;  // !empty (src --> sink)
	
	modport fifo_avalon ( input  data_wr , ready_wr, ready_rd,
								output valid_wr, data_rd , valid_rd
						);
	
endinterface


