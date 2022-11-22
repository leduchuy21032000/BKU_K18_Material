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

module adder4bit(SW,LEDR);//part3
	input [8:0]SW;
	output [4:0]LEDR;
	wire c1,c2,c3;
	
	fulladder(SW[4],SW[0],SW[8],LEDR[0],c1);
	fulladder(SW[5],SW[1],c1,LEDR[1],c2);
	fulladder(SW[6],SW[2],c2,LEDR[2],c3);
	fulladder(SW[7],SW[3],c3,LEDR[3],LEDR[4]);
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

module part4(SW,HEX0,HEX1,HEX3,HEX5,LEDR);
	input [8:0]SW;
	output [0:6]HEX0,HEX1,HEX3,HEX5;
	output [9:9]LEDR;
	
	wire [4:0]S;
	wire [3:0]d1,d0,X,Y;
	
	assign X=SW[7:4];
	assign Y=SW[3:0];
	assign LEDR[9]=(X>9||Y>9)?1'b1:1'b10;
	
	adder4bit(SW,S);
	
	assign d1=(S>9)?1:0;
	assign d0=(S>9)?(S-10):S;
	bcd_display(X,HEX5);
	bcd_display(Y,HEX3);
	bcd_display(d1,HEX1);
	bcd_display(d0,HEX0);
endmodule