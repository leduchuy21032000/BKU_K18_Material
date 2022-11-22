module part1(SW,HEX7,HEX6,HEX5,HEX4,HEX3,HEX2,HEX1,HEX0);
	input [9:7]SW;
	output [0:6]HEX7,HEX6,HEX5,HEX4,HEX3,HEX2,HEX1,HEX0;
	wire [1:0]M0,M1,M2,M3,M4,M5,M6,M7;
	mux_2bit_8to1 U0(SW[9:7],2,3,3,3,3,3,0,1,M0);
	mux_2bit_8to1 U1(SW[9:7],1,2,3,3,3,3,3,0,M1);
	mux_2bit_8to1 U2(SW[9:7],0,1,2,3,3,3,3,3,M2);
	mux_2bit_8to1 U3(SW[9:7],3,0,1,2,3,3,3,3,M3);
	mux_2bit_8to1 U4(SW[9:7],3,3,0,1,2,3,3,3,M4);
	mux_2bit_8to1 U5(SW[9:7],3,3,3,0,1,2,3,3,M5);
	mux_2bit_8to1 U6(SW[9:7],3,3,3,3,0,1,2,3,M6);
	mux_2bit_8to1 U7(SW[9:7],3,3,3,3,3,0,1,2,M7);
	
	char_7seg D7(M7, HEX7);
	char_7seg D6(M6, HEX6);
	char_7seg D5(M5, HEX5);
	char_7seg D4(M4, HEX4);
	char_7seg D3(M3, HEX3);
	char_7seg D2(M2, HEX2);
	char_7seg D1(M1, HEX1);
	char_7seg D0(M0, HEX0);
endmodule

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

module mux8to1(S,A,B,C,D,E,F,G,H,M);
	input A,B,C,D,E,F,G,H;
	input [2:0]S;
	output M;
	wire [1:0]R;
	mux4to1(S[1],S[0],A,B,C,D,R[1]);
	mux4to1(S[1],S[0],E,F,G,H,R[0]);
	
	mux2to1(R[1],R[0],S[2],M);
endmodule
	
module mux_2bit_8to1(S,A,B,C,D,E,F,G,H,M);
	input [2:0]S;
	input [1:0]A,B,C,D,E,F,G,H;
	output [1:0]M;

	mux8to1(S[2:0],A[1],B[1],C[1],D[1],E[1],F[1],G[1],H[1],M[1]);	
	mux8to1(S[2:0],A[0],B[0],C[0],D[0],E[0],F[0],G[0],H[0],M[0]);	
endmodule
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