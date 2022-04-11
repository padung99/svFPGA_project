module seven_seg (
	input  [3:0] code_led_i,
	input clk_i,
	output  [6:0] led_seg_o,
	output led_digit
);

logic [6:0] led = 7'h00;
logic digit = 1'b0;

always_ff @(posedge clk_i)
	begin
		case (code_led_i)
			4'b0000 : led <= 7'h7E;	
			
			4'b0001 : led <= 7'h30;	
			
			4'b0010 : led <= 7'h6D;
			
			4'b0011 : led <= 7'h79;
				
			4'b0100 : led <= 7'h33;
				
			4'b0101 : led <= 7'h5B;
				
			4'b0110 : led <= 7'h5F;
				
			4'b0111 : led <= 7'h70;
				
			4'b1000 : led <= 7'h7F;
				
			4'b1001 : led <= 7'h7B;
				
			4'b1010 : led <= 7'h77;
				
			4'b1011 : led <= 7'h1F;
				
			4'b1100 : led <= 7'h4E;
				
			4'b1101 : led <= 7'h3D;
				
			4'b1110 : led <= 7'h4F;
				
			4'b1111 : led <= 7'h47;
			
			default : led <= 7'h7E;
				
		endcase
	end

assign led_seg_o = ~led; //(Active at zero)
assign led_digit = digit;

endmodule