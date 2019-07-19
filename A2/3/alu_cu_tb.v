`include "alu_cu.v"
module alu_cu_tb();

	reg [1:0] alu_op;
	reg [1:0] f3;
	reg [1:0] f7;
	wire [3:0] control_i;

	alu_cu DUT(alu_op, f3, f7, control_i);

	initial begin

		$dumpfile("wave.vcd");
		$dumpvars();

		alu_op = 2'b00;
		
		#10 alu_op = 2'b01;
		
		#10 alu_op = 2'b10; f7 = 2'b00; f3 = 2'b00;

		#10 alu_op = 2'b10; f7 = 2'b01; f3 = 2'b00;
		
		#10 alu_op = 2'b10; f7 = 2'b00; f3 = 2'b11;
		
		#10 alu_op = 2'b10; f7 = 2'b00; f3 = 2'b10;
		
		#10 $finish;
		
		end
		
		
		initial begin
		$display("alu_op\tf7\tf3\tcontrol_i");
		$monitor("%b\t%b\t%b\t%b",alu_op, f7, f3, control_i);
		end
endmodule
