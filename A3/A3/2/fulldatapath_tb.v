//Name : 	Nishanth Subramanian		Narayan G	
//Roll No : 171CO127					171CO225
//Date : January 8 2019
//FULL DATAPATH

`include "fulldatapath.v"
module fulldatapath_tb;
reg [63:0] PC;
reg clk,reset;
wire [63:0] new_PC,ans;
wire [31:0] instruction;
integer k;

fulldatapath m0(PC,clk,reset,new_PC,ans,instruction);

initial
begin 
    $dumpfile("fulldatapath.vcd");
    $dumpvars(0,fulldatapath_tb);
    reset=1'b1;
end

initial
begin
    clk = 1'b0;
    repeat(100)
        #1 clk=~clk;
end

initial
begin
    #4 reset = 1'b0;
    $display("Values : \nxi=i\n0(x9) and 4(x9) have the value 50\n25th address has the value 46\n");
    $display("\n\tld x2,0(x9)\n\tld x1,4(x9)\n\tbeq x2,x1,6\nback:\n\tsub x3,x2,8(x9)\nlabel:\n\taddi x3,x2,-25\n\tsd x3,8(x9)\n\tld x6,0(x3)");
    $display("\n\tInstruction\t\t\t\t\tPC\t\t\t\tnew_PC\t\t\tresult");
    PC=64'ha;
    #1 $monitor("%b\t\t%h\t\t%h\t\t   %3d",instruction,PC,new_PC,ans);
    for(k=0;k<5;k=k+1)
        #2 PC = new_PC;
    #10 $finish;
end
endmodule
    
