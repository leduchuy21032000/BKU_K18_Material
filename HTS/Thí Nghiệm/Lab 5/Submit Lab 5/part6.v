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

module part6(SW,HEX1,HEX0);
	input [5:0]SW;
	output [0:6]HEX1,HEX0;
	reg [3:0]Z0,S0,S1,c;
	always@(*)
	begin
		if(SW>59)
		begin
			Z0=60;
			c=6;
		end
		else if(SW>49)
		begin
			Z0=50;
			c=5;
		end
		else if(SW>39)
		begin
			Z0=40;
			c=4;
		end
		else if(SW>29)
		begin
			Z0=30;
			c=3;
		end
		else if(SW>19)
		begin
			Z0=20;
			c=2;
		end
		else if(SW>9)
		begin
			Z0=10;
			c=1;
		end
		else
		begin
			Z0=0;
			c=0;
		end
		S0=SW-Z0;
		S1=c;
	end
	bcd_display(S0,HEX0);
	bcd_display(S1,HEX1);
endmodule