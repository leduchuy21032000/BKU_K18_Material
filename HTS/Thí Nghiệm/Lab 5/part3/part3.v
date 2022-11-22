module mux2to1(x,y,s,m);
	input s,x,y;
	output m;
	assign m=(~s & x)|(s & y);
endmodule

module fulladder(a,b,ci,s,c0);
	input a,b,ci;
	output s,c0;
	wire m;
	assign m=a^b;
	assign s=m^ci;
	mux2to1(b,ci,m,c0);
endmodule

module part3(SW,LEDR);
	input [8:0]SW;
	output [4:0]LEDR;
	wire c1,c2,c3;
	
	fulladder(SW[4],SW[0],SW[8],LEDR[0],c1);
	fulladder(SW[5],SW[1],c1,LEDR[1],c2);
	fulladder(SW[6],SW[2],c2,LEDR[2],c3);
	fulladder(SW[7],SW[3],c3,LEDR[3],LEDR[4]);
endmodule