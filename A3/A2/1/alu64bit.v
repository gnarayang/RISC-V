//To build a 64 bit ALU
//Name        : Nishanth Subramanian        Yashas G
//Roll Number : 171CO127                    171CO154
//Date        : October 20 2018  

`include "onebitalu.v"
`include "cla.v"
module ALU64Bit(a, b,less, op, result, G, P, set, overflow, zero);
  input [63:0] a, b;
  input  less;
  input [3:0] op;
  output [63:0] result;
  output cout, G, P, set, overflow, zero;
  wire [63:0]g;
  wire [63:0]p;
  wire [63:1]C;
  wire msb;
  supply0 gnd;
  wire cin = op[2];
  wire bb = b[63]^op[2];
  assign zero = ~result[0] & ~result[1] & ~result[2] & ~result[3] & ~result[4] & ~result[5] & ~result[6] & ~result[7] & ~result[8] & ~result[9] & ~result[10] & ~result[11] & ~result[12] & ~result[13] & ~result[14] & ~result[15] & ~result[16] & ~result[17] & ~result[18] & ~result[19] & ~result[20] & ~result[21] & ~result[22] & ~result[23] & ~result[24] & ~result[25] & ~result[26] & ~result[27] & ~result[28] & ~result[29] & ~result[30] & ~result[31] & ~result[32] & ~result[33] & ~result[34] & ~result[35] & ~result[36] & ~result[37] & ~result[38] & ~result[39] & ~result[40] & ~result[41] & ~result[42] & ~result[43] & ~result[44] & ~result[45] & ~result[46] & ~result[47] & ~result[48] & ~result[49] & ~result[50] & ~result[51] & ~result[52] & ~result[53] & ~result[54] & ~result[55] & ~result[56] & ~result[57] & ~result[58] & ~result[59] & ~result[60] & ~result[61] & ~result[62] & ~result[63];
  assign set = msb | ~msb & overflow;

  ALU1Bit alu0(a[0], b[0], cin, less, op, result[0],, g[0], p[0],);
  ALU1Bit alu[62:1](a[62:1], b[62:1], C[62:1], gnd, op, result[62:1],, g[62:1], p[62:1],);
  ALU1Bit alu63(a[63], b[63], C[63],  gnd,  op, result[63],, g[63], p[63], msb);

  //ALU1Bit alu1(a[0], b[0], cin, less, op, result[0],, g0, p0,);
  //ALU1Bit alu2(a[1], b[1], C1,  gnd,  op, result[1],, g1, p1,);
  //ALU1Bit alu3(a[2], b[2], C2,  gnd,  op, result[2],, g2, p2,);
  //ALU1Bit alu4(a[3], b[3], C3,  gnd,  op, result[3],, g3, p3, msb);
  assign overflow = (a[63] & bb & ~result[63]) | (~a[63] & ~bb &  result[63]);
  CLA cla(g, p, cin, C, G, P);
  //CLA cla(g0, p0, g1, p1, g2, p2, g3, p3, cin, C1, C2, C3, cout, G, P);
endmodule
