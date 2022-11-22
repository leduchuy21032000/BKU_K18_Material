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

module part5(SW,HEX5,HEX3,HEX1,HEX0,LEDR);
	input [8:0]SW;
	output [0:6]HEX5,HEX3,HEX1,HEX0;
	output [9:9]LEDR;
	reg [3:0]A,B,Z0,S0,S1;
	reg [4:0]T0;
	reg c0,c1;
	always@(*)
	begin
		A=SW[7:4];
		B=SW[3:0];
		c0=SW[8];
		T0=A+B+c0;
		if(T0>9)
		begin
			Z0=10;
			c1=1;
		end
		else
		begin
			Z0=0;
			c1=0;
		end
		S0=T0-Z0;
		S1=c1;
	end
	
	assign LEDR[9]=(A>9||B>9)?1'b1:1'b0;
	bcd_display(A,HEX5);
	bcd_display(B,HEX3);
	bcd_display(S1,HEX1);
	bcd_display(S0,HEX0);
endmodule