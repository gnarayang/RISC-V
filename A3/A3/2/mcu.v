

module mcu(input [31:0]instruction, input reset, input clk,output alusrc, output memtoreg, output regwrite, output memread, output memwrite, output branch, output aluop[0:1]);
	
	assign alusrc = ~instruction[5] || ((~instruction[6])&&(~instruction[4])); 
	assign memtoreg = ~instruction[4];
	assign regwrite = ~instruction[5] || instruction[4] ;
	assign memread = (~instruction[5])&&(~instruction[4]);
	assign memwrite = (~instruction[6])&&(instruction[5])&&(~instruction[4]) ;
	assign branch = instruction[6] ;
	assign aluop[0] = instruction[4] ;
	assign aluop[1] = instruction[6] ;
	
endmodule
