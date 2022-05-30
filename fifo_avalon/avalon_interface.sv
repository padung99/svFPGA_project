interface avalon_interface 
#(
    parameter DATABITS_PER_SYMBOL    = 8,
    parameter BEATS_PER_CYCLE        = 1,
    parameter SYMBOLS_PER_BEAT       = 4, 
    
    parameter READY_LATENCY          = 2,
    parameter READY_ALLOWANCE        = 2
)
    ( input bit clk, rst );
    
    localparam TEST_DATA             = 20;
    localparam TIMEOUT               = 50;
    parameter WIDTH                  = SYMBOLS_PER_BEAT * DATABITS_PER_SYMBOL;
    parameter DEPTH                  = 4; //2^4 = 16 addresses

    logic [WIDTH-1:0]  data;        //In reading mode, FIFO(src) ----> ext device(sink)	
    logic              ready;       //read_en (sink --> src)		
    logic              valid;       //!empty (src --> sink)
        
    //read
    modport source( input  ready, clk, rst,
                    output valid, data
                  );
    
    modport sink( input  valid, data, clk, rst,
                  output ready
                );
endinterface



