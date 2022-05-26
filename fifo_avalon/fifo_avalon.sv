module fifo_avalon #(
parameter DATABITS_PER_SYMBOL  = 8,
parameter BEATS_PER_CYCLE 	   = 1,
parameter SYMBOLS_PER_BEAT     = 4,

parameter READY_LATENCY		   = 2,
parameter READY_ALLOWANCE	   = 3
) (
avalon_interface        ast_if,
avalon_interface        ast_wr_if,
avalon_interface        ast_rd_if
);

parameter WIDTH = SYMBOLS_PER_BEAT * DATABITS_PER_SYMBOL;
parameter DEPTH = 4;

bit 				   check_rd;
bit 				   check_wr;

//Count how many clocks have been delayed.
//when cnt_clk_latency_rd = avlif.READY_LATENCY, fifo begin to send data (if valid = 1 and ready = 1)
integer 			   cnt_clk_latency_rd; 
integer 			   cnt_clk_latency_wr = 0;

logic [WIDTH-1:0] data_rd;
logic [WIDTH-1:0] data_wr;

logic             valid_rd;
logic             valid_wr;

logic             ready_rd;
logic             ready_wr;

always_ff @( posedge ast_if.clk )
	begin
		if( cnt_clk_latency_rd == READY_LATENCY - 1 )
			check_rd 			        <= 1;

		if( !ready_rd )
			begin
				cnt_clk_latency_rd      <= 0;
				check_rd 		        <= 0;
			end
	
		if( ready_rd )
				cnt_clk_latency_rd      <= cnt_clk_latency_rd + 1;

		if( cnt_clk_latency_wr == READY_LATENCY - 1 )
			check_wr 				    <= 1;
        
		if( !ready_wr )
			begin
				cnt_clk_latency_wr 		<= 0;
				check_wr		   		<= 0;
			end
			
		if( ready_wr )
				cnt_clk_latency_wr <= cnt_clk_latency_wr + 1;
		
	end
always_comb
    if( check_rd )
        valid_rd = !ast_rd_if.valid; //!empty 
    
always_comb
    if( check_wr )
        valid_wr = !ast_wr_if.ready;  //!full

assign data_rd  = ast_rd_if.data;
assign data_wr  = ast_wr_if.data;

assign ready_rd = ast_rd_if.ready;
assign ready_wr = ast_wr_if.valid;


fifo #(
    .DATABITS_PER_SYMBOL   ( DATABITS_PER_SYMBOL ),
    .BEATS_PER_CYCLE 	   ( BEATS_PER_CYCLE     ),
    .SYMBOLS_PER_BEAT      ( SYMBOLS_PER_BEAT    ),

    .WIDTH 			       ( WIDTH               ),
    .DEPTH 			       ( DEPTH               )
    ) fifo_inst (
    .clk_i                 ( ast_if.clk          ),
    .rst_i                 ( ast_if.rst          ),

    .data_i                ( data_wr             ), //write
    .rd_i                  ( ready_rd            ), //read
    .data_o                ( data_rd             ), //read

    .wr_i                  ( ready_wr            ), //write
    .empty_o               ( valid_rd            ), //read
    .full_o	               ( valid_wr            )  //write
    );

endmodule