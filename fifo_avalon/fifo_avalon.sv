module fifo_avalon #( 
					parameter DATABITS_PER_SYMBOL  = 8,
					parameter BEATS_PER_CYCLE 	    = 1,
					parameter SYMBOLS_PER_BEAT     = 4,
					parameter WIDTH 					 = SYMBOLS_PER_BEAT * DATABITS_PER_SYMBOL,
					parameter DEPTH 					 = 8,

					parameter READY_LATENCY		    = 0,
					parameter READY_ALLOWANCE		 = 3
					) ( interface avlif ) ;


logic [DEPTH:0] 	   rd_ptr;
logic [DEPTH:0] 	   wr_ptr;
logic [WIDTH-1:0] 	mem [2**DEPTH-1:0];

bit 						check;

//Count how many clocks has been delayed.
//when cnt_clk_latency = avlif.READY_LATENCY, fifo begin to send data (if valid = 1 and ready = 1)
integer 					cnt_clk_latency; 

always_ff @( posedge avlif.clk)
	begin
		if( cnt_clk_latency == avlif.READY_LATENCY - 1 )
			check 				 <= 1;
		if( !avlif.ready_rd )
			begin
				cnt_clk_latency <= 0;
				check 			 <= 0;
			end
		if( avlif.ready_rd )
				cnt_clk_latency <= cnt_clk_latency + 1;
	end
	
	
generate 	
	if( READY_LATENCY >  0 )
		always_ff @( posedge avlif.clk )
			begin
				if( avlif.rst )
					begin
						rd_ptr 			 <= '0;
						wr_ptr 			 <= '0;
					end
				else
					begin
						if( check )
							begin
								if( avlif.valid_rd && avlif.ready_rd ) 
									rd_ptr <= rd_ptr + 1;
							end
						
						if( avlif.valid_wr && avlif.ready_wr )
							wr_ptr <= wr_ptr + 1;
					end
			end
	else
		always_ff @( posedge avlif.clk )
			begin
				if( avlif.rst )
					begin
						rd_ptr 			 <= '0;
						wr_ptr 			 <= '0;
					end
				else
					begin
						if( avlif.valid_rd && avlif.ready_rd ) 
							rd_ptr 		 <= rd_ptr + 1;
						
						if( avlif.valid_wr && avlif.ready_wr )
							wr_ptr 		 <= wr_ptr + 1;
					end
			end		
endgenerate		

generate 
	if( READY_LATENCY > 0 )
		begin
			always_ff @( posedge avlif.clk )
				if( check )
					begin
						if( avlif.valid_rd && avlif.ready_rd )
							avlif.data_rd 	<= mem[rd_ptr[DEPTH-1:0]];
					end
		end
	else
		always_ff @( posedge avlif.clk )
			if( avlif.valid_rd && avlif.ready_rd )
				avlif.data_rd 	<= mem[rd_ptr[DEPTH-1:0]];
endgenerate
 		
		
always_ff @( posedge avlif.clk )
	if( avlif.valid_wr && avlif.ready_wr )
		mem[wr_ptr[DEPTH-1:0]] <= avlif.data_wr;

assign avlif.valid_rd = ( rd_ptr == wr_ptr ) ? 0 : 1; //!empty

assign avlif.valid_wr = ( ( rd_ptr[DEPTH-1:0] == wr_ptr[DEPTH-1:0] ) &&
						  ( rd_ptr[DEPTH] != wr_ptr[DEPTH] ) ) ? 0 : 1; //!full

endmodule
