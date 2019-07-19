// Assignment by Narayan G 17CO225 and Dhanasekhar M 17CO214
// Date - 25-10-2018
// One bit ALU


`include "one_bit_alu.v"
module one_bit_alu_tb();

	reg a, b, a_invert, b_invert, carry_in;
	reg [1:0] operation;
	wire result, zf, carry_out;

	one_bit_alu DUT(.a(a),.b(b),.a_invert(a_invert),.b_invert(b_invert),.operation(operation),.result(result), .carry_in(carry_in), .zf(zf), .carry_out(carry_out));

	initial begin

		$dumpfile("wave.vcd");
		$dumpvars();

		a=0; b=0; a_invert = 0; b_invert = 0; carry_in = 0;
		operation = 2'b00;																		// Operation 00 is for AND gate

		#10
		a=1;

		#10
		a=0; b=1;
		
		#10
		a=1; b=1;

		#10 a=0; b=0; a_invert = 0; b_invert = 0; carry_in = 0;									// Operation 01 is for OR
		operation = 2'b01;

		#10
		a=1;

		#10
		a=0; b=1;
		
		#10
		a=1; b=1;

		#10 a=0; b=0; a_invert = 0; b_invert = 0; carry_in = 0;									// Operation 10 is for XOR
		operation = 2'b10;

		#10
		a=1;

		#10
		a=0; b=1;
		
		#10
		a=1; b=1;


		#10
		$finish;
	end

	initial begin
		$display("a\tb\toperation\tresult\tZeroFlag");
		$monitor("%b\t%b\t   %b   \t%b\t%b",a,b,operation,result,zf);
	end

endmodule
