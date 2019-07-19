//To build a complete ALU with ALU control
//Name        : Nishanth Subramanian        Yashas G
//Roll Number : 171CO127                    171CO154
//Date        : October 20 2018  

`include "alu64bit.v"
`include "alucu.v"
module alu64_withcu(a,b,less,in,result,G,P,set,overflow,zero);
    input [5:0]in;
    input [63:0]a,b;
    input less;
    output [63:0]result;
    output G, P, set, overflow, zero;
    wire [3:0]op;
    alucu al(in,op);
    ALU64Bit alu(a, b, less, op, result, G, P, set, overflow, zero);

endmodule
