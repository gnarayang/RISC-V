//Name : 	Nishanth Subramanian		Narayan G	
//Roll No : 171CO127					171CO225
//Date : January 8 2019
//FULL DATAPATH


`include "completeALU.v"
module mcu(input [31:0]instruction, input reset, input clk,output alusrc, output memtoreg, output regwrite, output memread, output memwrite, output branch, output [1:0] aluop);
	

	assign alusrc = ~instruction[5] | ((~instruction[6])&(~instruction[4])); 
	assign memtoreg = ~instruction[4];
	assign regwrite = ~instruction[5] | instruction[4] ;
	assign memread = (~instruction[5])&(~instruction[4]);
	assign memwrite = (~instruction[6])&(instruction[5])&(~instruction[4]) ;
	assign branch = instruction[6] ;
	assign aluop[1] = instruction[4] ;
	assign aluop[0] = instruction[6] ;
	
	
endmodule

module immediateBlock(instruction,O);

input [31:0]instruction;
output reg [63:0]O;
wire [6:0]opcode;

assign opcode = instruction[6:0];

always@(instruction)
begin
    if(opcode == 7'b0010011)
    begin
        O[11:0] <= instruction[31:20];
        if(instruction[31])
            O[63:12] <= 52'hfffffffffffff;
        else
            O[63:12] <= 52'h0;
    end

    else if(opcode == 7'b0000011)
    begin
        O[11:0] <= instruction[31:20];
        if(instruction[31])
            O[63:12] <= 52'hfffffffffffff;
        else
            O[63:12] <= 52'h0;
    end
    else if(opcode == 7'b0100011)
    begin
        O[4:0] = instruction[11:7];
        O[11:5] = instruction[31:25];
        if(instruction[31])
            O[63:12] <= 52'hfffffffffffff;
        else
            O[63:12] <= 52'h0;
    end
    else if(opcode == 7'b1100011)
    begin
        O[3:0] = instruction[11:8];
        O[9:4] = instruction[30:25];
        O[10] = instruction[7];
        O[11] = instruction[31];
        if(instruction[31])
            O[63:12] <= 52'hfffffffffffff;
        else
            O[63:12] <= 52'h0;
    end
    else    
        O[63:0] = 64'hx;
end

endmodule

module fulldatapath(PC,clk,reset,new_PC,ans,instruction);

    input [63:0]PC;
    input clk,reset;
    output [63:0]new_PC,ans;
    output [31:0]instruction;

    reg [31:0]instructionMemory[0:1023];
    reg [63:0]DM[0:131071];
    reg [63:0]RF[0:31];
    reg [63:0]rData;

    wire alusrc, memtoreg, regwrite, memwrite, memread, branch, cout, zero, overflow;
    wire [1:0]aluop;
    wire [63:0]imm,instructionmmediate,secondaluinput,result;
    wire [2:0] funct;
    integer k;

    assign instruction=instructionMemory[PC];
    assign secondaluinput = alusrc ? imm : RF[instruction[24:20]];
    assign funct = ((~instruction[6]) & instruction[5] & instruction[4]) ? {instruction[30],instruction[13],instruction[12]} : instruction[14:12];
    assign instructionmmediate = imm<<1;
    
    mcu m0(instruction, reset, clk, alusrc, memtoreg, regwrite, memread, memwrite, branch, aluop);
    immediateBlock m1(instruction,imm);
    completeALU m3(RF[instruction[19:15]],secondaluinput,aluop,funct,result,cout,zero,overflow);


    always@(posedge clk)
    begin
        instructionMemory[10] <= 32'b 00000000000001001011000100000011;
        instructionMemory[11] <= 32'b 00000000010001001011000010000011;
        instructionMemory[12] <= 32'b 00000000001000001000011001100011;
        instructionMemory[13] <= 32'b 01000000000100010000000110110011;
        instructionMemory[14] <= 32'b 00000000100100011000010000100011;
        instructionMemory[24] <= 32'b 11111110011100010000000110010011;
        instructionMemory[25] <= 32'b 00000000100100011000010000100011;
        instructionMemory[26] <= 32'b 00000000000000011011001100000011;
 
    end

    always@(posedge clk, rData)
    begin
        if(regwrite)
            RF[instruction[11:7]] <= rData;
        if(reset)
        begin
            for(k=0;k<32;k=k+1)
                RF[k] <= k;
        end
    end

    always@(posedge clk, result)
    begin
        DM[9] <= 50;
        DM[13] <= 50;
        DM[25] <=46;
        if(memread)
            rData <= DM[result];
        if(memwrite)
            DM[result] <= RF[instruction[24:20]];

    end

    always@(result)
    begin
        if(!memtoreg)
            rData <= result;
    end

    assign new_PC = (zero & branch) ? PC + instructionmmediate : PC +1;
    assign ans = regwrite ? RF[instruction[11:7]] : 64'hx;

endmodule


