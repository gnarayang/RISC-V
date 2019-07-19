// Assignment by Narayan G 17CO225 and Dhanasekhar M 17CO214
// Date - 25-10-2018
// 32 bit Register file


module mux_2x1(i0, i1, select, out);
	input [63:0] i0, i1;
	input select;
	output [63:0] out;

	assign out = (select)?i1:i0 ;
	
endmodule

module mux_4x1(i0, i1, i2, i3, select, out);
	
	input [63:0] i0,i1,i2,i3;
	input [1:0] select;
	output [63:0] out;

	wire [63:0] out1, out2;

	mux_2x1 m1(i0, i1, select[0], out1);        //Instantiating three 2x1 Multiplexeres
	mux_2x1 m2(i2, i3, select[0], out2);
	mux_2x1 m3(out1, out2, select[1], out);


endmodule

module mux_16x1(i0,i1,i2,i3,i4,i5,i6,i7,i8,i9,i10,i11,i12,i13,i14,i15,select,out);
	
	input [63:0] i0,i1,i2,i3,i4,i5,i6,i7,i8,i9,i10,i11,i12,i13,i14,i15;
	input [3:0] select;
	output [63:0] out;
	
	wire [63:0] out1, out2, out3, out4;
	
	mux_4x1 m1(i0,i1,i2,i3,select[1:0],out1);                //Instantiating five 4x1 Multiplexeres
	mux_4x1 m2(i4,i5,i6,i7,select[1:0],out2);
	mux_4x1 m3(i8,i9,i10,i11,select[1:0],out3);
	mux_4x1 m4(i12,i13,i14,i15,select[1:0],out4);
	
	mux_4x1 m5(out1, out2, out3, out4, select[3:2], out);
	
endmodule

module mux_32x1(i0,i1,i2,i3,i4,i5,i6,i7,i8,i9,i10,i11,i12,i13,i14,i15,i16,i17,i18,i19,i20,i21,i22,i23,i24,i25,i26,i27,i28,i29,i30,i31,select,out);

	input [63:0] i0,i1,i2,i3,i4,i5,i6,i7,i8,i9,i10,i11,i12,i13,i14,i15,i16,i17,i18,i19,i20,i21,i22,i23,i24,i25,i26,i27,i28,i29,i30,i31 ;
	input [4:0] select;
	output [63:0] out;
	
	wire [63:0] out1, out2;
	
	mux_16x1 m1(i0,i1,i2,i3,i4,i5,i6,i7,i8,i9,i10,i11,i12,i13,i14,i15, select[3:0], out1);
	mux_16x1 m2(i16,i17,i18,i19,i20,i21,i22,i23,i24,i25,i26,i27,i28,i29,i30,i31,select[3:0],out2);  //Instantiating two 16x1 Multiplexeres
	
	mux_2x1 m3(out1, out2, select[4], out);   //Instantiating a 2x1 Multiplexer

endmodule


module d_ff(d, clock, reset, q, write);               // D-flipflop module

	input  d;
	input clock, reset, write;
	output  q;
	
	reg  q;
	
	always @(posedge clock, negedge reset) begin
		if(reset == 0) begin 
				 q <= 0;
		end
		
		if(reset ==1 && write == 1) begin 
			 q <= d;
		end
	end

endmodule

module register(d, clock, reset, q, write);            //32-bit register module

	input [63:0] d;
	input clock, reset, write;
	output [63:0] q;

	
	d_ff dut[63:0](d[63:0],clock, reset, q[63:0], write);  //Instantiating the d-filpflop module 32 times

endmodule

module decoder(write_reg, out);                   //decoder module for register write operation
	input [4:0] write_reg;
	output [63:0] out;                            //out variable gives a 32 bit value with the write_register bit high
	
	reg [63:0] out;
	always @(*) begin
		case(write_reg)
			5'b00000 : out = 64'h00000001;
			5'b00001 : out = 64'h00000002;
			5'b00010 : out = 64'h00000004;
			5'b00011 : out = 64'h00000008;
			5'b00100 : out = 64'h00000010;
			5'b00101 : out = 64'h00000020;
			5'b00110 : out = 64'h00000040;
			5'b00111 : out = 64'h00000080;
			5'b01000 : out = 64'h00000100;
			5'b01001 : out = 64'h00000200;
			5'b01010 : out = 64'h00000400;
			5'b01011 : out = 64'h00000800;
			5'b01100 : out = 64'h00001000;													
			5'b01101 : out = 64'h00002000;
			5'b01110 : out = 64'h00004000;
			5'b01111 : out = 64'h00008000;
			5'b10000 : out = 64'h00010000;
			5'b10001 : out = 64'h00020000;
			5'b10010 : out = 64'h00040000;
			5'b10011 : out = 64'h00080000;
			5'b10100 : out = 64'h00100000;
			5'b10101 : out = 64'h00200000;
			5'b10110 : out = 64'h00400000;
			5'b10111 : out = 64'h00800000;
			5'b11000 : out = 64'h01000000;
			5'b11001 : out = 64'h02000000;
			5'b11010 : out = 64'h04000000;
			5'b11011 : out = 64'h08000000;
			5'b11100 : out = 64'h10000000;
			5'b11101 : out = 64'h20000000;
			5'b11110 : out = 64'h40000000;
			5'b11111 : out = 64'h80000000;
		endcase
	end
