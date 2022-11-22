module comparator(v,z);
	input [3:0]v;
	output z;
	assign z= (v[3]&(v[2]|v[1]));
endmodule

module circuitA(v,a);
	input [3:0]v;
	output [3:0]a;
	assign a[3]=0;
	assign a[2]=v[3]&v[2]&v[1];
	assign a[1]=v[3]&v[2]&(~v[1]);
	assign a[0]=v[3]&v[0]&(v[1]|v[2]);
endmodule
module bcd_display(SW,HEX0);
	input [3:0]SW;
	output [0:6]HEX0;
	assign HEX0[0]=~SW[1]&(SW[2]&~SW[0]|~SW[3]&~SW[2]&SW[0]);
	assign HEX0[1]=SW[2]&(SW[1]^SW[0]);
	assign HEX0[2]=~SW[2]&SW[1]&~SW[0];
	assign HEX0[3]=~SW[3]&~SW[2]&~SW[1]&SW[0]|SW[2]&(~(SW[1]^SW[0]));
	assign HEX0[4]=SW[0]|SW[2]&~SW[1];
	assign HEX0[5]=~SW[3]&~SW[2]&SW[0]|SW[1]&(~SW[2]|SW[0]);
	assign HEX0[6]=~SW[3]&~SW[2]&~SW[1]|SW[2]&SW[1]&SW[0];
endmodule	
	
module mux2to1(x,y,s,m);
	input s,x,y;
	output m;
	assign m=(~s & x)|(s & y);
endmodule

module mux2to1_4bitwide(s,x,y,m);
	input s;
	input [3:0]x,y;
	output [3:0]m;
	
	mux2to1 M1(x[3],y[3],s,m[3]);
	mux2to1 M2(x[2],y[2],s,m[2]);
	mux2to1 M3(x[1],y[1],s,m[1]);
	mux2to1 M4(x[0],y[0],s,m[0]);
endmodule

module part2(SW,HEX1,HEX0);
	input [3:0]SW;
	output [0:6]HEX1,HEX0;
	wire z;
	wire [3:0]A,M;
	comparator(SW,z);
	bcd_display(z,HEX1);
	circuitA(SW,A);
	mux2to1_4bitwide(z,SW,A,M);
	bcd_display(M,HEX0);
endmodule