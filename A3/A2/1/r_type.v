`include "64alu_withcu.v"
`include "register_block.v"

module r_type(input clk , input reset, input [32:0]instruction, input [4:0]write_reg, input [63:0]write_data, input reg_write, output [63:0] result);

	wire [63:0] result;
	reg [4:0] read_reg1, read_reg2;
	wire [4:0] write_reg;
	reg [63:0] write_data;
	wire reg_write;
	wire [63:0] read_data1, read_data2;
	reg less;
	reg [5:0] in;
	wire G, P, set, overflow, zero;
	integer i;	
	
	reg_file r(read_reg1, read_reg2, write_reg, write_data, reg_write, clk, reset, read_data1, read_data2);
	
	alu64_withcu alu(read_data1, read_data1, less, in[5:0], result[63:0], G, P, set, overflow, zero);
	
	always @(posedge clk) begin
		read_reg1[4:0] = instruction[19:15];
		read_reg2[4:0] = instruction[24:20];
    
		less = 0;
		in[2:0] = instruction[14:12];
		in[3] = instruction[30];
		in[4] = instruction[6] & instruction[4] & (~instruction[4]);
		in[5] = (~instruction[6]) & instruction[4] & instruction[4];		
	
		write_data = result;
	
	end
	
endmodule
