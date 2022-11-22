module mux2to1(x,y,s,m);
	input x,y,s;
	output m;
	assign m=(~s&x)|(s&y);
endmodule

module mux4to1(s1,s0,u,v,w,x,m);
	input s1,s0,u,v,w,x;
	output m;
	wire [1:0]r;
	mux2to1 M1(u,v,s0,r[1]);
	mux2to1 M2(w,x,s0,r[0]);
	mux2to1 M3(r[1],r[0],s1,m);
	
endmodule

module part3(SW,LEDR);
	input [9:0]SW;
	output [1:0]LEDR;
	
	mux4to1 M1(SW[9],SW[8],SW[7],SW[5],SW[3],SW[1],LEDR[1]);
	mux4to1 M2(SW[9],SW[8],SW[6],SW[4],SW[2],SW[0],LEDR[0]);
	
endmodule