module fifo_avalon #(
parameter DATABITS_PER_SYMBOL  = 8,
parameter BEATS_PER_CYCLE      = 1,
parameter SYMBOLS_PER_BEAT     = 4,

parameter READY_LATENCY        = 3,
parameter READY_ALLOWANCE      = 3
) (
avalon_interface.sink          ast_wr_if,
avalon_interface.source        ast_rd_if
);

parameter WIDTH = SYMBOLS_PER_BEAT * DATABITS_PER_SYMBOL;
parameter DEPTH = 4;


fifo #(
    .DATABITS_PER_SYMBOL   ( DATABITS_PER_SYMBOL ),
    .BEATS_PER_CYCLE       ( BEATS_PER_CYCLE     ),
    .SYMBOLS_PER_BEAT      ( SYMBOLS_PER_BEAT    ),
    .READY_LATENCY         ( READY_LATENCY       ),
    .READY_ALLOWANCE       ( READY_ALLOWANCE     ),

    .WIDTH                 ( WIDTH               ),
    .DEPTH                 ( DEPTH               )
    ) fifo_inst (
    .clk_i                 ( ast_wr_if.clk       ),
    .rst_i                 ( ast_wr_if.rst       ),

    .data_i                ( ast_wr_if.data      ), //write
    .rd_i                  ( ast_rd_if.ready     ), //read
    .data_o                ( ast_rd_if.data      ), //read

    .wr_i                  ( ast_wr_if.valid     ), //write
    .non_empty_o           ( ast_rd_if.valid     ), //read
    .non_full_o	           ( ast_wr_if.ready     )  //write
    );

endmodule