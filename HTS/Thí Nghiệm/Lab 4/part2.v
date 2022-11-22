module mux2to1(x,y,s,m);
	input x,y,s;
	output m;
	assign m=(~s&x)|(s&y);
endmodule
/////////////------------////////////
module part2(SW,LEDR);
	input [9:0]SW;
	output [9:0]LEDR;
	
	mux2to1 M1(SW[3],SW[7],SW[9],LEDR[3]);
	mux2to1 M2(SW[2],SW[6],SW[9],LEDR[2]);
	mux2to1 M3(SW[1],SW[5],SW[9],LEDR[1]);
	mux2to1 M4(SW[0],SW[4],SW[9],LEDR[0]);
	
	assign LEDR[9]=SW[9];
	assign LEDR[8:4]=8'b0;
	
endmodule
