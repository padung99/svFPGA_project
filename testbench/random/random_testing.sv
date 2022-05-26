class Packet;
    rand bit [2:0] data;
    constraint c { data > 2;
                   data < 7;
                 };
endclass

module random_testing;

initial
    begin
        Packet p;
        p = new ();
        for( int i = 0; i < 10; i++)
            begin
                p.randomize();
                $display( "[%0d] data random: %0h", i, p.data );
            end
    end
endmodule