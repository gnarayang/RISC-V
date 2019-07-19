module alu_cu(alu_op, f3, f7, control_i);

	input [1:0] alu_op;
	input [1:0] f3;
	input [1:0] f7;
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
			control_i[3:2] = f7[1:0];
		end
	end
endmodule	
