module part4(input [1:0]SW, output [0:6]HEX0); //for DE2-115
	assign HEX0[0]=(SW[1] & SW[0])|(~SW[1] & ~SW[0]);
	assign HEX0[1]=SW[0];
	assign HEX0[2]=(SW[1]|SW[0]);
	assign HEX0[3]=(SW[1]&SW[0]);
	assign HEX0[4]=(SW[1]&SW[0]);
	assign HEX0[5]=(SW[1] | ~SW[0]);
	assign HEX0[6]=(SW[1]&SW[0]);
endmodule
