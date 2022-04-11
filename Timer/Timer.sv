module Timer #(
parameter cnt_before_1sec = 49999999
)
(
	input clk_i,
	output [6:0] led_segment_o,
	output [3:0] digit_o
);

//Clock frequency = 50MHz
///Count to 9999

int cnt_one_sec = 12'(0);
longint cnt_50Mhz = 0;

logic [6:0] led;
logic [3:0] digit;
int led_sweeping_digit = 0;

always_ff @(posedge clk_i)
	begin
		cnt_50Mhz <= cnt_50Mhz + 1;
		if(((cnt_50Mhz == cnt_before_1sec)?1:0) == 1) ///
			begin
				cnt_one_sec <= cnt_one_sec + 1;
				cnt_50Mhz <= 0;
			end
	end

	
always_ff @(posedge clk_i)
	begin
		led_sweeping_digit <= led_sweeping_digit + 1;
	end

	
always_ff @(posedge clk_i)
	begin
		case (cnt_one_sec % 10)
				0 : 
				begin
					digit <= 4'b0111;
					led <= 7'h7E;			
				end
				
				1 : 
				begin
					digit <= 4'b0111;
					led <= 7'h30;				
				end
				
				2 : 
				begin
					digit <= 4'b0111;
					led <= 7'h6D;			
				end
				
				3 : 
				begin
					digit <= 4'b0111;
					led <= 7'h79;				
				end
				
				4 : 
				begin
					digit <= 4'b0111;
					led <= 7'h33;
					
				end
				
				5 : 
				begin
					digit <= 4'b0111;
					led <= 7'h5B;				
				end
				
				6 : 
				begin
					digit <= 4'b0111;
					led <= 7'h5F;				
				end
				
				7 : 
				begin
					digit <= 4'b0111;
					led <= 7'h70;				
				end
				
				8 : 
				begin
					digit <= 4'b0111;
					led <= 7'h7F;				
				end
				
				9 : 
				begin
					digit <= 4'b0111;
					led <= 7'h7B;				
				end

		endcase

		if(led_sweeping_digit[12:11] != 2'b00)
			begin
				case ((cnt_one_sec % 100)/10)
						0 : 
						begin
							digit <= 4'b1011;
							led <= 7'h7E;			
						end
						
						1 : 
						begin
							digit <= 4'b1011;
							led <= 7'h30;				
						end
						
						2 : 
						begin
							digit <= 4'b1011;
							led <= 7'h6D;			
						end
						
						3 : 
						begin
							digit <= 4'b1011;
							led <= 7'h79;				
						end
						
						4 : 
						begin
							digit <= 4'b1011;
							led <= 7'h33;
							
						end
						
						5 : 
						begin
							digit <= 4'b1011;
							led <= 7'h5B;				
						end
						
						6 : 
						begin
							digit <= 4'b1011;
							led <= 7'h5F;				
						end
						
						7 : 
						begin
							digit <= 4'b1011;
							led <= 7'h70;				
						end
						
						8 : 
						begin
							digit <= 4'b1011;
							led <= 7'h7F;				
						end
						
						9 : 
						begin
							digit <= 4'b1011;
							led <= 7'h7B;	
						end
				endcase
			end

		if(led_sweeping_digit[14:13] != 2'b00)
			begin
				case ((cnt_one_sec % 1000)/100)
						0 : 
						begin
							digit <= 4'b1101;
							led <= 7'h7E;			
						end
						
						1 : 
						begin
							digit <= 4'b1101;
							led <= 7'h30;				
						end
						
						2 : 
						begin
							digit <= 4'b1101;
							led <= 7'h6D;			
						end
						
						3 : 
						begin
							digit <= 4'b1101;
							led <= 7'h79;				
						end
						
						4 : 
						begin
							digit <= 4'b1101;
							led <= 7'h33;
							
						end
						
						5 : 
						begin
							digit <= 4'b1101;
							led <= 7'h5B;				
						end
						
						6 : 
						begin
							digit <= 4'b1101;
							led <= 7'h5F;				
						end
						
						7 : 
						begin
							digit <= 4'b1101;
							led <= 7'h70;				
						end
						
						8 : 
						begin
							digit <= 4'b1101;
							led <= 7'h7F;				
						end
						
						9 : 
						begin
							digit <= 4'b1101;
							led <= 7'h7B;				
						end					
				endcase
			end

		if(led_sweeping_digit[16:15] != 2'b00)
			begin
				case (cnt_one_sec/1000)
						0 : 
						begin
							digit <= 4'b1110;
							led <= 7'h7E;			
						end
						
						1 : 
						begin
							digit <= 4'b1110;
							led <= 7'h30;				
						end
						
						2 : 
						begin
							digit <= 4'b1011;
							led <= 7'h6D;			
						end
						
						3 : 
						begin
							digit <= 4'b1110;
							led <= 7'h79;				
						end
						
						4 : 
						begin
							digit <= 4'b1110;
							led <= 7'h33;
							
						end
						
						5 : 
						begin
							digit <= 4'b1110;
							led <= 7'h5B;				
						end
						
						6 : 
						begin
							digit <= 4'b1110;
							led <= 7'h5F;				
						end
						
						7 : 
						begin
							digit <= 4'b1110;
							led <= 7'h70;				
						end
						
						8 : 
						begin
							digit <= 4'b1110;
							led <= 7'h7F;				
						end
						
						9 : 
						begin
							digit <= 4'b1110;
							led <= 7'h7B;				
						end
								
				endcase
			end
	end
	
assign digit_o = digit;
assign led_segment_o = ~led;
endmodule

