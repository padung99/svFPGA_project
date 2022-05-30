module fifo #( 
parameter DATABITS_PER_SYMBOL  	 = 8,
parameter BEATS_PER_CYCLE 	   	 = 1,
parameter SYMBOLS_PER_BEAT    	 = 4,

parameter READY_LATENCY		   	 = 3,
parameter READY_ALLOWANCE	   	 = 3,

parameter WIDTH 			   	 = DATABITS_PER_SYMBOL*SYMBOLS_PER_BEAT,
parameter DEPTH 			   	 = 4
)( 
input 			  		 	  	 clk_i,
input 			  		 	  	 rst_i,

input  		 [WIDTH-1:0] 	  	 data_i, //write
input 			   		 	  	 rd_i,   //read
output logic [WIDTH-1:0] 	  	 data_o, //read

input 			  		 	  	 wr_i,    //write
output logic			 	  	 non_empty_o,
output logic			 	  	 non_full_o		
) ;


logic [DEPTH:0] 	   			 rd_ptr;
logic [DEPTH:0] 	   			 wr_ptr;
logic [2**DEPTH-1:0] [WIDTH-1:0] mem;

bit 				   			 ready_cycle_rd;
bit 				   			 ready_cycle_wr;
bit 							 flag_wr;
bit 							 flag_rd;
logic  		 					 empty; //read
logic			   	  			 full; //write
logic 							 pos, neg;
logic 							 pos_o, neg_o;

//Count how many clocks have been delayed.
//when cnt_clk_latency_rd = avlif.READY_LATENCY, fifo begin to send data (if valid = 1 and ready = 1)
int 		 					 cnt_clk_latency_rd; 
int 		 					 cnt_clk_latency_wr;

always_ff @( posedge clk_i )
    begin
        pos_o <= wr_i;  //q_pos
        neg_o <= !wr_i; //q_neg
    end

assign pos 	  = wr_i && !pos_o;  //detecting positive edge wr_i
assign neg    = !wr_i && !neg_o; //detecting negative edge wr_i

always_ff @( posedge pos )
    begin
        flag_wr <= 1;
        flag_rd <= 1;
    end

always_ff @( posedge neg )
    begin
        if( cnt_clk_latency_wr >= READY_LATENCY - 1)
            begin
                flag_wr 		   	   <= 0;
                ready_cycle_wr 		   <= 0;
                flag_rd		   	   	   <= 0;
                ready_cycle_rd 		   <= 0;
            end
    end

always_ff @( posedge clk_i )
    begin
    //--------------Check ready cycle in reading task-------------------
        if( flag_rd )
            cnt_clk_latency_rd <= cnt_clk_latency_rd + 1;
        else
            cnt_clk_latency_rd <= 0;

        if( cnt_clk_latency_rd == READY_LATENCY - 1 )
            begin
                ready_cycle_rd <= 1;
            end
    
    //----------------Check ready cycle on writing task---------------
        if( flag_wr )
            cnt_clk_latency_wr <= cnt_clk_latency_wr + 1;
        else
            cnt_clk_latency_wr <= 0;

        if( cnt_clk_latency_wr == READY_LATENCY - 1 )
            begin
                ready_cycle_wr <= 1;
            end
    end

generate 	
    if( READY_LATENCY >  0 )
        begin
            always_ff @( posedge clk_i)
                begin
                    if( rst_i )
                        begin
                            rd_ptr 		<= '0;
                            wr_ptr 		<= '0;
                        end
                    else
                        begin
                            if( non_empty_o && rd_i ) 
                                rd_ptr  <= rd_ptr + 1;

                            if( non_full_o && wr_i )
                                wr_ptr  <= wr_ptr + 1;
                        end
                end
            
            
            assign full = ( ( rd_ptr[DEPTH-1:0] == wr_ptr[DEPTH-1:0] ) &&
                            ( rd_ptr[DEPTH] != wr_ptr[DEPTH] ) ) ? 1 : 0; //full

            assign empty = ( ( rd_ptr == wr_ptr ) ) ? 1 : 0; //empty

            always_ff @( posedge clk_i )
                if( non_empty_o && rd_i )
                    data_o 	<= mem[rd_ptr[DEPTH-1:0]];
            
            always_ff @( posedge clk_i )
                if( non_full_o && wr_i )
                    mem[wr_ptr[DEPTH-1:0]] <= data_i;

            //always_ff @( posedge avlif.clk )
            assign non_empty_o = !empty & ready_cycle_rd;
            assign non_full_o = !full & ready_cycle_wr;
        
        end
    else
        begin
            always_ff @( posedge clk_i )
                begin
                    if( rst_i )
                        begin
                            rd_ptr 			 <= '0;
                            wr_ptr 			 <= '0;
                        end
                    else
                        begin
                            if( !empty && rd_i ) 
                                rd_ptr 		 <= rd_ptr + 1;
                            
                            if( !full && wr_i )
                                wr_ptr 		 <= wr_ptr + 1;
                        end
                end

            always_ff @( posedge clk_i ) 
                if( !empty && rd_i )
                    data_o 	<= mem[rd_ptr[DEPTH-1:0]];

            always_ff @( posedge clk_i )
                if( !full && wr_i )
                    mem[wr_ptr[DEPTH-1:0]] <= data_i;

            //always_ff @( posedge avlif.clk )
            assign empty = ( ( rd_ptr == wr_ptr ) ) ? 1 : 0; //empty

            assign full = ( ( rd_ptr[DEPTH-1:0] == wr_ptr[DEPTH-1:0] ) &&
                              ( rd_ptr[DEPTH] != wr_ptr[DEPTH] ) ) ? 1 : 0; //full
            
            assign non_empty_o = !empty;
            assign non_full_o  = !full;
        end	

endgenerate		

endmodule

