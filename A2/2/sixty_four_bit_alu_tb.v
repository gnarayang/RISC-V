`include "sixty_four_bit_alu.v"
module sixty_four_bit_alu_tb();

	reg [63:0] a, b;
	reg a_invert, b_invert, carry_in;
	reg [1:0] operation;
	wire carry_out, zf;
	wire [63:0] result;
	
	sixty_four_bit_alu DUT(a, a_invert, b, b_invert, operation, carry_in, result, carry_out, zf);
	
	initial begin

		$dumpfile("wave.vcd");
		$dumpvars();
		
		a = 64'h0000000000000001 ; b = 64'hffffffffffffffff ; a_invert = 0 ; b_invert = 0 ; operation = 2'b00 ; carry_in = 0 ;
		
		#10 operation = 2'b01;
		
		#10 operation = 2'b10;
		
		#10 $finish;
		end
		
		initial begin
		$display("  \ta\t\t  \tb\t\toperation\tcarry_in\tresult\t\t\tcarry_out\tzf");
		$monitor("0x%x\t0x%x\t%x\t\t%x\t\t0x%x\t%x\t\t%x",a, b, operation, carry_in, result, carry_out, zf);
		end
endmodule
