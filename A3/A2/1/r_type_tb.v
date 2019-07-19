`include "r_type.v"


module r_type_tb();
	reg clk, reset;
	reg [32:0]instruction;
	reg [4:0]write_reg;
	reg [63:0]write_data;
	reg reg_write;
	wire [63:0]result;
	
	r_type DUT(clk, reset, instruction, write_reg, write_data, reg_write, result);
	
	always begin
		
		#5 clk = ~clk;
		
	end
	
	initial begin

		$dumpfile("wave.vcd");
		$dumpvars();
		
		clk = 0;
		
		reset = 1;
		
		for(i=0; i<32; i=i+1) begin
			#10 write_data = i; write_reg = i ; reg_write = 1;  //writing data to registers
		end
		
		#40
		
		#2 instruction[32:0]= 32'b 00000000011000111000001100110011;     
        #10 instruction[32:0]= 32'b 01000000011000111000001100110011;     
        #10 instruction[32:0]= 32'b 00000000000100010111000110110011;     
        #10 instruction[32:0]= 32'b 00000000000100010110000110110011;     
        #10 instruction[32:0]= 32'b 01000000010000101110001100110011;     
        #10 instruction[32:0]= 32'b 01000000010000101111001110110011;     
		
		#10 $finish;
	end
	
	initial begin
		$display("Instruction\t\t\t\t\tResult\t\t\t\t\t\t\tTime");
		$monitor("%b\t%b\t%d",instruction[32:0], result[63:0], $time);
	end
	
	
endmodule
