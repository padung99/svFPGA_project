module randomize;

class Packet;
	rand bit [31:0] src, dst, data [8];
	rand bit [7:0]  kind;
	
	constraint c {  src > 10;
					src <= 15;
				 };
	
	endclass
	
	Packet p;
	
	initial 
		begin
			p = new();
			if( p.randomize() )
				begin
					$display( "src: %0d, dst: %0d", p.src, p.dst );
				end
		end
	
endmodule