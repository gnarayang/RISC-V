//To build a one bit ALU
//Name        : Nishanth Subramanian        Yashas G
//Roll Number : 171CO127                    171CO154
//Date        : October 20 2018  

module ALU1Bit(ain, bin, cin, less, op, result, cout, g, p, set);
  input a, bin, cin, less, ain;
  input [3:0] op;
  output reg result;
  output cout, g, p, set;

  // Invert b if necessary.
  wire b = bin ^ op[2];
  wire a = ain ^ op[3];

  // AND
  assign g = a & b;
  // OR
  assign p = a | b;
  // Sum
  assign set = a ^ b ^ cin;
  // Carry out
  assign cout = a & b | a & cin | b & cin;

  always @(*) begin
    casez (op)
    // a AND b
    'b ?00: result <= g;
    // a OR b
    'b ?01: result <= p;
    // a ADD/SUB b
    'b ?10: result <= set;
    // a SLT b
    'b ?11: result <= less;
    endcase
  end
endmodule