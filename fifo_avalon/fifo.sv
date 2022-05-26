module fifo #( 
parameter DATABITS_PER_SYMBOL  = 8,
parameter BEATS_PER_CYCLE 	   = 1,
parameter SYMBOLS_PER_BEAT     = 4,

parameter WIDTH 			   = DATABITS_PER_SYMBOL*SYMBOLS_PER_BEAT,
parameter DEPTH 			   = 4
)( 
input 			  		 clk_i,
input 			  		 rst_i,

input  		 [WIDTH-1:0] data_i, //write
input 			   		 rd_i,   //read
output logic [WIDTH-1:0] data_o, //read

input 			  		 wr_i,    //write
output 		   	   	 	 empty_o, //read
output			   		 full_o   //write			
) ;


logic [DEPTH:0] 	   rd_ptr;
logic [DEPTH:0] 	   wr_ptr;
logic [WIDTH-1:0] 	   mem [2**DEPTH-1:0];

// bit 				   check_rd;
// bit 				   check_wr;

// //Count how many clocks have been delayed.
// //when cnt_clk_latency_rd = avlif.READY_LATENCY, fifo begin to send data (if valid = 1 and ready = 1)
// integer 			   cnt_clk_latency_rd; 
// integer 			   cnt_clk_latency_wr = 0;

// always_ff @( posedge clk_i )
// 	begin
// 		if( cnt_clk_latency_rd == READY_LATENCY - 1 )
// 			check_rd 			        <= 1;

// 		if( !rd_i )
// 			begin
// 				cnt_clk_latency_rd      <= 0;
// 				check_rd 		        <= 0;
// 			end
	
// 		if( rd_i )
// 				cnt_clk_latency_rd      <= cnt_clk_latency_rd + 1;

// 		if( cnt_clk_latency_wr == READY_LATENCY - 1 )
// 			check_wr 				    <= 1;

// 		if( !wr_i )
// 			begin
// 				cnt_clk_latency_wr 		<= 0;
// 				check_wr		   		<= 0;
// 			end
			
// 		if( wr_i )
// 				cnt_clk_latency_wr <= cnt_clk_latency_wr + 1;
		
// 	end

// generate 	
// 	if( READY_LATENCY >  0 )
// 		begin
// 			always_ff @( posedge clk_i)
// 				begin
// 					if( rst_i )
// 						begin
// 							rd_ptr 			   <= '0;
// 							wr_ptr 			   <= '0;
// 						end
// 					else
// 						begin
// 							if( check_rd )
// 								begin
// 									if( !empty_o && rd_i ) 
// 										rd_ptr <= rd_ptr + 1;
// 								end

// 							if( check_wr )
// 								begin
// 									if( !full_o && wr_i )
// 										wr_ptr <= wr_ptr + 1;
// 								end
// 						end
// 				end
			
// 			always_comb
// 				if( !empty_o && rd_i )
// 					data_o 	= mem[rd_ptr[DEPTH-1:0]];
			
// 			always_comb
// 				if( !full_o && wr_i )
// 					mem[wr_ptr[DEPTH-1:0]] = data_i;

// 			//always_ff @( posedge avlif.clk )
// 			assign empty_o = ( !( rd_ptr == wr_ptr ) && check_rd ) ? 0 : 1; //!empty

// 			assign full_o = ( !(( rd_ptr[DEPTH-1:0] == wr_ptr[DEPTH-1:0] ) &&
// 						  			   ( rd_ptr[DEPTH] != wr_ptr[DEPTH] )) && check_wr ) ? 0 : 1; //!full
// 		end
// 	else
// 		begin
			always_ff @( posedge clk_i )
				begin
					if( rst_i )
						begin
							rd_ptr 			 <= '0;
							wr_ptr 			 <= '0;
						end
					else
						begin
							if( !empty_o && rd_i ) 
								rd_ptr 		 <= rd_ptr + 1;
							
							if( !full_o && wr_i )
								wr_ptr 		 <= wr_ptr + 1;
						end
				end

			always_ff @( posedge clk_i ) 
				if( !empty_o && rd_i )
					data_o 	<= mem[rd_ptr[DEPTH-1:0]];

			always_ff @( posedge clk_i )
				if( !full_o && wr_i )
					mem[wr_ptr[DEPTH-1:0]] <= data_i;

			//always_ff @( posedge avlif.clk )
			assign empty_o = ( ( rd_ptr == wr_ptr ) ) ? 1 : 0; //empty

			assign full_o = ( ( rd_ptr[DEPTH-1:0] == wr_ptr[DEPTH-1:0] ) &&
						  			  ( rd_ptr[DEPTH] != wr_ptr[DEPTH] ) ) ? 1 : 0; //full
// 		end	

// endgenerate		

endmodule

