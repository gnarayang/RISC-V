module imm_gen(clk, imm_in, imm_out);
	input clk;
	input [11:0] imm_in;
	output [63:0] imm_out;
	wire [11:0] imm_in;
	reg [63:0] imm_out;
	//reg [63:0] imm_out;
	integer i;
	always begin
	//imm_out = imm_in;
	
	#1 imm_out[11:0] = imm_in[11:0];
	
	for(i = 12; i < 64 ; i = i+1) begin
		imm_out[i] = imm_in[11];
	end
	
	end
	
endmodule
