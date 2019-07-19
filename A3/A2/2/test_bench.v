`include "imm_gen.v"
module imm_gen_tb();
	reg [11:0] imm_in;
	wire[63:0] imm_out;
	reg clk;
	imm_gen DUT(clk, imm_in, imm_out);
	
	//initial begin
      //  clk=1'b1;
        //repeat(100)
          //  #1 clk=~clk;
    //end
    
	initial
	begin
	
		$dumpfile("wave.vcd");
		$dumpvars();
		
		#10 imm_in = 12'b011110010101;
		
		#10 imm_in = 12'b101110010101;
		
		#10 imm_in = 12'b101010010101;
		
		#10 imm_in = 12'b001110010101;
		
		#10 $finish;
	end
	
	initial
	begin
		$display("\tInput   \t\t\tOutput");
		$monitor("\t%b\t%b",imm_in, imm_out);
	end
	
endmodule