endmodule



module reg_file(read_reg1, read_reg2, write_reg, write_data, reg_write, clock, reset, read_data1, read_data2);
	
	input [4:0] read_reg1, read_reg2, write_reg;
	input [63:0] write_data;
	input reg_write,clock, reset;

	output [63:0] read_data1, read_data2;

	wire [63:0] d1_out;
	wire [63:0] q0,q1,q2,q3,q4,q5,q6,q7,q8,q9,q10,q11,q12,q13,q14,q15,q16,q17,q18,q19,q20,q21,q22,q23,q24,q25,q26,q27,q28,q29,q30,q31;     //32 registers' values
	wire [63:0] d_out ;

	decoder d(write_reg, d1_out);                        //decoder Instantiation

	assign d_out = (reg_write)? d1_out:32'b0;           /*d_out will be zero if reg_write is zero indicating that the write operation will not occur	
                                                           and will be same as decoder output if reg_write is 1*/															 
	register r0(write_data, clock, reset, q0, d_out[0]);
	register r1(write_data, clock, reset, q1, d_out[1]);
	register r2(write_data, clock, reset, q2, d_out[2]);
	register r3(write_data, clock, reset, q3, d_out[3]);
	register r4(write_data, clock, reset, q4, d_out[4]);
	register r5(write_data, clock, reset, q5, d_out[5]);       //if d_out[n] = 1, then the data will be written on the n'th register.  
	register r6(write_data, clock, reset, q6, d_out[6]);
	register r7(write_data, clock, reset, q7, d_out[7]);
	register r8(write_data, clock, reset, q8, d_out[8]);
	register r9(write_data, clock, reset, q9, d_out[9]);
	register r10(write_data, clock, reset, q10, d_out[10]);
	register r11(write_data, clock, reset, q11, d_out[11]);
	register r12(write_data, clock, reset, q12, d_out[12]);
	register r13(write_data, clock, reset, q13, d_out[13]);
	register r14(write_data, clock, reset, q14, d_out[14]);
	register r15(write_data, clock, reset, q15, d_out[15]);
	register r16(write_data, clock, reset, q16, d_out[16]);
	register r17(write_data, clock, reset, q17, d_out[17]);
	register r18(write_data, clock, reset, q18, d_out[18]);
	register r19(write_data, clock, reset, q19, d_out[19]);
	register r20(write_data, clock, reset, q20, d_out[20]);
	register r21(write_data, clock, reset, q21, d_out[21]);
	register r22(write_data, clock, reset, q22, d_out[22]);
	register r23(write_data, clock, reset, q23, d_out[23]);
	register r24(write_data, clock, reset, q24, d_out[24]);
	register r25(write_data, clock, reset, q25, d_out[25]);
	register r26(write_data, clock, reset, q26, d_out[26]);
	register r27(write_data, clock, reset, q27, d_out[27]);
	register r28(write_data, clock, reset, q28, d_out[28]);
	register r29(write_data, clock, reset, q29, d_out[29]);
	register r30(write_data, clock, reset, q30, d_out[30]);
	register r31(write_data, clock, reset, q31, d_out[31]);

	mux_32x1 m(q0,q1,q2,q3,q4,q5,q6,q7,q8,q9,q10,q11,q12,q13,q14,q15,q16,q17,q18,q19,q20,q21,q22,q23,q24,q25,q26,q27,q28,q29,q30,q31, read_reg1, read_data1); //muxes to read the data from a specific register(read_reg) 

	mux_32x1 m1(q0,q1,q2,q3,q4,q5,q6,q7,q8,q9,q10,q11,q12,q13,q14,q15,q16,q17,q18,q19,q20,q21,q22,q23,q24,q25,q26,q27,q28,q29,q30,q31, read_reg2, read_data2);


endmodule




























