// Assignment by Narayan G 17CO225 and Dhanasekhar M 17CO214
// Date - 25-10-2018
// ALU and ALU Control Unit combined


`include "sixty_four_bit_alu.v"
`include "alu_cu.v"

module combined(a, b, alu_op, f3, f7, result, carry_out, zf);

	input [63:0] a;
	input [63:0] b;
	input [1:0] alu_op;
	input [1:0] f3;
	input [1:0] f7;
	output [63:0] result;
	output carry_out, zf;
	wire [3:0] control_i;
	
	
	alu_cu DUT0(alu_op, f3, f7, control_i);
	
	sixty_four_bit_alu DUT1(a, control_i[3], b, control_i[2], control_i[1:0], control_i[2], result, carry_out, zf);
	
endmodule
