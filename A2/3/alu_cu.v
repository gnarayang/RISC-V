// Assignment by Narayan G 17CO225 and Dhanasekhar M 17CO214
// Date - 25-10-2018
// ALU control unit

module alu_cu(alu_op, f3, f7, control_i);

	input [1:0] alu_op;
	input [1:0] f3;																					//Only last two bits of func3 is taken into account
	input [1:0] f7;																					//Only first two bits of func7 are taken into account
	output [3:0] control_i;
	reg [3:0] control_i;

	always @(alu_op, f3, f7, control_i)
	begin
		if(alu_op == 2'b00) begin
			control_i = 4'b0010;
		end
	

		if(alu_op == 2'b01) begin
			control_i = 4'b0110;
		end
		
		
		if(alu_op == 2'b10) begin
			if(f3 == 2'b00) begin
				control_i[1:0] = 2'b10;
				end
			if(f3 == 2'b11) begin
				control_i[1:0] = 2'b00;
				end
			if(f3 == 2'b10) begin
				control_i[1:0] = 2'b01;
				end
			control_i[3:2] = f7[1:0];																//The two bits of func7 are used to represent a_invert and b_invert
		end
	end
endmodule	
