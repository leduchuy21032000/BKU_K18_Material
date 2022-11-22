// Count Minute & Second
module count60(qout,cout,data,load,cin,reset,clk);
	output[7:0]qout;
	output cout;
	input[7:0]data;
	input load,cin,clk,reset;
	reg[7:0]qout;
	always@(posedge clk)
	begin
		if(reset) qout<=0;
		else if(load) qout<=data;
		else if(cin)
		begin
			if(qout[3:0]==9)
			begin
				qout[3:0]<=0;
				if(qout[7:4]==5) 
				begin 
					qout[7:4]<=0;
				end
				else
				begin
					qout[7:4]<=qout[7:4]+1;
				end
			end
			else
			begin
				qout[3:0]<=qout[3:0]+1;
			end
		end
	end
	assign cout=((qout==8'h59)&&cin)?1:0;
endmodule

// Count Hour
module count12(qout,cout,data,load,cin,reset,clk);
	output[7:0]qout;
	output cout;
	input[7:0]data;
	input load,cin,clk,reset;
	reg[7:0]qout;
	always@(posedge clk)
	begin
		if(reset) 
		begin
		qout[7:4]=1;
		qout[3:0]=2;
		end
		else if(load) qout<=data;
		else if(cin)
		begin
			if((qout[3:0]==2)&&(qout[7:4]==1))
			begin
				qout[3:0]<=1;
				qout[7:4]<=0;
			end
			else if (qout[3:0]==9)
			begin
				qout[3:0]<=0;
				qout[7:4]<=qout[7:4]+1;
			end
			else
			begin
				qout[3:0]<=qout[3:0]+1;
			end
		end
	end
	assign cout=((qout==8'h11)&&cin)?1:0;
endmodule

// Devide frequency
module freq_divider(clk,clk_out);
	input clk;
	output reg clk_out;
	reg [25:0] count;
	parameter n=50000000;
	always@(posedge clk)
	begin
	if(count<n/2-1)
			count<=count+1;
		else 
		begin
			count<=4'b0;
			clk_out<=~clk_out;
		end
	end
endmodule

//Decoder
module decoder(dec_out,dec_in);
	input[3:0] dec_in;
	output[0:6] dec_out;
	reg[0:6] dec_out;
	always @(dec_in)
	begin
	case(dec_in)
	4'b0000: dec_out=7'b0000001;
	4'b0001: dec_out=7'b1001111;
	4'b0010: dec_out=7'b0010010;
	4'b0011: dec_out=7'b0000110;
	4'b0100: dec_out=7'b1001100;
	4'b0101: dec_out=7'b0100100;
	4'b0110: dec_out=7'b0100000;
	4'b0111: dec_out=7'b0001111;
	4'b1000: dec_out=7'b0000000;
	4'b1001: dec_out=7'b0000100;
	default:dec_out=7'b1111111;
	endcase
	end
endmodule

// Count AM_PM
module countAM_PM(qout,cin,reset,clk);
	input clk,cin,reset;
	output reg qout;
	always@(posedge clk)
	begin
	if(reset) qout<=0;
	else if(cin) qout<=~qout;
	end
endmodule

// Decode AM_PM
module decodeAM_PM(HEX,cin);
	input cin;
	output reg [0:6]HEX;
	always@(cin)
	begin
	case(cin)
	1'b0: HEX=7'b0001000;
	1'b1: HEX=7'b0011000;
	endcase
	end
endmodule

// Module Digital Clock
module digitalClock(CLOCK_50,KEY,HEX6,HEX5,HEX4,HEX3,HEX2,HEX1,HEX0);
	input CLOCK_50;
	input [0:0]KEY;
	output [0:6]HEX6,HEX5,HEX4,HEX3,HEX2,HEX1,HEX0;
	wire clk,cin_minute,cin_hour,cin_ampm,cout_sec,cout_min,cout_hour,ap,reset;
	wire [7:0]sec,min;
	wire [7:0]hour;
	freq_divider(CLOCK_50,clk);
	assign reset= ~KEY[0];
	
	// Display Second
	count60(sec,cout_sec,0,0,1,reset,clk);
	decoder(HEX0,sec[3:0]);
	decoder(HEX1,sec[7:4]);
	assign cin_minute=cout_sec;

	// Display Minute
	count60(min,cout_min,0,0,cin_minute,reset,clk);
	decoder(HEX2,min[3:0]);
	decoder(HEX3,min[7:4]);
	assign cin_hour=cout_min;
	
	// Display Hour
	count12(hour,cout_hour,0,0,cin_hour,reset,clk);
	decoder(HEX4,hour[3:0]);
	decoder(HEX5,hour[7:4]);
	assign cin_ampm=cout_hour;
	
	// Display AM(A) - PM(P)
	countAM_PM(ap,cin_ampm,reset,clk);
	decodeAM_PM(HEX6,ap);
endmodule
