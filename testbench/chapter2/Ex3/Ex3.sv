module Ex3;

bit [11:0] my_array [3:0];

assign my_array[0] = 12'h012; //0000 0001 0010 --[5:4] = 01
assign my_array[1] = 12'h345; //0011 0100 0101 --[5:4] = 00
assign my_array[2] = 12'h678; //0110 0111 1000 --[5:4] = 11
assign my_array[3] = 12'h9AB; //1001 1010 1011 --[5:4] = 10

initial
	begin
		//for(int i = 0; i <= 3; i++)
		//	$display("my_array[%0d][5:4] = %0h", i, my_array[i][5:4]);
		//output: 
		//# my_array[0][5:4] = 1
		//# my_array[1][5:4] = 0
		//# my_array[2][5:4] = 3
		//# my_array[3][5:4] = 2
		
		foreach(my_array[j])
			$display("my_array[%0d][5:4] = %0h", j, my_array[j][5:4]);
		//output: 
		//# my_array[3][5:4] = 2
		//# my_array[2][5:4] = 3
		//# my_array[1][5:4] = 0
		//# my_array[0][5:4] = 1
	end
endmodule