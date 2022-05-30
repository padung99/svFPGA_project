module fifo #( 
parameter DATABITS_PER_SYMBOL    = 8,
parameter BEATS_PER_CYCLE        = 1,
parameter SYMBOLS_PER_BEAT       = 4,

parameter READY_LATENCY          = 2,
parameter READY_ALLOWANCE        = 3,

parameter WIDTH                  = DATABITS_PER_SYMBOL*SYMBOLS_PER_BEAT,
parameter DEPTH                  = 4
)( 
input                            clk_i,
input                            rst_i,

input        [WIDTH-1:0]         data_i, //write
input                            rd_i,   //read
output logic [WIDTH-1:0]         data_o, //read

input                            wr_i,    //write
output logic                     non_empty_o,
output logic                     non_full_o
) ;

logic [DEPTH:0]                  rd_ptr;
logic [DEPTH:0]                  wr_ptr;
logic [2**DEPTH-1:0] [WIDTH-1:0] mem;

bit                              ready_cycle_rd;
bit                              ready_cycle_wr;
bit                              flag_wr;
bit                              flag_rd;
logic                            empty; //read
logic                            full;  //write
logic                            pos_wr, neg_wr;
logic                            pos_rd, neg_rd;
logic                            wr_pos_edge_detect, wr_neg_edge_detect;
logic                            rd_pos_edge_detect, rd_neg_edge_detect;

//Count how many clocks have been delayed.
//when cnt_clk_latency_rd = READY_LATENCY, fifo begins to send data
int                              cnt_clk_latency_rd;
int                              cnt_clk_latency_wr;

//--------------------Find ready cycle on writing task---------------------
always_ff @( posedge clk_i )
   begin
       pos_wr <=  wr_i;  //q_pos
       neg_wr <= !wr_i; //q_neg
   end

assign wr_pos_edge_detect    =  wr_i && !pos_wr;  //detecting positive edge wr_i
assign wr_neg_edge_detect    = !wr_i && !neg_wr; //detecting negative edge wr_i

always_ff @( posedge clk_i )
    if( wr_pos_edge_detect )
        flag_wr <= 1;


always_ff @( posedge clk_i )
    if( wr_neg_edge_detect )
        begin
            if( cnt_clk_latency_wr > READY_LATENCY - 1)
                begin
                    flag_wr                <= 0;
                    ready_cycle_wr         <= 0;
                end
        end

//--------------------Find ready cycle on reading task---------------------
always_ff @( posedge clk_i )
   begin
       pos_rd <=  rd_i;
       neg_rd <= !rd_i;
   end

assign rd_pos_edge_detect    =  rd_i && !pos_rd;  //detecting positive edge rd_i
assign rd_neg_edge_detect    = !rd_i && !neg_rd;  //detecting negative edge rd_i

always_ff @( posedge clk_i )
    if( rd_pos_edge_detect )
        flag_rd <= 1;

always_ff @( posedge clk_i )
    if( rd_neg_edge_detect )
        begin
            if( cnt_clk_latency_wr > READY_LATENCY - 1)
                begin
                    flag_rd                <= 0;
                    ready_cycle_rd         <= 0;
                end
        end

always_ff @( posedge clk_i )
    begin
    //---------------Check ready cycle in reading task-------------------
        if( flag_rd )
            cnt_clk_latency_rd <= cnt_clk_latency_rd + 1;
        else
            cnt_clk_latency_rd <= 0;

        if( cnt_clk_latency_rd == READY_LATENCY - 1 )
            begin
                ready_cycle_rd <= 1;
            end
    
    //----------------Check ready cycle in writing task---------------
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
                            rd_ptr      <= '0;
                            wr_ptr      <= '0;
                        end
                    else
                        begin
                            if( non_empty_o && rd_i ) 
                                rd_ptr  <= rd_ptr + 1;

                            if( non_full_o && wr_i )
                                wr_ptr  <= wr_ptr + 1;
                        end
                end
            
            
            assign full  = (( rd_ptr[DEPTH-1:0] == wr_ptr[DEPTH-1:0] ) &&
                            ( rd_ptr[DEPTH]     != wr_ptr[DEPTH]     )) ? 1 : 0; //full

            assign empty = (( rd_ptr            == wr_ptr            )) ? 1 : 0; //empty

            always_ff @( posedge clk_i )
                if( non_empty_o && rd_i )
                    data_o                 <= mem[rd_ptr[DEPTH-1:0]];
            
            always_ff @( posedge clk_i )
                if( non_full_o && wr_i )
                    mem[wr_ptr[DEPTH-1:0]] <= data_i;

            assign non_empty_o = !empty & ready_cycle_rd;
            assign non_full_o  = !full & ready_cycle_wr;
        
        end
    else
        begin
            always_ff @( posedge clk_i )
                begin
                    if( rst_i )
                        begin
                            rd_ptr           <= '0;
                            wr_ptr           <= '0;
                        end
                    else
                        begin
                            if( !empty && rd_i ) 
                                rd_ptr       <= rd_ptr + 1;
                            
                            if( !full && wr_i )
                                wr_ptr       <= wr_ptr + 1;
                        end
                end

            always_ff @( posedge clk_i ) 
                if( !empty && rd_i )
                    data_o                   <= mem[rd_ptr[DEPTH-1:0]];

            always_ff @( posedge clk_i )
                if( !full && wr_i )
                    mem[wr_ptr[DEPTH-1:0]]   <= data_i;

            
            assign empty = (( rd_ptr            == wr_ptr            )) ? 1 : 0; //empty

            assign full  = (( rd_ptr[DEPTH-1:0] == wr_ptr[DEPTH-1:0] ) &&
                            ( rd_ptr[DEPTH]     != wr_ptr[DEPTH]    )) ? 1 : 0; //full
            
            assign non_empty_o = !empty;
            assign non_full_o  = !full;
        end	

endgenerate

endmodule