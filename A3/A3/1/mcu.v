//Name : 	Nishanth Subramanian		Narayan G	
//Roll No : 171CO127					171CO225
//Date : January 8 2019
//MAIN CONTROL UNIT


module mcu(input [31:0]instruction, output alusrc, output memtoreg, output regwrite, output memread, output memwrite, output branch, output aluop1, output aluop2);
	
	assign alusrc = ~instruction[5] || ((~instruction[6])&&(~instruction[4])); 
	assign memtoreg = ~instruction[4];
	assign regwrite = ~instruction[5] || instruction[4] ;
	assign memread = (~instruction[5])&&(~instruction[4]);
	assign memwrite = (~instruction[6])&&(instruction[5])&&(~instruction[4]) ;
	assign branch = instruction[6] ;
	assign aluop1 = instruction[4] ;
	assign aluop2 = instruction[6] ;
	
endmodule
