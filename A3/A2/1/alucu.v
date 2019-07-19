module alucu(in,operation);
input [5:0]in;
output [3:0]operation;
reg [3:0]operation;

always @ (in)
begin
if(in[5]==1'b0 && in[4]==1'b0)
     operation = 4'b0010;
else if(in[5]==1'b0 && in[4]==1'b1)
     operation = 4'b0110;
else
    begin
         operation[3]=in[5] & in[3] & in[2];
         operation[2]=in[3];
         operation[1]=~(in[0] | in[1]);
         operation[0]=(in[5]&~in[4]&in[3]&in[2]&in[1]&~in[0]) | (in[5]&~in[4]&~in[3]&in[2]&in[1]&~in[0]);
    end
end
endmodule