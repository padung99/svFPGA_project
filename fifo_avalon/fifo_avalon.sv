module fifo_avalon #(
	parameter DATABITS_PER_SYMBOL  = 8,
	parameter BEATS_PER_CYCLE 	  	 = 1,
	parameter SYMBOLS_PER_BEAT     = 4, 
	parameter WIDTH 					 = SYMBOLS_PER_BEAT * DATABITS_PER_SYMBOL,
	parameter DEPTH 					 = 4, //2^4 = 16 addresses
	
	parameter READY_LATENCY			 = 1,
	parameter READY_ALLOWANCE		 = 2
	) (
	input 				  		 clk_i,
	input 				  		 rst_i,
		
	//In writing mode, external device(src) ----> FIFO(sink)
	input  logic [WIDTH-1:0] data_wr_i,
	
	// !full (sink --> src) 
	input 				  		 ready_wr_i, 
	
	// write_en (src --> sink)
	output 				 		 valid_wr_o, 
	
	
	//In reading mode, FIFO(src) ----> ext device(sink)
	output logic [WIDTH-1:0] data_rd_o,
	
	// read_en (sink --> src)
	input 				  		 ready_rd_i, 
	
	// !empty (src --> sink)
	output 				  		 valid_rd_o  
	
);

logic [DEPTH:0] 	rd_ptr;
logic [DEPTH:0] 	wr_ptr;
logic [WIDTH-1:0] mem [2**DEPTH-1:0];

bit 					check;

//Count how many clocks has been delayed.
//when cnt_clk_latency = READY_LATENCY, fifo begin to send data (if valid = 1 and ready = 1)
integer 				cnt_clk_latency = 0; 


always_ff @( posedge clk_i) 
	begin
		if( cnt_clk_latency == READY_LATENCY )
			check 				 <= 1;
		if( !ready_rd_i )
			begin
				cnt_clk_latency <= 0;
				check 			 <= 0;
			end
		if( ready_rd_i )
				cnt_clk_latency <= cnt_clk_latency + 1;
	end 
					
			
always_ff @( posedge clk_i )
	begin
		if( rst_i )
			begin
				rd_ptr 			 <= '0;
				wr_ptr 			 <= '0;
			end
		else
			begin
				if( check )
					begin
						if( valid_rd_o && ready_rd_i ) 
							rd_ptr <= rd_ptr + 1;
					end
				if( valid_wr_o && ready_wr_i )
					wr_ptr 		 <= wr_ptr + 1;
			end
	end

always_ff @( posedge clk_i )
	if( check )
		begin
			if( valid_rd_o && ready_rd_i )
				data_rd_o 	<= mem[rd_ptr[DEPTH-1:0]];
		end

		
always_ff @( posedge clk_i )
	if( valid_wr_o && ready_wr_i )
		mem[wr_ptr[DEPTH-1:0]] <= data_wr_i;

assign valid_rd_o = ( rd_ptr == wr_ptr ) ? 0 : 1; //!empty

assign valid_wr_o = ( ( rd_ptr[DEPTH-1:0] == wr_ptr[DEPTH-1:0] ) &&
						  ( rd_ptr[DEPTH] != wr_ptr[DEPTH] ) ) ? 0 : 1; //!full

endmodule
