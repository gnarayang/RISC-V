//`include "mux.v"
module one_bit_alu (a,b,a_invert,b_invert,operation,result,carry_in,zf,carry_out) ;

	input a,b,a_invert,b_invert,carry_in;
	input [1:0] operation;
	output result,zf,carry_out;

	reg result, zf, sum, and_, or_, b_out, a_out, carry_out, less_o;
	//wire mux_output;

	//mux MUT(.i1(i1), .i2(i2), .select(select), .mux_output(mux_output));

	always @(a,b,a_invert,b_invert,operation,carry_in) begin

		a_out = a ^ a_invert;
		b_out = b ^ b_invert;
	
		sum = (a_out ^ b_out) ^ (carry_in) ;
		and_ = a_out & b_out;
		or_ = a_out | b_out;

		case(operation)
			2'b00 : result = and_;
			2'b01 : result = or_;
			2'b10 : result = sum;
		endcase
		carry_out = (a_out & b_out) | (b_out & carry_in) | (carry_in & a_out);
		zf = ~result ;
	end


endmodule
