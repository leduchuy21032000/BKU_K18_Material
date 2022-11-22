module part5 (SW, LEDR, HEX0,HEX1,HEX2,HEX3);
	input [9:0] SW; 		// slide switches
	output [9:0]LEDR;
	output [0:6] HEX0,HEX1,HEX2,HEX3; 	// 7-seg display
	wire [1:0] M0;
	
	assign LEDR=SW;
	mux_2bit_4to1 U0 (SW[9:8], SW[7:6], SW[5:4], SW[3:2], SW[1:0], M0);
	char_7seg H0 (M0, HEX3);
	char_7seg H1 (M0+1, HEX2);
	char_7seg H2 (M0+2, HEX1);
	char_7seg H3 (M0+3, HEX0);
endmodule

// implements a 2-bit wide 4-to-1 multiplexer
module mux4to1(s1,s0,u,v,w,x,m);
	input s1,s0,u,v,w,x;
	output m;
	wire [1:0]r;
	mux2to1 M1(u,v,s0,r[1]);
	mux2to1 M2(w,x,s0,r[0]);
	mux2to1 M3(r[1],r[0],s1,m);
	
endmodule

module mux2to1(x,y,s,m);
	input x,y,s;
	output m;
	assign m=(~s&x)|(s&y);
endmodule

module mux_2bit_4to1(S,U,V,W,X,M);
	input [1:0]S,U,V,W,X;
	output [1:0]M;
	
	mux4to1 M1(S[1],S[0],U[1],V[1],W[1],X[1],M[1]);
	mux4to1 M2(S[1],S[0],U[0],V[0],W[0],X[0],M[0]);
	
endmodule



// implements a 7-segment decoder for d, E, 1 and 0
module char_7seg (C, Display);
	input [1:0] C; 			// input code
	output [0:6] Display; 	// output 7-seg code
	
	assign Display[0]=(C[1] & C[0])|(~C[1] & ~C[0]);
	assign Display[1]=C[0];
	assign Display[2]=(C[1]|C[0]);
	assign Display[3]=(C[1]&C[0]);
	assign Display[4]=(C[1]&C[0]);
	assign Display[5]=(C[1] | ~C[0]);
	assign Display[6]=(C[1]&C[0]);
endmodule
