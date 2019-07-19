`include "combined.v"
module combined_tb ();
	reg [63:0] a;
	reg [63:0] b;
	reg [1:0] alu_op;
	reg [1:0] f3;
	reg [1:0] f7;
	wire [63:0] result;
	wire carry_out, zf;
	
	combined DUT(a, b, alu_op, f3, f7, result, carry_out, zf);
	
	initial begin

		$dumpfile("wave.vcd");
		$dumpvars();
		
		a = 32; b = 1; alu_op = 2'b00; 
		
		#10 a = 33; b = 33; alu_op = 2'b01;
		
		#10 alu_op = 2'b10; f3 = 2'b00; f7 = 2'b00;
		
		#10 a = 64'hffffffffffffffff; b = 6;
		
		#10 f7 = 01; a = 64; b = 33;
		
		#10 a = 64'hffffffffffffffff; b = 6;
		
		#10 f3 = 2'b11; f7 = 2'b00;
		
		#10 f7 = 2'b11;
		
		#10 f3 = 2'b10; f7 = 2'b00;
		
		#10 f7 = 2'b11;
		
		
		#10 $finish;
		end
		
		initial begin
		$display("\ta\t\t\tb\t\talu_op\tf3\tf7\tresult\t\t\tcarry_out\tzf");
		$monitor("0x%x\t0x%x\t%b\t%b\t%b\t0x%x\t%b\t\t%b",a, b, alu_op, f3, f7, result, carry_out, zf);
		end
endmodule
