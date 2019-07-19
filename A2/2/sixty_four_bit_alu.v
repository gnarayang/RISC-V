// Assignment by Narayan G 17CO225 and Dhanasekhar M 17CO214
// Date - 25-10-2018
// Sixty four bit ALU


`include "one_bit_alu.v"
	
module sixty_four_bit_alu(a, a_invert, b, b_invert, operation, carry_in, result, carry_out, zf);
	
	input [63:0] a;
	input [63:0] b;
	input [1:0] operation;
	input a_invert, b_invert, carry_in;	
	wire [63:0] zf_i;
	wire [63:0] carry_out_i;
	output carry_out;
	output zf;
	output [63:0] result;
	reg [63:0] less_i;
	reg [63:0] less_o;
		
	  	one_bit_alu DUT0(a[0] ,b[0], a_invert, b_invert , operation, result[0], carry_in, zf_i[0], carry_out_i[0]);	
	
		one_bit_alu DUT[63:1] (a[63:1] ,b[63:1], a_invert, b_invert , operation, result[63:1], carry_out_i[62:0], zf_i[63:1], carry_out_i[63:1]);
	
		// 1 Bit ALU is instantiated 64 times with suitable connections from one ALU to another
	
		assign zf=!(|result);												//Reduction operator is used to take the NOR of 64 outputs
	
		assign carry_out = carry_out_i[63];

	
endmodule
