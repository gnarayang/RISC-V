//Name : 	Nishanth Subramanian		Narayan G	
//Roll No : 171CO127					171CO225
//Date : January 8 2019
//FULL DATAPATH


`include "mcu.v"

module mcu_tb();

	reg [31:0]instruction;
	wire alusrc;
	wire memtoreg;
	wire regwrite;
	wire memread;
	wire memwrite;
	wire branch;
	wire aluop1;
	wire aluop2;
	
	mcu DUT(instruction, alusrc, memtoreg, regwrite, memread, memwrite, branch, aluop1, aluop2);
	
	initial
		begin
			$dumpfile("wave.vcd");
			$dumpvars();
		
			instruction = 32'b 00000000000001001011000100000011;
			#10 instruction = 32'b 00000000010001001011000010000011;
			#10 instruction = 32'b 00000000001000001000011001100011;
			#10 instruction = 32'b 01000000000100010000000110110011;
			#10 instruction = 32'b 00000000100100011000010000100011;
			#10 instruction = 32'b 11111110011100010000000110010011;
			#10 instruction = 32'b 00000000100100011000010000100011;
			#10 instruction = 32'b 00000000000000011011001100000011;

			#10 $finish;
	
		end
		
		initial
			begin
		
				$display("Instruction\t\t\t\tAlusrc\tMemtoReg\tRegWrite\tMemRead\t\tMemWrite\tBranch\top1\top2");
				$monitor("%b\t%b\t%b\t\t%b\t\t%b\t\t%b\t\t%b\t%b\t%b",instruction, alusrc, memtoreg, regwrite, memread, memwrite, branch, aluop1, aluop2);
		
			end


endmodule


