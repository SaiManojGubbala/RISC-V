// Verifying RISC-V RV32I Processor without any pipeline 

module mux4x1 (
    input [3:0] A,
    input [1:0]S,
    output Y
);
wire [1:0] mux_con;

mux2x1 m1(.A(A[3:2]),.S(S[0]),.Y(mux_con[1]));
mux2x1 m2(.A(A[1:0]),.S(S[0]),.Y(mux_con[0]));
mux2x1 m3(.A({mux_con}),.S(S[1]),.Y(Y));

endmodule //4x1mux4x1 Mux 

module mux16x1 (
    input [15:0] A,
    input [3:0] S,
    output Y
);
wire [3:0] mux_con;
mux4x1 m4(.A(A[15:12]),.S(S[1:0]),.Y(mux_con[3]));
mux4x1 m5(.A(A[11:8]),.S(S[1:0]),.Y(mux_con[2]));
mux4x1 m6(.A(A[7:4]),.S(S[1:0]),.Y(mux_con[1]));
mux4x1 m7(.A(A[3:0]),.S(S[1:0]),.Y(mux_con[0]));
mux4x1 m8(.A(mux_con),.S(S[3:2]),.Y(Y));

endmodule //16x4 Mux 

module mux32x1 (
    input [31:0] A,
    input [4:0] S,
    output Y
);

wire [1:0] mux_con;
mux16x1 m9(.A(A[31:16]),.S(S[3:0]),.Y(mux_con[1]));
mux16x1 m10(.A(A[15:0]),.S(S[3:0]),.Y(mux_con[0]));
mux2x1 m11(.A(mux_con),.S(S[4]),.Y(Y));

endmodule // 32x5 Mux

//Implementing the logic Block of the circuit

module xor_4 (
    input [3:0] A,B,
    output [3:0] C
);

xor(C[0],A[0],B[0]);
xor(C[1],A[1],B[1]);
xor(C[2],A[2],B[2]);
xor(C[3],A[3],B[3]);

endmodule //4 Bit Xor Block

module xor_16 (
    input [15:0] A,B,
    output [15:0] C    
);

xor_4 h1(.A(A[3:0]),.B(B[3:0]),.C(C[3:0]));
xor_4 h2(.A(A[7:4]),.B(B[7:4]),.C(C[7:4]));
xor_4 h3(.A(A[11:8]),.B(B[11:8]),.C(C[11:8]));
xor_4 h4(.A(A[15:12]),.B(B[15:12]),.C(C[15:12]));

endmodule //16 Bit Xor Block

module and_4 (
    input [3:0] A,B,
    output [3:0] C
);

and(C[0],A[0],B[0]);
and(C[1],A[1],B[1]);
and(C[2],A[2],B[2]);
and(C[3],A[3],B[3]);

endmodule //4 Bit And Block

module and_16 (
    input [15:0] A,B,
    output [15:0] C    
);

and_4 k1(.A(A[3:0]),.B(B[3:0]),.C(C[3:0]));
and_4 k2(.A(A[7:4]),.B(B[7:4]),.C(C[7:4]));
and_4 k3(.A(A[11:8]),.B(B[11:8]),.C(C[11:8]));
and_4 k4(.A(A[15:12]),.B(B[15:12]),.C(C[15:12]));

endmodule //16 Bit And Block

module or_4 (
    input [3:0] A,B,
    output [3:0] C
);

or(C[0],A[0],B[0]);
or(C[1],A[1],B[1]);
or(C[2],A[2],B[2]);
or(C[3],A[3],B[3]);

endmodule //4 Bit or Block

module or_16 (
    input [15:0] A,B,
    output [15:0] C    
);

or_4 l1(.A(A[3:0]),.B(B[3:0]),.C(C[3:0]));
or_4 l2(.A(A[7:4]),.B(B[7:4]),.C(C[7:4]));
or_4 l3(.A(A[11:8]),.B(B[11:8]),.C(C[11:8]));
or_4 l4(.A(A[15:12]),.B(B[15:12]),.C(C[15:12]));

endmodule //16 Bit or Block

// Now using the 32x5 mux we need to implement the shift logic but firstly create that logic

module shift_logic (
    input [31:0] A,B,
    input S,
    input [4:0] Control,
    output Y
);

wire [31:0] mux_connectors;
mux2x1 a1(.A({A[31],B[31]}),.S(S),.Y(mux_connectors[31]));
mux2x1 a2(.A({A[30],B[30]}),.S(S),.Y(mux_connectors[30]));
mux2x1 a3(.A({A[29],B[29]}),.S(S),.Y(mux_connectors[29]));
mux2x1 a4(.A({A[28],B[28]}),.S(S),.Y(mux_connectors[28]));
mux2x1 a5(.A({A[27],B[27]}),.S(S),.Y(mux_connectors[27]));
mux2x1 a6(.A({A[26],B[26]}),.S(S),.Y(mux_connectors[26]));
mux2x1 a7(.A({A[25],B[25]}),.S(S),.Y(mux_connectors[25]));
mux2x1 a8(.A({A[24],B[24]}),.S(S),.Y(mux_connectors[24]));
mux2x1 a9(.A({A[23],B[23]}),.S(S),.Y(mux_connectors[23]));
mux2x1 a10(.A({A[22],B[22]}),.S(S),.Y(mux_connectors[22]));
mux2x1 a11(.A({A[21],B[21]}),.S(S),.Y(mux_connectors[21]));
mux2x1 a12(.A({A[20],B[20]}),.S(S),.Y(mux_connectors[20]));
mux2x1 a13(.A({A[19],B[19]}),.S(S),.Y(mux_connectors[19]));
mux2x1 a14(.A({A[18],B[18]}),.S(S),.Y(mux_connectors[18]));
mux2x1 a15(.A({A[17],B[17]}),.S(S),.Y(mux_connectors[17]));
mux2x1 a16(.A({A[16],B[16]}),.S(S),.Y(mux_connectors[16]));
mux2x1 a17(.A({A[15],B[15]}),.S(S),.Y(mux_connectors[15]));
mux2x1 a18(.A({A[14],B[14]}),.S(S),.Y(mux_connectors[14]));
mux2x1 a19(.A({A[13],B[13]}),.S(S),.Y(mux_connectors[13]));
mux2x1 a20(.A({A[12],B[12]}),.S(S),.Y(mux_connectors[12]));
mux2x1 a21(.A({A[11],B[11]}),.S(S),.Y(mux_connectors[11]));
mux2x1 a22(.A({A[10],B[10]}),.S(S),.Y(mux_connectors[10]));
mux2x1 a23(.A({A[9],B[9]}),.S(S),.Y(mux_connectors[9]));
mux2x1 a24(.A({A[8],B[8]}),.S(S),.Y(mux_connectors[8]));
mux2x1 a25(.A({A[7],B[7]}),.S(S),.Y(mux_connectors[7]));
mux2x1 a26(.A({A[6],B[6]}),.S(S),.Y(mux_connectors[6]));
mux2x1 a27(.A({A[5],B[5]}),.S(S),.Y(mux_connectors[5]));
mux2x1 a28(.A({A[4],B[4]}),.S(S),.Y(mux_connectors[4]));
mux2x1 a29(.A({A[3],B[3]}),.S(S),.Y(mux_connectors[3]));
mux2x1 a30(.A({A[2],B[2]}),.S(S),.Y(mux_connectors[2]));
mux2x1 a31(.A({A[1],B[1]}),.S(S),.Y(mux_connectors[1]));
mux2x1 a32(.A({A[0],B[0]}),.S(S),.Y(mux_connectors[0]));
mux32x1 a33(.A(mux_connectors),.S(Control),.Y(Y));

endmodule

module not32bit (
    input [31:0] in,
    output [31:0] out
);

  not (out[0], in[0]);
  not (out[1], in[1]);
  not (out[2], in[2]);
  not (out[3], in[3]);
  not (out[4], in[4]);
  not (out[5], in[5]);
  not (out[6], in[6]);
  not (out[7], in[7]);
  not (out[8], in[8]);
  not (out[9], in[9]);
  not (out[10], in[10]);
  not (out[11], in[11]);
  not (out[12], in[12]);
  not (out[13], in[13]);
  not (out[14], in[14]);
  not (out[15], in[15]);
  not (out[16], in[16]);
  not (out[17], in[17]);
  not (out[18], in[18]);
  not (out[19], in[19]);
  not (out[20], in[20]);
  not (out[21], in[21]);
  not (out[22], in[22]);
  not (out[23], in[23]);
  not (out[24], in[24]);
  not (out[25], in[25]);
  not (out[26], in[26]);
  not (out[27], in[27]);
  not (out[28], in[28]);
  not (out[29], in[29]);
  not (out[30], in[30]);
  not (out[31], in[31]);

endmodule


module and32bit (
    input [31:0] in,
    output out
);

  wire and_result1, and_result2, and_result3, and_result4;

  and (and_result1, in[0], in[1], in[2], in[3]);
  and (and_result2, in[4], in[5], in[6], in[7]);
  and (and_result3, in[8], in[9], in[10], in[11]);
  and (and_result4, in[12], in[13], in[14], in[15]);

  wire and_result5, and_result6, and_result7, and_result8;

  and (and_result5, in[16], in[17], in[18], in[19]);
  and (and_result6, in[20], in[21], in[22], in[23]);
  and (and_result7, in[24], in[25], in[26], in[27]);
  and (and_result8, in[28], in[29], in[30], in[31]);

  wire final_and_result;

  and (final_and_result, and_result1, and_result2, and_result3, and_result4);
  and (out, final_and_result, and_result5, and_result6, and_result7, and_result8);

endmodule

module ha(input a,b,
output c,s);

xor(s,a,b);
and(c,a,b);

endmodule // half adder

module fa(input a,b,c,
output sum,carry);

wire [2:0] conn;

ha q1(.a(a),.b(b),.s(conn[0]),.c(conn[1]));
ha q2(.a(conn[0]),.b(c),.s(sum),.c(conn[2]));
or (carry,conn[1],conn[2]);

endmodule

module ad4(input [3:0]a,b,
input c,
output [3:0] sum,
output carry);

wire [2:0] connectors;

fa q3(.a(a[0]),.b(b[0]),.c(c),.sum(sum[0]),.carry(connectors[0]));
fa q4(.a(a[1]),.b(b[1]),.c(connectors[0]),.sum(sum[1]),.carry(connectors[1]));
fa q5(.a(a[2]),.b(b[2]),.c(connectors[1]),.sum(sum[2]),.carry(connectors[2]));
fa q6(.a(a[3]),.b(b[3]),.c(connectors[2]),.sum(sum[3]),.carry(carry));

endmodule

module ad16(input [15:0]a,b,
input c,
output [15:0] sum,
output carry);

wire [2:0] connectors;

ad4 q7(.a(a[3:0]),.b(b[3:0]),.c(c),.sum(sum[3:0]),.carry(connectors[0]));
ad4 q8(.a(a[7:4]),.b(b[7:4]),.c(connectors[0]),.sum(sum[7:4]),.carry(connectors[1]));
ad4 q9(.a(a[11:8]),.b(b[11:8]),.c(connectors[1]),.sum(sum[11:8]),.carry(connectors[2]));
ad4 q10(.a(a[15:12]),.b(b[15:12]),.c(connectors[2]),.sum(sum[15:12]),.carry(carry));

endmodule

module ad32(input [31:0]a,b,
input c,
output [31:0] sum,
output carry);

wire connectors;

ad16 q11(.a(a[15:0]),.b(b[15:0]),.c(c),.sum(sum[15:0]),.carry(connectors));
ad16 q12(.a(a[31:16]),.b(b[31:16]),.c(connectors),.sum(sum[31:16]),.carry(carry));

endmodule

module mux2x1 (
    input [1:0] A,
    input S,
    output Y
);
wire[1:0] mux_con;
wire non;

not(non,S);
and(mux_con[0],A[1],non);
and(mux_con[1],A[0],S);
or(Y,mux_con[0],mux_con[1]);

endmodule //2x1 Mux

module mux2x1_32bit (
    input [31:0] a, b,
    input sel,
    output [31:0] out
);
  mux2x1 d1(.A({a[0],b[0]}),.S(sel),.Y(out[0]));
  mux2x1 d2(.A({a[1],b[1]}),.S(sel),.Y(out[1]));
  mux2x1 d3(.A({a[2],b[2]}),.S(sel),.Y(out[2]));
  mux2x1 d4(.A({a[3],b[3]}),.S(sel),.Y(out[3]));
  mux2x1 d5(.A({a[4],b[4]}),.S(sel),.Y(out[4]));
  mux2x1 d6(.A({a[5],b[5]}),.S(sel),.Y(out[5]));
  mux2x1 d7(.A({a[6],b[6]}),.S(sel),.Y(out[6]));
  mux2x1 d8(.A({a[7],b[7]}),.S(sel),.Y(out[7]));

  mux2x1 d9(.A({a[8],b[8]}),.S(sel),.Y(out[8]));
  mux2x1 d10(.A({a[9],b[9]}),.S(sel),.Y(out[9]));
  mux2x1 d11(.A({a[10],b[10]}),.S(sel),.Y(out[10]));
  mux2x1 d12(.A({a[11],b[11]}),.S(sel),.Y(out[11]));
  mux2x1 d13(.A({a[12],b[12]}),.S(sel),.Y(out[12]));
  mux2x1 d14(.A({a[13],b[13]}),.S(sel),.Y(out[13]));
  mux2x1 d15(.A({a[14],b[14]}),.S(sel),.Y(out[14]));
  mux2x1 d16(.A({a[15],b[15]}),.S(sel),.Y(out[15]));

  mux2x1 d17(.A({a[16],b[16]}),.S(sel),.Y(out[16]));
  mux2x1 d18(.A({a[17],b[17]}),.S(sel),.Y(out[17]));
  mux2x1 d19(.A({a[18],b[18]}),.S(sel),.Y(out[18]));
  mux2x1 d20(.A({a[19],b[19]}),.S(sel),.Y(out[19]));
  mux2x1 d21(.A({a[20],b[20]}),.S(sel),.Y(out[20]));
  mux2x1 d22(.A({a[21],b[21]}),.S(sel),.Y(out[21]));
  mux2x1 d23(.A({a[22],b[22]}),.S(sel),.Y(out[22]));
  mux2x1 d24(.A({a[23],b[23]}),.S(sel),.Y(out[23]));

  mux2x1 d25(.A({a[24],b[24]}),.S(sel),.Y(out[24]));
  mux2x1 d26(.A({a[25],b[25]}),.S(sel),.Y(out[25]));
  mux2x1 d27(.A({a[26],b[26]}),.S(sel),.Y(out[26]));
  mux2x1 d28(.A({a[27],b[27]}),.S(sel),.Y(out[27]));
  mux2x1 d29(.A({a[28],b[28]}),.S(sel),.Y(out[28]));
  mux2x1 d30(.A({a[29],b[29]}),.S(sel),.Y(out[29]));
  mux2x1 d31(.A({a[30],b[30]}),.S(sel),.Y(out[30]));
  mux2x1 d32(.A({a[31],b[31]}),.S(sel),.Y(out[31]));


endmodule

module mux4x1_32bit (
    input [31:0] a, b, c, d,
    input [1:0] sel,
    output [31:0] out
);

  wire not_sel0, not_sel1;
  wire [31:0] and_a, and_b, and_c, and_d;

  not (not_sel0, sel[0]);
  not (not_sel1, sel[1]);

  and (and_a[0], a[0], not_sel1, not_sel0);
  and (and_b[0], b[0], not_sel1, sel[0]);
  and (and_c[0], c[0], sel[1], not_sel0);
  and (and_d[0], d[0], sel[1], sel[0]);
  or  (out[0], and_a[0], and_b[0], and_c[0], and_d[0]);

  and (and_a[1], a[1], not_sel1, not_sel0);
  and (and_b[1], b[1], not_sel1, sel[0]);
  and (and_c[1], c[1], sel[1], not_sel0);
  and (and_d[1], d[1], sel[1], sel[0]);
  or  (out[1], and_a[1], and_b[1], and_c[1], and_d[1]);

  and (and_a[2], a[2], not_sel1, not_sel0);
  and (and_b[2], b[2], not_sel1, sel[0]);
  and (and_c[2], c[2], sel[1], not_sel0);
  and (and_d[2], d[2], sel[1], sel[0]);
  or  (out[2], and_a[2], and_b[2], and_c[2], and_d[2]);

  and (and_a[3], a[3], not_sel1, not_sel0);
  and (and_b[3], b[3], not_sel1, sel[0]);
  and (and_c[3], c[3], sel[1], not_sel0);
  and (and_d[3], d[3], sel[1], sel[0]);
  or  (out[3], and_a[3], and_b[3], and_c[3], and_d[3]);

  and (and_a[4], a[4], not_sel1, not_sel0);
  and (and_b[4], b[4], not_sel1, sel[0]);
  and (and_c[4], c[4], sel[1], not_sel0);
  and (and_d[4], d[4], sel[1], sel[0]);
  or  (out[4], and_a[4], and_b[4], and_c[4], and_d[4]);

  and (and_a[5], a[5], not_sel1, not_sel0);
  and (and_b[5], b[5], not_sel1, sel[0]);
  and (and_c[5], c[5], sel[1], not_sel0);
  and (and_d[5], d[5], sel[1], sel[0]);
  or  (out[5], and_a[5], and_b[5], and_c[5], and_d[5]);

  and (and_a[6], a[6], not_sel1, not_sel0);
  and (and_b[6], b[6], not_sel1, sel[0]);
  and (and_c[6], c[6], sel[1], not_sel0);
  and (and_d[6], d[6], sel[1], sel[0]);
  or  (out[6], and_a[6], and_b[6], and_c[6], and_d[6]);

  and (and_a[7], a[7], not_sel1, not_sel0);
  and (and_b[7], b[7], not_sel1, sel[0]);
  and (and_c[7], c[7], sel[1], not_sel0);
  and (and_d[7], d[7], sel[1], sel[0]);
  or  (out[7], and_a[7], and_b[7], and_c[7], and_d[7]);

  and (and_a[8], a[8], not_sel1, not_sel0);
  and (and_b[8], b[8], not_sel1, sel[0]);
  and (and_c[8], c[8], sel[1], not_sel0);
  and (and_d[8], d[8], sel[1], sel[0]);
  or  (out[8], and_a[8], and_b[8], and_c[8], and_d[8]);

  and (and_a[9], a[9], not_sel1, not_sel0);
  and (and_b[9], b[9], not_sel1, sel[0]);
  and (and_c[9], c[9], sel[1], not_sel0);
  and (and_d[9], d[9], sel[1], sel[0]);
  or  (out[9], and_a[9], and_b[9], and_c[9], and_d[9]);

  and (and_a[10], a[10], not_sel1, not_sel0);
  and (and_b[10], b[10], not_sel1, sel[0]);
  and (and_c[10], c[10], sel[1], not_sel0);
  and (and_d[10], d[10], sel[1], sel[0]);
  or  (out[10], and_a[10], and_b[10], and_c[10], and_d[10]);

  and (and_a[11], a[11], not_sel1, not_sel0);
  and (and_b[11], b[11], not_sel1, sel[0]);
  and (and_c[11], c[11], sel[1], not_sel0);
  and (and_d[11], d[11], sel[1], sel[0]);
  or  (out[11], and_a[11], and_b[11], and_c[11], and_d[11]);

  and (and_a[12], a[12], not_sel1, not_sel0);
  and (and_b[12], b[12], not_sel1, sel[0]);
  and (and_c[12], c[12], sel[1], not_sel0);
  and (and_d[12], d[12], sel[1], sel[0]);
  or  (out[12], and_a[12], and_b[12], and_c[12], and_d[12]);

  and (and_a[13], a[13], not_sel1, not_sel0);
  and (and_b[13], b[13], not_sel1, sel[0]);
  and (and_c[13], c[13], sel[1], not_sel0);
  and (and_d[13], d[13], sel[1], sel[0]);
  or  (out[13], and_a[13], and_b[13], and_c[13], and_d[13]);

  and (and_a[14], a[14], not_sel1, not_sel0);
  and (and_b[14], b[14], not_sel1, sel[0]);
  and (and_c[14], c[14], sel[1], not_sel0);
  and (and_d[14], d[14], sel[1], sel[0]);
  or  (out[14], and_a[14], and_b[14], and_c[14], and_d[14]);

  and (and_a[15], a[15], not_sel1, not_sel0);
  and (and_b[15], b[15], not_sel1, sel[0]);
  and (and_c[15], c[15], sel[1], not_sel0);
  and (and_d[15], d[15], sel[1], sel[0]);
  or  (out[15], and_a[15], and_b[15], and_c[15], and_d[15]);

  and (and_a[16], a[16], not_sel1, not_sel0);
  and (and_b[16], b[16], not_sel1, sel[0]);
  and (and_c[16], c[16], sel[1], not_sel0);
  and (and_d[16], d[16], sel[1], sel[0]);
  or  (out[16], and_a[16], and_b[16], and_c[16], and_d[16]);

  and (and_a[17], a[17], not_sel1, not_sel0);
  and (and_b[17], b[17], not_sel1, sel[0]);
  and (and_c[17], c[17], sel[1], not_sel0);
  and (and_d[17], d[17], sel[1], sel[0]);
  or  (out[17], and_a[17], and_b[17], and_c[17], and_d[17]);

  and (and_a[18], a[18], not_sel1, not_sel0);
  and (and_b[18], b[18], not_sel1, sel[0]);
  and (and_c[18], c[18], sel[1], not_sel0);
  and (and_d[18], d[18], sel[1], sel[0]);
  or  (out[18], and_a[18], and_b[18], and_c[18], and_d[18]);

  and (and_a[19], a[19], not_sel1, not_sel0);
  and (and_b[19], b[19], not_sel1, sel[0]);
  and (and_c[19], c[19], sel[1], not_sel0);
  and (and_d[19], d[19], sel[1], sel[0]);
  or  (out[19], and_a[19], and_b[19], and_c[19], and_d[19]);

  and (and_a[20], a[20], not_sel1, not_sel0);
  and (and_b[20], b[20], not_sel1, sel[0]);
  and (and_c[20], c[20], sel[1], not_sel0);
  and (and_d[20], d[20], sel[1], sel[0]);
  or  (out[20], and_a[20], and_b[20], and_c[20], and_d[20]);

  and (and_a[21], a[21], not_sel1, not_sel0);
  and (and_b[21], b[21], not_sel1, sel[0]);
  and (and_c[21], c[21], sel[1], not_sel0);
  and (and_d[21], d[21], sel[1], sel[0]);
  or  (out[21], and_a[21], and_b[21], and_c[21], and_d[21]);

  and (and_a[22], a[22], not_sel1, not_sel0);
  and (and_b[22], b[22], not_sel1, sel[0]);
  and (and_c[22], c[22], sel[1], not_sel0);
  and (and_d[22], d[22], sel[1], sel[0]);
  or  (out[22], and_a[22], and_b[22], and_c[22], and_d[22]);

  and (and_a[23], a[23], not_sel1, not_sel0);
  and (and_b[23], b[23], not_sel1, sel[0]);
  and (and_c[23], c[23], sel[1], not_sel0);
  and (and_d[23], d[23], sel[1], sel[0]);
  or  (out[23], and_a[23], and_b[23], and_c[23], and_d[23]);

  and (and_a[24], a[24], not_sel1, not_sel0);
  and (and_b[24], b[24], not_sel1, sel[0]);
  and (and_c[24], c[24], sel[1], not_sel0);
  and (and_d[24], d[24], sel[1], sel[0]);
  or  (out[24], and_a[24], and_b[24], and_c[24], and_d[24]);

  and (and_a[25], a[25], not_sel1, not_sel0);
  and (and_b[25], b[25], not_sel1, sel[0]);
  and (and_c[25], c[25], sel[1], not_sel0);
  and (and_d[25], d[25], sel[1], sel[0]);
  or  (out[25], and_a[25], and_b[25], and_c[25], and_d[25]);

  and (and_a[26], a[26], not_sel1, not_sel0);
  and (and_b[26], b[26], not_sel1, sel[0]);
  and (and_c[26], c[26], sel[1], not_sel0);
  and (and_d[26], d[26], sel[1], sel[0]);
  or  (out[26], and_a[26], and_b[26], and_c[26], and_d[26]);

  and (and_a[27], a[27], not_sel1, not_sel0);
  and (and_b[27], b[27], not_sel1, sel[0]);
  and (and_c[27], c[27], sel[1], not_sel0);
  and (and_d[27], d[27], sel[1], sel[0]);
  or  (out[27], and_a[27], and_b[27], and_c[27], and_d[27]);

  and (and_a[28], a[28], not_sel1, not_sel0);
  and (and_b[28], b[28], not_sel1, sel[0]);
  and (and_c[28], c[28], sel[1], not_sel0);
  and (and_d[28], d[28], sel[1], sel[0]);
  or  (out[28], and_a[28], and_b[28], and_c[28], and_d[28]);

  and (and_a[29], a[29], not_sel1, not_sel0);
  and (and_b[29], b[29], not_sel1, sel[0]);
  and (and_c[29], c[29], sel[1], not_sel0);
  and (and_d[29], d[29], sel[1], sel[0]);
  or  (out[29], and_a[29], and_b[29], and_c[29], and_d[29]);

  and (and_a[30], a[30], not_sel1, not_sel0);
  and (and_b[30], b[30], not_sel1, sel[0]);
  and (and_c[30], c[30], sel[1], not_sel0);
  and (and_d[30], d[30], sel[1], sel[0]);
  or  (out[30], and_a[30], and_b[30], and_c[30], and_d[30]);

  and (and_a[31], a[31], not_sel1, not_sel0);
  and (and_b[31], b[31], not_sel1, sel[0]);
  and (and_c[31], c[31], sel[1], not_sel0);
  and (and_d[31], d[31], sel[1], sel[0]);
  or  (out[31], and_a[31], and_b[31], and_c[31], and_d[31]);

endmodule

module mux32x1_32bit(
    input [31:0] value0,value1,value2,value3,value4,value5,value6,value7,
                 value8,value9,value10,value11,value12,value13,value14,value15,
                 value16,value17,value18,value19,value20,value21,value22,value23,
                 value24,value25,value26,value27,value28,value29,value30,value31,

    input [4:0] select,
    output [31:0] result

);

wire [31:0] connectors [9:0];

mux4x1_32bit a1(.a(value0),.b(value1),.c(value2),.d(value3),.sel(select[1:0]),.out(connectors[0]));
mux4x1_32bit a2(.a(value4),.b(value5),.c(value6),.d(value7),.sel(select[1:0]),.out(connectors[1]));
mux4x1_32bit a3(.a(value8),.b(value9),.c(value10),.d(value11),.sel(select[1:0]),.out(connectors[2]));
mux4x1_32bit a4(.a(value12),.b(value13),.c(value14),.d(value15),.sel(select[1:0]),.out(connectors[3]));
mux4x1_32bit a5(.a(value16),.b(value17),.c(value18),.d(value19),.sel(select[1:0]),.out(connectors[4]));
mux4x1_32bit a6(.a(value20),.b(value21),.c(value22),.d(value23),.sel(select[1:0]),.out(connectors[5]));
mux4x1_32bit a7(.a(value24),.b(value25),.c(value26),.d(value27),.sel(select[1:0]),.out(connectors[6]));
mux4x1_32bit a8(.a(value28),.b(value29),.c(value30),.d(value31),.sel(select[1:0]),.out(connectors[7]));

mux4x1_32bit a9(.a(connectors[0]),.b(connectors[1]),.c(connectors[2]),.d(connectors[3]),.sel(select[3:2]),.out(connectors[8]));
mux4x1_32bit a10(.a(connectors[4]),.b(connectors[5]),.c(connectors[6]),.d(connectors[7]),.sel(select[3:2]),.out(connectors[9]));

mux2x1_32bit a11(.a(connectors[8]),.b(connectors[9]),.sel(select[4]),.out(result));

endmodule

module D_FF (output Q, input D, input Clk);
    wire n1, n2, n3, n4, n5, n6, n7, n8;
    wire Qbar;  // Internal inverted Q
    
    // Inverted Clock
    wire Clk_bar;
    not (Clk_bar, Clk);

    // First Stage (Master Latch)
    nand (n1, D, Clk_bar);
    nand (n2, ~D, Clk_bar);
    nand (n3, n1, n4);
    nand (n4, n2, n3);

    // Second Stage (Slave Latch)
    nand (n5, n3, Clk);
    nand (n6, n4, Clk);
    nand (n7, n5, Qbar);
    nand (n8, n6, Q);
    
    assign Q = n7;
    assign Qbar = n8;
endmodule  //positive edge triggered d flipflop

module d_flipflop_cen(
    input D, Clk, Stall,Clear,
    output Q
);
    wire connector;
    wire connec;
    D_FF a0(.Q(Q),.D(connec),.Clk(Clk));
    mux2x1 a1(.A({D,Q}),.S(Stall),.Y(connector));
    mux2x1 a2(.A({connector,1'b0}),.S(Clear),.Y(connec));

endmodule

module register_32bit(input [31:0] D, input Clk, output [31:0] Out);

D_FF a1(.D(D[0]),.Clk(Clk),.Q(Out[0]));
D_FF a2(.D(D[1]),.Clk(Clk),.Q(Out[1]));
D_FF a3(.D(D[2]),.Clk(Clk),.Q(Out[2]));
D_FF a4(.D(D[3]),.Clk(Clk),.Q(Out[3]));
D_FF a5(.D(D[4]),.Clk(Clk),.Q(Out[4]));
D_FF a6(.D(D[5]),.Clk(Clk),.Q(Out[5]));
D_FF a7(.D(D[6]),.Clk(Clk),.Q(Out[6]));
D_FF a8(.D(D[7]),.Clk(Clk),.Q(Out[7]));

D_FF a9(.D(D[8]),.Clk(Clk),.Q(Out[8]));
D_FF a10(.D(D[9]),.Clk(Clk),.Q(Out[9]));
D_FF a11(.D(D[10]),.Clk(Clk),.Q(Out[10]));
D_FF a12(.D(D[11]),.Clk(Clk),.Q(Out[11]));
D_FF a13(.D(D[12]),.Clk(Clk),.Q(Out[12]));
D_FF a14(.D(D[13]),.Clk(Clk),.Q(Out[13]));
D_FF a15(.D(D[14]),.Clk(Clk),.Q(Out[14]));
D_FF a16(.D(D[15]),.Clk(Clk),.Q(Out[15]));

D_FF a17(.D(D[16]),.Clk(Clk),.Q(Out[16]));
D_FF a18(.D(D[17]),.Clk(Clk),.Q(Out[17]));
D_FF a19(.D(D[18]),.Clk(Clk),.Q(Out[18]));
D_FF a20(.D(D[19]),.Clk(Clk),.Q(Out[19]));
D_FF a21(.D(D[20]),.Clk(Clk),.Q(Out[20]));
D_FF a22(.D(D[21]),.Clk(Clk),.Q(Out[21]));
D_FF a23(.D(D[22]),.Clk(Clk),.Q(Out[22]));
D_FF a24(.D(D[23]),.Clk(Clk),.Q(Out[23]));

D_FF a25(.D(D[24]),.Clk(Clk),.Q(Out[24]));
D_FF a26(.D(D[25]),.Clk(Clk),.Q(Out[25]));
D_FF a27(.D(D[26]),.Clk(Clk),.Q(Out[26]));
D_FF a28(.D(D[27]),.Clk(Clk),.Q(Out[27]));
D_FF a29(.D(D[28]),.Clk(Clk),.Q(Out[28]));
D_FF a30(.D(D[29]),.Clk(Clk),.Q(Out[29]));
D_FF a31(.D(D[30]),.Clk(Clk),.Q(Out[30]));
D_FF a32(.D(D[31]),.Clk(Clk),.Q(Out[31]));

endmodule

module d_flipflop(
    input D, Clk, Clear,
    output Q
);
    wire connector;
    D_FF a0(.Q(Q),.D(connector),.Clk(Clk));
    mux2x1 a1(.A({D,1'b0}),.S(Clear),.Y(connector));


endmodule

module register_32bit_cen(input [31:0] D,input Stall, input Clear, input Clk, output [31:0] Out);

d_flipflop_cen a1(.D(D[0]),.Clk(Clk),.Clear(Clear),.Stall(Stall),.Q(Out[0]));
d_flipflop_cen a2(.D(D[1]),.Clk(Clk),.Clear(Clear),.Stall(Stall),.Q(Out[1]));
d_flipflop_cen a3(.D(D[2]),.Clk(Clk),.Clear(Clear),.Stall(Stall),.Q(Out[2]));
d_flipflop_cen a4(.D(D[3]),.Clk(Clk),.Clear(Clear),.Stall(Stall),.Q(Out[3]));
d_flipflop_cen a5(.D(D[4]),.Clk(Clk),.Clear(Clear),.Stall(Stall),.Q(Out[4]));
d_flipflop_cen a6(.D(D[5]),.Clk(Clk),.Clear(Clear),.Stall(Stall),.Q(Out[5]));
d_flipflop_cen a7(.D(D[6]),.Clk(Clk),.Clear(Clear),.Stall(Stall),.Q(Out[6]));
d_flipflop_cen a8(.D(D[7]),.Clk(Clk),.Clear(Clear),.Stall(Stall),.Q(Out[7]));

d_flipflop_cen a9(.D(D[8]),.Clk(Clk),.Clear(Clear),.Stall(Stall),.Q(Out[8]));
d_flipflop_cen a10(.D(D[9]),.Clk(Clk),.Clear(Clear),.Stall(Stall),.Q(Out[9]));
d_flipflop_cen a11(.D(D[10]),.Clk(Clk),.Clear(Clear),.Stall(Stall),.Q(Out[10]));
d_flipflop_cen a12(.D(D[11]),.Clk(Clk),.Clear(Clear),.Stall(Stall),.Q(Out[11]));
d_flipflop_cen a13(.D(D[12]),.Clk(Clk),.Clear(Clear),.Stall(Stall),.Q(Out[12]));
d_flipflop_cen a14(.D(D[13]),.Clk(Clk),.Clear(Clear),.Stall(Stall),.Q(Out[13]));
d_flipflop_cen a15(.D(D[14]),.Clk(Clk),.Clear(Clear),.Stall(Stall),.Q(Out[14]));
d_flipflop_cen a16(.D(D[15]),.Clk(Clk),.Clear(Clear),.Stall(Stall),.Q(Out[15]));

d_flipflop_cen a17(.D(D[16]),.Clk(Clk),.Clear(Clear),.Stall(Stall),.Q(Out[16]));
d_flipflop_cen a18(.D(D[17]),.Clk(Clk),.Clear(Clear),.Stall(Stall),.Q(Out[17]));
d_flipflop_cen a19(.D(D[18]),.Clk(Clk),.Clear(Clear),.Stall(Stall),.Q(Out[18]));
d_flipflop_cen a20(.D(D[19]),.Clk(Clk),.Clear(Clear),.Stall(Stall),.Q(Out[19]));
d_flipflop_cen a21(.D(D[20]),.Clk(Clk),.Clear(Clear),.Stall(Stall),.Q(Out[20]));
d_flipflop_cen a22(.D(D[21]),.Clk(Clk),.Clear(Clear),.Stall(Stall),.Q(Out[21]));
d_flipflop_cen a23(.D(D[22]),.Clk(Clk),.Clear(Clear),.Stall(Stall),.Q(Out[22]));
d_flipflop_cen a24(.D(D[23]),.Clk(Clk),.Clear(Clear),.Stall(Stall),.Q(Out[23]));

d_flipflop_cen a25(.D(D[24]),.Clk(Clk),.Clear(Clear),.Stall(Stall),.Q(Out[24]));
d_flipflop_cen a26(.D(D[25]),.Clk(Clk),.Clear(Clear),.Stall(Stall),.Q(Out[25]));
d_flipflop_cen a27(.D(D[26]),.Clk(Clk),.Clear(Clear),.Stall(Stall),.Q(Out[26]));
d_flipflop_cen a28(.D(D[27]),.Clk(Clk),.Clear(Clear),.Stall(Stall),.Q(Out[27]));
d_flipflop_cen a29(.D(D[28]),.Clk(Clk),.Clear(Clear),.Stall(Stall),.Q(Out[28]));
d_flipflop_cen a30(.D(D[29]),.Clk(Clk),.Clear(Clear),.Stall(Stall),.Q(Out[29]));
d_flipflop_cen a31(.D(D[30]),.Clk(Clk),.Clear(Clear),.Stall(Stall),.Q(Out[30]));
d_flipflop_cen a32(.D(D[31]),.Clk(Clk),.Clear(Clear),.Stall(Stall),.Q(Out[31]));

endmodule


module decoder5x32(
    input [4:0] sel,
    output [31:0] out
);
    wire [4:0] neg_sel;

    not(neg_sel[0], sel[0]);
    not(neg_sel[1], sel[1]);
    not(neg_sel[2], sel[2]);
    not(neg_sel[3], sel[3]);
    not(neg_sel[4], sel[4]);

    and(out[0],  neg_sel[4], neg_sel[3], neg_sel[2], neg_sel[1], neg_sel[0]);
    and(out[1],  neg_sel[4], neg_sel[3], neg_sel[2], neg_sel[1], sel[0]);
    and(out[2],  neg_sel[4], neg_sel[3], neg_sel[2], sel[1],  neg_sel[0]);
    and(out[3],  neg_sel[4], neg_sel[3], neg_sel[2], sel[1],  sel[0]);
    and(out[4],  neg_sel[4], neg_sel[3], sel[2],  neg_sel[1], neg_sel[0]);
    and(out[5],  neg_sel[4], neg_sel[3], sel[2],  neg_sel[1], sel[0]);
    and(out[6],  neg_sel[4], neg_sel[3], sel[2],  sel[1],  neg_sel[0]);
    and(out[7],  neg_sel[4], neg_sel[3], sel[2],  sel[1],  sel[0]);
    and(out[8],  neg_sel[4], sel[3],  neg_sel[2], neg_sel[1], neg_sel[0]);
    and(out[9],  neg_sel[4], sel[3],  neg_sel[2], neg_sel[1], sel[0]);
    and(out[10], neg_sel[4], sel[3],  neg_sel[2], sel[1],  neg_sel[0]);
    and(out[11], neg_sel[4], sel[3],  neg_sel[2], sel[1],  sel[0]);
    and(out[12], neg_sel[4], sel[3],  sel[2],  neg_sel[1], neg_sel[0]);
    and(out[13], neg_sel[4], sel[3],  sel[2],  neg_sel[1], sel[0]);
    and(out[14], neg_sel[4], sel[3],  sel[2],  sel[1],  neg_sel[0]);
    and(out[15], neg_sel[4], sel[3],  sel[2],  sel[1],  sel[0]);
    and(out[16], sel[4],  neg_sel[3], neg_sel[2], neg_sel[1], neg_sel[0]);
    and(out[17], sel[4],  neg_sel[3], neg_sel[2], neg_sel[1], sel[0]);
    and(out[18], sel[4],  neg_sel[3], neg_sel[2], sel[1],  neg_sel[0]);
    and(out[19], sel[4],  neg_sel[3], neg_sel[2], sel[1],  sel[0]);
    and(out[20], sel[4],  neg_sel[3], sel[2],  neg_sel[1], neg_sel[0]);
    and(out[21], sel[4],  neg_sel[3], sel[2],  neg_sel[1], sel[0]);
    and(out[22], sel[4],  neg_sel[3], sel[2],  sel[1],  neg_sel[0]);
    and(out[23], sel[4],  neg_sel[3], sel[2],  sel[1],  sel[0]);
    and(out[24], sel[4],  sel[3],  neg_sel[2], neg_sel[1], neg_sel[0]);
    and(out[25], sel[4],  sel[3],  neg_sel[2], neg_sel[1], sel[0]);
    and(out[26], sel[4],  sel[3],  neg_sel[2], sel[1],  neg_sel[0]);
    and(out[27], sel[4],  sel[3],  neg_sel[2], sel[1],  sel[0]);
    and(out[28], sel[4],  sel[3],  sel[2],  neg_sel[1], neg_sel[0]);
    and(out[29], sel[4],  sel[3],  sel[2],  neg_sel[1], sel[0]);
    and(out[30], sel[4],  sel[3],  sel[2],  sel[1],  neg_sel[0]);
    and(out[31], sel[4],  sel[3],  sel[2],  sel[1],  sel[0]);

endmodule

module or_32 (
    input [31:0] A,B,
    output [31:0] C
);

or_16 l5(.A(A[15:0]),.B(B[15:0]),.C(C[15:0]));
or_16 l6(.A(A[31:16]),.B(B[31:16]),.C(C[31:16]));

endmodule //32 Bit or Block 

module and_32 (
    input [31:0] A,B,
    output [31:0] C
);

and_16 k5(.A(A[15:0]),.B(B[15:0]),.C(C[15:0]));
and_16 k6(.A(A[31:16]),.B(B[31:16]),.C(C[31:16]));

endmodule //32 Bit And Block 

module xor_32 (
    input [31:0] A,B,
    output [31:0] C
);

xor_16 h5(.A(A[15:0]),.B(B[15:0]),.C(C[15:0]));
xor_16 h6(.A(A[31:16]),.B(B[31:16]),.C(C[31:16]));

endmodule //32 Bit Xor Block 

module shifter(
    input [31:0] Op1,
    input S,
    input funct7_5,
    input [4:0] Shift,
    output [31:0] Result
);
wire out;
wire out1;
wire first;
mux32x1 a34(.A(Op1[31:0]),.S(Shift),.Y(out));
and (out1,Op1[31],funct7_5);
mux2x1 a66(.A({out,out1}),.S(S),.Y(Result[31]));

shift_logic a35(.A({Op1[30:0],1'b0}),.B({Op1[30],Op1[31],{30{out1}}}),.Control(Shift),.S(S),.Y(Result[30]));
shift_logic a36(.A({Op1[29:0],2'b0}),.B({Op1[29],Op1[30],Op1[31],{29{out1}}}),.Control(Shift),.S(S),.Y(Result[29]));
shift_logic a37(.A({Op1[28:0],3'b0}),.B({Op1[28],Op1[29],Op1[30],Op1[31],{28{out1}}}),.Control(Shift),.S(S),.Y(Result[28]));
shift_logic a38(.A({Op1[27:0],4'b0}),.B({Op1[27],Op1[28],Op1[29],Op1[30],Op1[31],{27{out1}}}),.Control(Shift),.S(S),.Y(Result[27]));
shift_logic a39(.A({Op1[26:0],5'b0}),.B({Op1[26], Op1[27], 
 Op1[28], Op1[29], Op1[30],Op1[31],{26{out1}}}),.Control(Shift),.S(S),.Y(Result[26]));
shift_logic a40(.A({Op1[25:0],6'b0}),.B({Op1[25],Op1[26],Op1[27], Op1[28], 
 Op1[29], Op1[30],Op1[31], {25{out1}}}),.Control(Shift),.S(S),.Y(Result[25]));
shift_logic a41(.A({Op1[24:0],7'b0}),.B({Op1[24], Op1[25],Op1[26], Op1[27], Op1[28], 
 Op1[29], Op1[30],Op1[31], {24{out1}}}),.Control(Shift),.S(S),.Y(Result[24]));
shift_logic a42(.A({Op1[23:0],8'b0}),.B({Op1[23],Op1[24],Op1[25], Op1[26], Op1[27], Op1[28], 
 Op1[29], Op1[30],Op1[31],{23{out1}}}),.Control(Shift),.S(S),.Y(Result[23]));
shift_logic a43(.A({Op1[22:0],9'b0}),.B({Op1[22],Op1[23],Op1[24],Op1[25], Op1[26], Op1[27], Op1[28], 
 Op1[29], Op1[30],Op1[31],{22{out1}}}),.Control(Shift),.S(S),.Y(Result[22]));
shift_logic a44(.A({Op1[21:0],10'b0}),.B({Op1[21], Op1[22],Op1[23], Op1[24], Op1[25], Op1[26], Op1[27], Op1[28], 
 Op1[29], Op1[30],Op1[31],{21{out1}}}),.Control(Shift),.S(S),.Y(Result[21]));
shift_logic a45(.A({Op1[20:0],11'b0}),.B({Op1[20], Op1[21],
 Op1[22], Op1[23], Op1[24], Op1[25], Op1[26], Op1[27], Op1[28], 
 Op1[29], Op1[30],Op1[31],{20{out1}}}),.Control(Shift),.S(S),.Y(Result[20]));
shift_logic a46(.A({Op1[19:0],12'b0}),.B({Op1[19],Op1[20], Op1[21], 
 Op1[22], Op1[23], Op1[24], Op1[25], Op1[26], Op1[27], Op1[28], 
 Op1[29], Op1[30],Op1[31],{19{out1}}}),.Control(Shift),.S(S),.Y(Result[19]));
shift_logic a47(.A({Op1[18:0],13'b0}),.B({Op1[18],Op1[19],Op1[20], Op1[21], 
 Op1[22], Op1[23], Op1[24], Op1[25], Op1[26], Op1[27], Op1[28], 
 Op1[29], Op1[30],Op1[31],{18{out1}}}),.Control(Shift),.S(S),.Y(Result[18]));
shift_logic a48(.A({Op1[17:0],14'b0}),.B({Op1[17],Op1[18], Op1[19], Op1[20], Op1[21], 
 Op1[22], Op1[23], Op1[24], Op1[25], Op1[26], Op1[27], Op1[28], 
 Op1[29], Op1[30],Op1[31],{17{out1}}}),.Control(Shift),.S(S),.Y(Result[17]));
shift_logic a49(.A({Op1[16:0],15'b0}),.B({Op1[16],Op1[17], Op1[18], Op1[19], Op1[20], Op1[21], 
 Op1[22], Op1[23], Op1[24], Op1[25], Op1[26], Op1[27], Op1[28], 
 Op1[29], Op1[30],Op1[31], {16{out1}}}),.Control(Shift),.S(S),.Y(Result[16]));
shift_logic a50(.A({Op1[15:0],16'b0}),.B({Op1[15],Op1[16], Op1[17], Op1[18], Op1[19], Op1[20], Op1[21], 
 Op1[22], Op1[23], Op1[24], Op1[25], Op1[26], Op1[27], Op1[28], 
 Op1[29], Op1[30],Op1[31], {15{out1}}}),.Control(Shift),.S(S),.Y(Result[15]));
shift_logic a51(.A({Op1[14:0],17'b0}),.B({Op1[14],Op1[15],Op1[16], Op1[17], Op1[18], Op1[19], Op1[20], Op1[21], 
 Op1[22], Op1[23], Op1[24], Op1[25], Op1[26], Op1[27], Op1[28], 
 Op1[29], Op1[30],Op1[31],{14{out1}}}),.Control(Shift),.S(S),.Y(Result[14]));
shift_logic a52(.A({Op1[13:0],18'b0}),.B({Op1[13],Op1[14], 
 Op1[15], Op1[16], Op1[17], Op1[18], Op1[19], Op1[20], Op1[21], 
 Op1[22], Op1[23], Op1[24], Op1[25], Op1[26], Op1[27], Op1[28], 
 Op1[29], Op1[30],Op1[31], {13{out1}}}),.Control(Shift),.S(S),.Y(Result[13]));
shift_logic a53(.A({Op1[12:0],19'b0}),.B({Op1[12], Op1[13], Op1[14], 
 Op1[15], Op1[16], Op1[17], Op1[18], Op1[19], Op1[20], Op1[21], 
 Op1[22], Op1[23], Op1[24], Op1[25], Op1[26], Op1[27], Op1[28], 
 Op1[29], Op1[30],Op1[31],{12{out1}}}),.Control(Shift),.S(S),.Y(Result[12]));
shift_logic a54(.A({Op1[11:0],20'b0}),.B({Op1[11],Op1[12], Op1[13], Op1[14], 
 Op1[15], Op1[16], Op1[17], Op1[18], Op1[19], Op1[20], Op1[21], 
 Op1[22], Op1[23], Op1[24], Op1[25], Op1[26], Op1[27], Op1[28], 
 Op1[29], Op1[30],Op1[31],{11{out1}}}),.Control(Shift),.S(S),.Y(Result[11]));
shift_logic a55(.A({Op1[10:0],21'b0}),.B({Op1[10],Op1[11], Op1[12], Op1[13], Op1[14], 
 Op1[15], Op1[16], Op1[17], Op1[18], Op1[19], Op1[20], Op1[21], 
 Op1[22], Op1[23], Op1[24], Op1[25], Op1[26], Op1[27], Op1[28], 
 Op1[29], Op1[30],Op1[31],{10{out1}}}),.Control(Shift),.S(S),.Y(Result[10]));
shift_logic a56(.A({Op1[9:0],22'b0}),.B({Op1[9],Op1[10], Op1[11], Op1[12], Op1[13], Op1[14], 
 Op1[15], Op1[16], Op1[17], Op1[18], Op1[19], Op1[20], Op1[21], 
 Op1[22], Op1[23], Op1[24], Op1[25], Op1[26], Op1[27], Op1[28], 
 Op1[29], Op1[30],Op1[31],{9{out1}}}),.Control(Shift),.S(S),.Y(Result[9]));
shift_logic a57(.A({Op1[8:0],23'b0}),.B({Op1[8],Op1[9], Op1[10], Op1[11], Op1[12], Op1[13], Op1[14], 
 Op1[15], Op1[16], Op1[17], Op1[18], Op1[19], Op1[20], Op1[21], 
 Op1[22], Op1[23], Op1[24], Op1[25], Op1[26], Op1[27], Op1[28], 
 Op1[29], Op1[30],Op1[31],{8{out1}}}),.Control(Shift),.S(S),.Y(Result[8]));
shift_logic a58(.A({Op1[7:0],24'b0}),.B({Op1[7],Op1[8], Op1[9], Op1[10], Op1[11], Op1[12], Op1[13], Op1[14], 
 Op1[15], Op1[16], Op1[17], Op1[18], Op1[19], Op1[20], Op1[21], 
 Op1[22], Op1[23], Op1[24], Op1[25], Op1[26], Op1[27], Op1[28], 
 Op1[29], Op1[30],Op1[31],{7{out1}}}),.Control(Shift),.S(S),.Y(Result[7]));
shift_logic a59(.A({Op1[6:0],25'b0}),.B({Op1[6],Op1[7], 
 Op1[8], Op1[9], Op1[10], Op1[11], Op1[12], Op1[13], Op1[14], 
 Op1[15], Op1[16], Op1[17], Op1[18], Op1[19], Op1[20], Op1[21], 
 Op1[22], Op1[23], Op1[24], Op1[25], Op1[26], Op1[27], Op1[28], 
 Op1[29], Op1[30],Op1[31],{6{out1}}}),.Control(Shift),.S(S),.Y(Result[6]));
shift_logic a60(.A({Op1[5:0],26'b0}),.B({Op1[5],Op1[6], Op1[7], 
 Op1[8], Op1[9], Op1[10], Op1[11], Op1[12], Op1[13], Op1[14], 
 Op1[15], Op1[16], Op1[17], Op1[18], Op1[19], Op1[20], Op1[21], 
 Op1[22], Op1[23], Op1[24], Op1[25], Op1[26], Op1[27], Op1[28], 
 Op1[29], Op1[30],Op1[31], {5{out1}}}),.Control(Shift),.S(S),.Y(Result[5]));
shift_logic a61(.A({Op1[4:0],27'b0}),.B({Op1[4],Op1[5], Op1[6], Op1[7], 
 Op1[8], Op1[9], Op1[10], Op1[11], Op1[12], Op1[13], Op1[14], 
 Op1[15], Op1[16], Op1[17], Op1[18], Op1[19], Op1[20], Op1[21], 
 Op1[22], Op1[23], Op1[24], Op1[25], Op1[26], Op1[27], Op1[28], 
 Op1[29], Op1[30],Op1[31], {4{out1}}}),.Control(Shift),.S(S),.Y(Result[4]));
shift_logic a62(.A({Op1[3:0],28'b0}),.B({Op1[3],Op1[4], Op1[5], Op1[6], Op1[7], 
 Op1[8], Op1[9], Op1[10], Op1[11], Op1[12], Op1[13], Op1[14], 
 Op1[15], Op1[16], Op1[17], Op1[18], Op1[19], Op1[20], Op1[21], 
 Op1[22], Op1[23], Op1[24], Op1[25], Op1[26], Op1[27], Op1[28], 
 Op1[29], Op1[30],Op1[31],{3{out1}}}),.Control(Shift),.S(S),.Y(Result[3]));
shift_logic a63(.A({Op1[2:0],29'b0}),.B({Op1[2],Op1[3], Op1[4], Op1[5], Op1[6], Op1[7], 
 Op1[8], Op1[9], Op1[10], Op1[11], Op1[12], Op1[13], Op1[14], 
 Op1[15], Op1[16], Op1[17], Op1[18], Op1[19], Op1[20], Op1[21], 
 Op1[22], Op1[23], Op1[24], Op1[25], Op1[26], Op1[27], Op1[28], 
 Op1[29], Op1[30],Op1[31],{2{out1}}}),.Control(Shift),.S(S),.Y(Result[2]));
shift_logic a64(.A({Op1[1:0],30'b0}),.B({Op1[1],Op1[2], Op1[3], Op1[4], Op1[5], Op1[6], Op1[7], 
 Op1[8], Op1[9], Op1[10], Op1[11], Op1[12], Op1[13], Op1[14], 
 Op1[15], Op1[16], Op1[17], Op1[18], Op1[19], Op1[20], Op1[21], 
 Op1[22], Op1[23], Op1[24], Op1[25], Op1[26], Op1[27], Op1[28], 
 Op1[29], Op1[30],Op1[31],{1{out1}}}),.Control(Shift),.S(S),.Y(Result[1]));
shift_logic a65(.A({Op1[0],31'b0}),.B({Op1[0],Op1[1], Op1[2], Op1[3], Op1[4], Op1[5], Op1[6], Op1[7], 
 Op1[8], Op1[9], Op1[10], Op1[11], Op1[12], Op1[13], Op1[14], 
 Op1[15], Op1[16], Op1[17], Op1[18], Op1[19], Op1[20], Op1[21], 
 Op1[22], Op1[23], Op1[24], Op1[25], Op1[26], Op1[27], Op1[28], 
 Op1[29], Op1[30],Op1[31]}),.Control(Shift),.S(S),.Y(Result[0]));

endmodule

module arithemetic(input [31:0] A,B,
input funct7_5,
input [2:0] funct_3,
output branch_u,
output [31:0] Result);

wire [31:0] connectors;
wire [31:0] sum;
wire nsum;
wire final ;
wire overflow;
or(final,funct7_5,funct_3[1]);
xor_32 z1(.A(B[31:0]),.B({32{final}}),.C(connectors));
ad32  z2(.a(A),.b(connectors),.c(final),.sum(sum),.carry(overflow));

not (nsum,sum[31]);
wire [31:0] slt = {31'b0,sum[31]};
wire pr;
mux4x1 z3(.A({sum[31],1'b1,1'b0,nsum}),.S({A[31],B[31]}),.Y(pr));
wire [31:0] sltu = {31'b0,pr};
assign branch_u = pr;
wire [31:0] co;
mux2x1_32bit z5(.a(slt), .b(sltu), .sel(funct_3[0]), .out(co));
mux2x1_32bit z6(.a(sum), .b(co), .sel(funct_3[1]), .out(Result));



endmodule

module logic_block(input [31:0] A,B,
input [1:0] funct3,
output [31:0] Result);

wire [31:0] connectors_0,connectors_1,connectors_2,connectors_3;
xor_32 g1(.A(A),.B(B),.C(connectors_0));
or_32 g2(.A(A),.B(B),.C(connectors_1));
and_32 g3(.A(A),.B(B),.C(connectors_2));

mux2x1_32bit g4(.a(connectors_1),.b(connectors_2),.sel(funct3[0]),.out(connectors_3));
mux2x1_32bit g5(.a(connectors_0),.b(connectors_3),.sel(funct3[1]),.out(Result));

endmodule



module sign_extend_bit(input [4:0] ins,input [3:0] select,output extend);

wire [4:0] connectors;

mux2x1 a1(.A({ins[4],ins[3]}),.S(select[3]),.Y(connectors[0]));
mux2x1 a2(.A({ins[2],ins[1]}),.S(select[2]),.Y(connectors[1]));
mux2x1 a3(.A({connectors[0],connectors[1]}),.S(select[1]),.Y(connectors[2]));
mux2x1 a4(.A({connectors[2],ins[0]}),.S(select[0]),.Y(extend));

endmodule

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

module pc_add4 (
    input [31:0] pc,
    output [31:0] pc_plus4
);
wire unused;
ad32 a1(.a(pc),.b(32'h00000004),.c(1'b0),.sum(pc_plus4),.carry(unused));

endmodule //pc_target

module pc_addimm (
    input [31:0] pc, imm_value,
    output [31:0] add_extend
);

wire unused;
ad32 a2(.a(pc),.b(imm_value),.c(1'b0),.sum(add_extend),.carry(unused));

endmodule //pc_target

module Program_Counter(
    input Clk, Stall,Start_RISC,
    input [31:0] Pc,
    output [31:0] Next_Pc
);



register_32bit_cen a1(.D(Pc),.Clk(Clk),.Clear(Start_RISC),.Stall(Stall),.Out(Next_Pc));

endmodule

module pc_mux (input [31:0] add_extend, add_reg,pc_plus4,input is_jalr,pc_jump,output [31:0] next_pc);

wire [31:0] connectors;
mux2x1_32bit a1(.a(add_extend),.b(add_reg),.sel(is_jalr),.out(connectors));
mux2x1_32bit a2(.a(pc_plus4),.b(connectors),.sel(pc_jump),.out(next_pc));


endmodule

module RegFile (
    input Clk, Write_Enable,
    input [4:0] rs1, rs2, rd,
    input [31:0] Write_Data,
    output [31:0] Rd1, Rd2
);

wire [31:0] reg_out [0:31];
wire [31:0] reg_in [0:31];

wire [31:0] and_in,mux_in;

decoder5x32 i1 (.sel(rd),.out(and_in));
and(mux_in[0],and_in[0],Write_Enable);
and(mux_in[1],and_in[1],Write_Enable);
and(mux_in[2],and_in[2],Write_Enable);
and(mux_in[3],and_in[3],Write_Enable);
and(mux_in[4],and_in[4],Write_Enable);
and(mux_in[5],and_in[5],Write_Enable);
and(mux_in[6],and_in[6],Write_Enable);
and(mux_in[7],and_in[7],Write_Enable);
and(mux_in[8],and_in[8],Write_Enable);
and(mux_in[9],and_in[9],Write_Enable);

and(mux_in[10],and_in[10],Write_Enable);
and(mux_in[11],and_in[11],Write_Enable);
and(mux_in[12],and_in[12],Write_Enable);
and(mux_in[13],and_in[13],Write_Enable);
and(mux_in[14],and_in[14],Write_Enable);
and(mux_in[15],and_in[15],Write_Enable);
and(mux_in[16],and_in[16],Write_Enable);
and(mux_in[17],and_in[17],Write_Enable);
and(mux_in[18],and_in[18],Write_Enable);
and(mux_in[19],and_in[19],Write_Enable);


and(mux_in[20],and_in[20],Write_Enable);
and(mux_in[21],and_in[21],Write_Enable);
and(mux_in[22],and_in[22],Write_Enable);
and(mux_in[23],and_in[23],Write_Enable);
and(mux_in[24],and_in[24],Write_Enable);
and(mux_in[25],and_in[25],Write_Enable);
and(mux_in[26],and_in[26],Write_Enable);
and(mux_in[27],and_in[27],Write_Enable);
and(mux_in[28],and_in[28],Write_Enable);
and(mux_in[29],and_in[29],Write_Enable);

and(mux_in[30],and_in[30],Write_Enable);
and(mux_in[31],and_in[31],Write_Enable);


mux2x1_32bit h1 (.a(reg_out[0]),.b(Write_Data),.sel(mux_in[0]),.out(reg_in[0]));
mux2x1_32bit h2 (.a(reg_out[1]),.b(Write_Data),.sel(mux_in[1]),.out(reg_in[1]));
mux2x1_32bit h3 (.a(reg_out[2]),.b(Write_Data),.sel(mux_in[2]),.out(reg_in[2]));
mux2x1_32bit h4 (.a(reg_out[3]),.b(Write_Data),.sel(mux_in[3]),.out(reg_in[3]));
mux2x1_32bit h5 (.a(reg_out[4]),.b(Write_Data),.sel(mux_in[4]),.out(reg_in[4]));
mux2x1_32bit h6 (.a(reg_out[5]),.b(Write_Data),.sel(mux_in[5]),.out(reg_in[5]));
mux2x1_32bit h7 (.a(reg_out[6]),.b(Write_Data),.sel(mux_in[6]),.out(reg_in[6]));
mux2x1_32bit h8 (.a(reg_out[7]),.b(Write_Data),.sel(mux_in[7]),.out(reg_in[7]));
mux2x1_32bit h9 (.a(reg_out[8]),.b(Write_Data),.sel(mux_in[8]),.out(reg_in[8]));
mux2x1_32bit h10 (.a(reg_out[9]),.b(Write_Data),.sel(mux_in[9]),.out(reg_in[9]));

mux2x1_32bit h11 (.a(reg_out[10]),.b(Write_Data),.sel(mux_in[10]),.out(reg_in[10]));
mux2x1_32bit h12 (.a(reg_out[11]),.b(Write_Data),.sel(mux_in[11]),.out(reg_in[11]));
mux2x1_32bit h13 (.a(reg_out[12]),.b(Write_Data),.sel(mux_in[12]),.out(reg_in[12]));
mux2x1_32bit h14 (.a(reg_out[13]),.b(Write_Data),.sel(mux_in[13]),.out(reg_in[13]));
mux2x1_32bit h15 (.a(reg_out[14]),.b(Write_Data),.sel(mux_in[14]),.out(reg_in[14]));
mux2x1_32bit h16 (.a(reg_out[15]),.b(Write_Data),.sel(mux_in[15]),.out(reg_in[15]));
mux2x1_32bit h17 (.a(reg_out[16]),.b(Write_Data),.sel(mux_in[16]),.out(reg_in[16]));
mux2x1_32bit h18 (.a(reg_out[17]),.b(Write_Data),.sel(mux_in[17]),.out(reg_in[17]));
mux2x1_32bit h19 (.a(reg_out[18]),.b(Write_Data),.sel(mux_in[18]),.out(reg_in[18]));
mux2x1_32bit h20 (.a(reg_out[19]),.b(Write_Data),.sel(mux_in[19]),.out(reg_in[19]));

mux2x1_32bit h21 (.a(reg_out[20]),.b(Write_Data),.sel(mux_in[20]),.out(reg_in[20]));
mux2x1_32bit h22 (.a(reg_out[21]),.b(Write_Data),.sel(mux_in[21]),.out(reg_in[21]));
mux2x1_32bit h23 (.a(reg_out[22]),.b(Write_Data),.sel(mux_in[22]),.out(reg_in[22]));
mux2x1_32bit h24 (.a(reg_out[23]),.b(Write_Data),.sel(mux_in[23]),.out(reg_in[23]));
mux2x1_32bit h25 (.a(reg_out[24]),.b(Write_Data),.sel(mux_in[24]),.out(reg_in[24]));
mux2x1_32bit h26 (.a(reg_out[25]),.b(Write_Data),.sel(mux_in[25]),.out(reg_in[25]));
mux2x1_32bit h27 (.a(reg_out[26]),.b(Write_Data),.sel(mux_in[26]),.out(reg_in[26]));
mux2x1_32bit h28 (.a(reg_out[27]),.b(Write_Data),.sel(mux_in[27]),.out(reg_in[27]));
mux2x1_32bit h29 (.a(reg_out[28]),.b(Write_Data),.sel(mux_in[28]),.out(reg_in[28]));
mux2x1_32bit h30 (.a(reg_out[29]),.b(Write_Data),.sel(mux_in[29]),.out(reg_in[29]));

mux2x1_32bit h31 (.a(reg_out[30]),.b(Write_Data),.sel(mux_in[30]),.out(reg_in[30]));
mux2x1_32bit h32 (.a(reg_out[31]),.b(Write_Data),.sel(mux_in[31]),.out(reg_in[31]));

register_32bit a1(.D(32'b0),.Clk(Clk),.Out(reg_out[0]));
register_32bit a2(.D(reg_in[1]),.Clk(Clk),.Out(reg_out[1]));
register_32bit a3(.D(reg_in[2]),.Clk(Clk),.Out(reg_out[2]));
register_32bit a4(.D(reg_in[3]),.Clk(Clk),.Out(reg_out[3]));
register_32bit a5(.D(reg_in[4]),.Clk(Clk),.Out(reg_out[4]));
register_32bit a6(.D(reg_in[5]),.Clk(Clk),.Out(reg_out[5]));
register_32bit a7(.D(reg_in[6]),.Clk(Clk),.Out(reg_out[6]));
register_32bit a8(.D(reg_in[7]),.Clk(Clk),.Out(reg_out[7]));

register_32bit a9(.D(reg_in[8]),.Clk(Clk),.Out(reg_out[8]));
register_32bit a10(.D(reg_in[9]),.Clk(Clk),.Out(reg_out[9]));
register_32bit a11(.D(reg_in[10]),.Clk(Clk),.Out(reg_out[10]));
register_32bit a12(.D(reg_in[11]),.Clk(Clk),.Out(reg_out[11]));
register_32bit a13(.D(reg_in[12]),.Clk(Clk),.Out(reg_out[12]));
register_32bit a14(.D(reg_in[13]),.Clk(Clk),.Out(reg_out[13]));
register_32bit a15(.D(reg_in[14]),.Clk(Clk),.Out(reg_out[14]));
register_32bit a16(.D(reg_in[15]),.Clk(Clk),.Out(reg_out[15]));

register_32bit a17(.D(reg_in[16]),.Clk(Clk),.Out(reg_out[16]));
register_32bit a18(.D(reg_in[17]),.Clk(Clk),.Out(reg_out[17]));
register_32bit a19(.D(reg_in[18]),.Clk(Clk),.Out(reg_out[18]));
register_32bit a20(.D(reg_in[19]),.Clk(Clk),.Out(reg_out[19]));
register_32bit a21(.D(reg_in[20]),.Clk(Clk),.Out(reg_out[20]));
register_32bit a22(.D(reg_in[21]),.Clk(Clk),.Out(reg_out[21]));
register_32bit a23(.D(reg_in[22]),.Clk(Clk),.Out(reg_out[22]));
register_32bit a24(.D(reg_in[23]),.Clk(Clk),.Out(reg_out[23]));

register_32bit a25(.D(reg_in[24]),.Clk(Clk),.Out(reg_out[24]));
register_32bit a26(.D(reg_in[25]),.Clk(Clk),.Out(reg_out[25]));
register_32bit a27(.D(reg_in[26]),.Clk(Clk),.Out(reg_out[26]));
register_32bit a28(.D(reg_in[27]),.Clk(Clk),.Out(reg_out[27]));
register_32bit a29(.D(reg_in[28]),.Clk(Clk),.Out(reg_out[28]));
register_32bit a30(.D(reg_in[29]),.Clk(Clk),.Out(reg_out[29]));
register_32bit a31(.D(reg_in[30]),.Clk(Clk),.Out(reg_out[30]));
register_32bit a32(.D(reg_in[31]),.Clk(Clk),.Out(reg_out[31]));

mux32x1_32bit b1(.value0(reg_out[0]),.value1(reg_out[1]),.value2(reg_out[2]),.value3(reg_out[3]),.value4(reg_out[4]),.value5(reg_out[5]),.value6(reg_out[6]),.value7(reg_out[7]),
                 .value8(reg_out[8]),.value9(reg_out[9]),.value10(reg_out[10]),.value11(reg_out[11]),.value12(reg_out[12]),.value13(reg_out[13]),.value14(reg_out[14]),.value15(reg_out[15]),
                 .value16(reg_out[16]),.value17(reg_out[17]),.value18(reg_out[18]),.value19(reg_out[19]),.value20(reg_out[20]),.value21(reg_out[21]),.value22(reg_out[22]),.value23(reg_out[23]),
                 .value24(reg_out[24]),.value25(reg_out[25]),.value26(reg_out[26]),.value27(reg_out[27]),.value28(reg_out[28]),.value29(reg_out[29]),.value30(reg_out[30]),.value31(reg_out[31]),
                 .select(rs1),
                 .result(Rd1)
);

mux32x1_32bit b2(.value0(reg_out[0]),.value1(reg_out[1]),.value2(reg_out[2]),.value3(reg_out[3]),.value4(reg_out[4]),.value5(reg_out[5]),.value6(reg_out[6]),.value7(reg_out[7]),
                 .value8(reg_out[8]),.value9(reg_out[9]),.value10(reg_out[10]),.value11(reg_out[11]),.value12(reg_out[12]),.value13(reg_out[13]),.value14(reg_out[14]),.value15(reg_out[15]),
                 .value16(reg_out[16]),.value17(reg_out[17]),.value18(reg_out[18]),.value19(reg_out[19]),.value20(reg_out[20]),.value21(reg_out[21]),.value22(reg_out[22]),.value23(reg_out[23]),
                 .value24(reg_out[24]),.value25(reg_out[25]),.value26(reg_out[26]),.value27(reg_out[27]),.value28(reg_out[28]),.value29(reg_out[29]),.value30(reg_out[30]),.value31(reg_out[31]),
                 .select(rs2),
                 .result(Rd2)
);

endmodule

module instruction_decoder (

    input [2:0] funct3,
    input funct7_5,
    input [6:0] opcode,

    output is_jump, is_jalr, is_branch, memwrite, regwrite, alu_srca,
    output [3:0] alu_control,
    output [1:0] alu_srcb,result_src,Store_sel,
    output [2:0] Load_sel,
    output [2:0] Funct3

);

wire [12:0] connectors;
//is_jump
and(connectors[0],opcode[5],opcode[6]);
and(is_jump,connectors[0],opcode[2]);
//is_branch
not(connectors[1],opcode[2]);
and(is_branch,connectors[0],connectors[1]);
//is_jalr
not(connectors[2],opcode[3]);
and(connectors[3],connectors[2],opcode[2]);
and(is_jalr,connectors[3],connectors[0]);
//MemWrite
not(connectors[4],opcode[4]);
not(connectors[5],opcode[6]);
and(connectors[6],connectors[4],connectors[5]);
and(memwrite,connectors[6],opcode[5]);
//alu_control
wire [2:0] alu_con;
and(alu_con[0],opcode[4],connectors[5]);
mux2x1 a1(.A({1'b0,funct3[2]}),.S(alu_con[0]),.Y(alu_control[3]));
mux2x1 a2(.A({1'b0,funct3[1]}),.S(alu_con[0]),.Y(alu_control[2]));
mux2x1 a3(.A({1'b0,funct3[0]}),.S(alu_con[0]),.Y(alu_control[1]));
mux2x1 a4(.A({2'b01}),.S(opcode[6]),.Y(alu_con[1]));
and(alu_con[2],funct7_5,opcode[5]);
mux2x1 a5(.A({alu_con[1],alu_con[2]}),.S(alu_con[0]),.Y(alu_control[0]));
//Result_Src
wire check;
wire check1;
or(check,opcode[0],opcode[1],opcode[2],opcode[3],opcode[4],opcode[5],opcode[6]);
not(check1,check);
assign result_src[0] = connectors[0];
or(connectors[7],opcode[5],opcode[4]);
wire final;
not(final,connectors[7]);
and(result_src[1],final,check); 
//RegWrite 
not(connectors[8],opcode[5]);
or(connectors[9],opcode[2],opcode[4]);
or(connectors[10],opcode[3],connectors[9]);
wire reggy;
or(reggy,connectors[10],connectors[8]);
and(regwrite,reggy,check);
//Alu Src A
and(alu_srca,opcode[2],opcode[4]);
//Alu Src B
or(connectors[11],opcode[6],opcode[4]);
not(alu_srcb[1],connectors[11]);
wire ire;
and(ire,connectors[8],opcode[4]);
or(alu_srcb[0],ire,opcode[2]);

assign Load_sel = funct3[2:0];
assign Store_sel = funct3[1:0];

endmodule //instruction_decoder

module branch (
    input branch_u,Zero_f,Sign_f,is_branch,is_jump,
    input [2:0] funct_3,
    output pc_jump
);
wire [3:0]connector;
mux2x1 a0(.A({Sign_f,branch_u}),.S(funct_3[1]),.Y(connector[0]));
mux2x1 a1(.A({Zero_f,connector[0]}),.S(funct_3[2]),.Y(connector[1]));
xor (connector[2],connector[1],funct_3[0]);
and(connector[3],connector[2],is_branch);
or(pc_jump,connector[3],is_jump);

endmodule //branch

module alusrc_a(
    input [31:0] Operand1,
    input Select,
    output [31:0] Alu_a
);
mux2x1_32bit b1(.a(Operand1),.b(32'b0),.sel(Select),.out(Alu_a));

endmodule

module alusrc_b(
    input [31:0] Operand2,Imm_Value,Pc_Imm,
    input [1:0] Select,
    output [31:0] Alu_b
);
wire [31:0] connector;
mux2x1_32bit b1(.a(Operand2),.b(Imm_Value),.sel(Select[0]),.out(connector));
mux2x1_32bit b2(.a(connector),.b(Pc_Imm),.sel(Select[1]),.out(Alu_b));

endmodule

module alu ( Op1,Op2,Alu_Control,Result,Zero_f,Sign_f,branch_u );
input [31:0] Op1, Op2;
input [3:0] Alu_Control;//Alu_Control[0] = funct7_5
output [31:0] Result;
output branch_u;
output Zero_f, Sign_f;

// control signals for resultant mux .....
wire [3:0] connectors ;
wire [3:0] connector ;
wire n_0,n_1, n_2;
not(n_0,Alu_Control[1]);
not(n_1,Alu_Control[2]);
not(n_2,Alu_Control[3]);

wire [31:0] Arith , Log , shift,co;

and(connectors[0],n_2,n_1,n_0);
and(connectors[1],n_2,Alu_Control[2],n_0);
and(connectors[2],n_2,Alu_Control[2],Alu_Control[1]);
or(connectors[3],connectors[0],connectors[1],connectors[2]);

and(connector[0],Alu_Control[3],n_1,n_0);
and(connector[1],Alu_Control[3],Alu_Control[2],n_0);
and(connector[2],Alu_Control[3],Alu_Control[2],Alu_Control[1]);
or(connector[3],connector[0],connector[1],connector[2]);

logic_block v1(.A(Op1),.B(Op2),.funct3(Alu_Control[2:1]), .Result(Log));
shifter v2(.Op1(Op1),.S(Alu_Control[3]),.funct7_5(Alu_Control[0]),.Shift(Op2[4:0]),.Result(shift));
arithemetic v3(.A(Op1),.B(Op2),.funct7_5(Alu_Control[0]),.funct_3(Alu_Control[3:1]),.branch_u(branch_u),.Result(Arith));

mux2x1_32bit g6(.a(shift),.b(Log),.sel(connector[3]),.out(co));
mux2x1_32bit g7(.a(co),.b(Arith),.sel(connectors[3]),.out(Result));

 wire [31:0] core;
not32bit g8(.in(Result),.out(core));
and32bit g9(.in(core),.out(Zero_f));
assign Sign_f = Result[31];

endmodule

module sign_extend(input [31:0] instruction, output [31:0] extension);

//Opcode[6:0] = instruction[6:0]
wire [3:0] connectors;
not (connectors[0],instruction[2]);
and (connectors[1],instruction[4],instruction[2]);
and (connectors[2],instruction[5],connectors[0]);

sign_extend_bit a31(.ins({instruction[31],instruction[31],instruction[31],instruction[31],instruction[31]}),.select({connectors[1],instruction[6],connectors[2],instruction[3]}),.extend(extension[31]));
sign_extend_bit a30(.ins({instruction[31],instruction[30],instruction[31],instruction[31],instruction[31]}),.select({connectors[1],instruction[6],connectors[2],instruction[3]}),.extend(extension[30]));
sign_extend_bit a29(.ins({instruction[31],instruction[29],instruction[31],instruction[31],instruction[31]}),.select({connectors[1],instruction[6],connectors[2],instruction[3]}),.extend(extension[29]));
sign_extend_bit a28(.ins({instruction[31],instruction[28],instruction[31],instruction[31],instruction[31]}),.select({connectors[1],instruction[6],connectors[2],instruction[3]}),.extend(extension[28]));
sign_extend_bit a27(.ins({instruction[31],instruction[27],instruction[31],instruction[31],instruction[31]}),.select({connectors[1],instruction[6],connectors[2],instruction[3]}),.extend(extension[27]));
sign_extend_bit a26(.ins({instruction[31],instruction[26],instruction[31],instruction[31],instruction[31]}),.select({connectors[1],instruction[6],connectors[2],instruction[3]}),.extend(extension[26]));
sign_extend_bit a25(.ins({instruction[31],instruction[25],instruction[31],instruction[31],instruction[31]}),.select({connectors[1],instruction[6],connectors[2],instruction[3]}),.extend(extension[25]));
sign_extend_bit a24(.ins({instruction[31],instruction[24],instruction[31],instruction[31],instruction[31]}),.select({connectors[1],instruction[6],connectors[2],instruction[3]}),.extend(extension[24]));
sign_extend_bit a23(.ins({instruction[31],instruction[23],instruction[31],instruction[31],instruction[31]}),.select({connectors[1],instruction[6],connectors[2],instruction[3]}),.extend(extension[23]));
sign_extend_bit a22(.ins({instruction[31],instruction[22],instruction[31],instruction[31],instruction[31]}),.select({connectors[1],instruction[6],connectors[2],instruction[3]}),.extend(extension[22]));
sign_extend_bit a21(.ins({instruction[31],instruction[21],instruction[31],instruction[31],instruction[31]}),.select({connectors[1],instruction[6],connectors[2],instruction[3]}),.extend(extension[21]));
sign_extend_bit a20(.ins({instruction[31],instruction[20],instruction[31],instruction[31],instruction[31]}),.select({connectors[1],instruction[6],connectors[2],instruction[3]}),.extend(extension[20]));
sign_extend_bit a19(.ins({instruction[31],instruction[19],instruction[31],instruction[31],instruction[19]}),.select({connectors[1],instruction[6],connectors[2],instruction[3]}),.extend(extension[19]));
sign_extend_bit a18(.ins({instruction[31],instruction[18],instruction[31],instruction[31],instruction[18]}),.select({connectors[1],instruction[6],connectors[2],instruction[3]}),.extend(extension[18]));
sign_extend_bit a17(.ins({instruction[31],instruction[17],instruction[31],instruction[31],instruction[17]}),.select({connectors[1],instruction[6],connectors[2],instruction[3]}),.extend(extension[17]));
sign_extend_bit a16(.ins({instruction[31],instruction[16],instruction[31],instruction[31],instruction[16]}),.select({connectors[1],instruction[6],connectors[2],instruction[3]}),.extend(extension[16]));
sign_extend_bit a15(.ins({instruction[31],instruction[15],instruction[31],instruction[31],instruction[15]}),.select({connectors[1],instruction[6],connectors[2],instruction[3]}),.extend(extension[15]));
sign_extend_bit a14(.ins({instruction[31],instruction[14],instruction[31],instruction[31],instruction[14]}),.select({connectors[1],instruction[6],connectors[2],instruction[3]}),.extend(extension[14]));
sign_extend_bit a13(.ins({instruction[31],instruction[13],instruction[31],instruction[31],instruction[13]}),.select({connectors[1],instruction[6],connectors[2],instruction[3]}),.extend(extension[13]));
sign_extend_bit a12(.ins({instruction[31],instruction[12],instruction[31],instruction[31],instruction[12]}),.select({connectors[1],instruction[6],connectors[2],instruction[3]}),.extend(extension[12]));
sign_extend_bit a11(.ins({instruction[31],1'b0,instruction[31],instruction[7],instruction[20]}),.select({connectors[1],instruction[6],connectors[2],instruction[3]}),.extend(extension[11]));
sign_extend_bit a10(.ins({instruction[30],1'b0,instruction[30],instruction[30],instruction[30]}),.select({connectors[1],instruction[6],connectors[2],instruction[3]}),.extend(extension[10]));
sign_extend_bit a9(.ins({instruction[29],1'b0,instruction[29],instruction[29],instruction[29]}),.select({connectors[1],instruction[6],connectors[2],instruction[3]}),.extend(extension[9]));
sign_extend_bit a8(.ins({instruction[28],1'b0,instruction[28],instruction[28],instruction[28]}),.select({connectors[1],instruction[6],connectors[2],instruction[3]}),.extend(extension[8]));
sign_extend_bit a7(.ins({instruction[27],1'b0,instruction[27],instruction[27],instruction[27]}),.select({connectors[1],instruction[6],connectors[2],instruction[3]}),.extend(extension[7]));
sign_extend_bit a6(.ins({instruction[26],1'b0,instruction[26],instruction[26],instruction[26]}),.select({connectors[1],instruction[6],connectors[2],instruction[3]}),.extend(extension[6]));
sign_extend_bit a5(.ins({instruction[25],1'b0,instruction[25],instruction[25],instruction[25]}),.select({connectors[1],instruction[6],connectors[2],instruction[3]}),.extend(extension[5]));
sign_extend_bit a4(.ins({instruction[24],1'b0,instruction[11],instruction[11],instruction[24]}),.select({connectors[1],instruction[6],connectors[2],instruction[3]}),.extend(extension[4]));
sign_extend_bit a3(.ins({instruction[23],1'b0,instruction[10],instruction[10],instruction[23]}),.select({connectors[1],instruction[6],connectors[2],instruction[3]}),.extend(extension[3]));
sign_extend_bit a2(.ins({instruction[22],1'b0,instruction[9],instruction[9],instruction[22]}),.select({connectors[1],instruction[6],connectors[2],instruction[3]}),.extend(extension[2]));
sign_extend_bit a1(.ins({instruction[21],1'b0,instruction[8],instruction[8],instruction[21]}),.select({connectors[1],instruction[6],connectors[2],instruction[3]}),.extend(extension[1]));
sign_extend_bit a0(.ins({instruction[20],1'b0,instruction[7],1'b0,1'b0}),.select({connectors[1],instruction[6],connectors[2],instruction[3]}),.extend(extension[0]));

endmodule

module store_mux (
    input [1:0] sel, 
    input [31:0] store_value,
    output [31:0] store
);
// 00 - SB
// 01 - SH
// 10 - SW currently making it 1x - SW
wire [31:0] connect;
mux2x1_32bit a1(.a({24'b0,store_value[7:0]}),.b({16'b0,store_value[15:0]}),.sel(sel[0]),.out(connect));
mux2x1_32bit a2(.a(connect),.b(store_value),.sel(sel[1]),.out(connect));

endmodule //store_mux

module load_mux(input [2:0] sel, 
    input [31:0] load_value,
    output [31:0] load);

// 000 - LB
// 001 - LH
// 010 - LW
// 100 - LBU
// 101 - LHU
wire [31:0] connectors [0:3];


mux2x1_32bit k1(.a({{24{load_value[31]}},load_value[7:0]}),.b({{16{load_value[31]}},load_value[15:0]}),.sel(sel[0]),.out(connectors[0]));
mux2x1_32bit k2(.a({24'b0,load_value[7:0]}),.b({16'b0,load_value[15:0]}),.sel(sel[0]),.out(connectors[1]));
mux2x1_32bit k3(.a(connectors[0]),.b(connectors[1]),.sel(sel[2]),.out(connectors[2]));
mux2x1_32bit k4(.a(connectors[2]),.b(load_value),.sel(sel[1]),.out(load));

endmodule

module resultsrc_mux (
    input [31:0] Alu_Res, Data_Mem, Pc_plus4,
    input [1:0] result_src,
    output [31:0] write_back  
);
wire [31:0] connector;
mux2x1_32bit a1(.a(Alu_Res),.b(Data_Mem),.sel(result_src[1]),.out(connector));
mux2x1_32bit a2(.a(connector),.b(Pc_plus4),.sel(result_src[0]),.out(write_back));


endmodule //resultsrc_mux
//-------------------------------------Pipeline circuitry------------------------------------------------//


module d_e_cpip(
    input Clear,Start_RISC,
    input regwrite_d,Clk,memwrite_d,
    input is_jump_d,is_branch_d,is_jalr_d,
    input [1:0] result_src_d,
    input [2:0] load_sel_d,
    input [1:0] store_sel_d,
    input [3:0] alu_control_d,
    input  alu_srca_d,
    input [1:0] alu_srcb_d,
    input [2:0] funct3,
    output [2:0] Funct3,
    output regwrite_e,memwrite_e,
    output is_jump_e,is_branch_e,is_jalr_e,
    output [1:0] result_src_e,
    output [2:0] load_sel_e,
    output [1:0] store_sel_e,
    output [3:0] alu_control_e,
    output alu_srca_e,
    output [1:0] alu_srcb_e
);

d_flipflop a1(.D(regwrite_d), .Clk(Clk), .Clear(Start_RISC|Clear), .Q(regwrite_e));
d_flipflop a2(.D(memwrite_d), .Clk(Clk), .Clear(Start_RISC|Clear), .Q(memwrite_e));
d_flipflop a3(.D(is_branch_d), .Clk(Clk), .Clear(Start_RISC|Clear), .Q(is_branch_e));
d_flipflop a4(.D(is_jump_d), .Clk(Clk), .Clear(Start_RISC|Clear), .Q(is_jump_e));
d_flipflop a5(.D(is_jalr_d), .Clk(Clk), .Clear(Start_RISC|Clear), .Q(is_jalr_e));
d_flipflop a6(.D(alu_srca_d), .Clk(Clk), .Clear(Start_RISC|Clear), .Q(alu_srca_e));

d_flipflop a7(.D(alu_srcb_d[0]), .Clk(Clk), .Clear(Start_RISC|Clear), .Q(alu_srcb_e[0]));
d_flipflop a8(.D(alu_srcb_d[1]), .Clk(Clk), .Clear(Start_RISC|Clear), .Q(alu_srcb_e[1]));

d_flipflop a9(.D(result_src_d[0]), .Clk(Clk), .Clear(Start_RISC|Clear), .Q(result_src_e[0]));
d_flipflop a10(.D(result_src_d[1]), .Clk(Clk), .Clear(Start_RISC|Clear), .Q(result_src_e[1]));

d_flipflop a11(.D(load_sel_d[0]), .Clk(Clk), .Clear(Start_RISC|Clear), .Q(load_sel_e[0]));
d_flipflop a12(.D(load_sel_d[1]), .Clk(Clk), .Clear(Start_RISC|Clear), .Q(load_sel_e[1]));
d_flipflop a15(.D(load_sel_d[2]), .Clk(Clk), .Clear(Start_RISC|Clear), .Q(load_sel_e[2]));


d_flipflop a13(.D(store_sel_d[0]), .Clk(Clk), .Clear(Start_RISC|Clear), .Q(store_sel_e[0]));
d_flipflop a14(.D(store_sel_d[1]), .Clk(Clk), .Clear(Start_RISC|Clear), .Q(store_sel_e[1]));

d_flipflop a16(.D(alu_control_d[0]), .Clk(Clk), .Clear(Start_RISC|Clear), .Q(alu_control_e[0]));
d_flipflop a17(.D(alu_control_d[1]), .Clk(Clk), .Clear(Start_RISC|Clear), .Q(alu_control_e[1]));
d_flipflop a18(.D(alu_control_d[2]), .Clk(Clk), .Clear(Start_RISC|Clear), .Q(alu_control_e[2]));
d_flipflop a19(.D(alu_control_d[3]), .Clk(Clk), .Clear(Start_RISC|Clear), .Q(alu_control_e[3]));

d_flipflop a20(.D(funct3[2]), .Clk(Clk), .Clear(Start_RISC|Clear), .Q(Funct3[2]));
d_flipflop a21(.D(funct3[1]), .Clk(Clk), .Clear(Start_RISC|Clear), .Q(Funct3[1]));
d_flipflop a22(.D(funct3[0]), .Clk(Clk), .Clear(Start_RISC|Clear), .Q(Funct3[0]));


endmodule

module ex_mem_cpip(
    input regwrite_e,Clk,memwrite_e,Start_RISC,
    input [1:0] result_src_e,
    input [2:0] load_sel_e,
    input [1:0] store_sel_e,
    output regwrite_m,memwrite_m,
    output [1:0] result_src_m,
    output [2:0] load_sel_m,
    output [1:0] store_sel_m
);

d_flipflop a1(.Q(regwrite_m), .D(regwrite_e), .Clear(Start_RISC),.Clk(Clk));
d_flipflop a2(.Q(result_src_m[0]), .D(result_src_e[0]), .Clear(Start_RISC),.Clk(Clk));
d_flipflop a3(.Q(result_src_m[1]), .D(result_src_e[1]), .Clear(Start_RISC),.Clk(Clk));
d_flipflop a4(.Q(memwrite_m), .D(memwrite_e), .Clear(Start_RISC),.Clk(Clk));
d_flipflop a5(.Q(memwrite_m), .D(memwrite_e), .Clear(Start_RISC),.Clk(Clk));

d_flipflop a6(.Q(load_sel_m[0]), .D(load_sel_e[0]), .Clear(Start_RISC),.Clk(Clk));
d_flipflop a7(.Q(load_sel_m[1]), .D(load_sel_e[1]), .Clear(Start_RISC),.Clk(Clk));
d_flipflop a8(.Q(load_sel_m[2]), .D(load_sel_e[2]), .Clear(Start_RISC),.Clk(Clk));

d_flipflop a9(.Q(store_sel_m[0]), .D(store_sel_e[0]), .Clear(Start_RISC),.Clk(Clk));
d_flipflop a10(.Q(store_sel_m[1]), .D(store_sel_e[1]), .Clear(Start_RISC),.Clk(Clk));

endmodule

module mem_wb_cpip(
    input regwrite_m,Clk,Start_RISC,
    input [1:0] result_src_m,
    output regwrite_w,
    output [1:0] result_src_w
);

d_flipflop a1(.Q(regwrite_w), .D(regwrite_m), .Clk(Clk),.Clear(Start_RISC));
d_flipflop a2(.Q(result_src_w[0]), .D(result_src_m[0]), .Clk(Clk),.Clear(Start_RISC));
d_flipflop a3(.Q(result_src_w[1]), .D(result_src_m[1]), .Clk(Clk),.Clear(Start_RISC));

endmodule

module register_32bit_c(input [31:0] D,input Clear, input Clk, output [31:0] Out);

d_flipflop a1(.D(D[0]),.Clk(Clk),.Clear(Clear),.Q(Out[0]));
d_flipflop a2(.D(D[1]),.Clk(Clk),.Clear(Clear),.Q(Out[1]));
d_flipflop a3(.D(D[2]),.Clk(Clk),.Clear(Clear),.Q(Out[2]));
d_flipflop a4(.D(D[3]),.Clk(Clk),.Clear(Clear),.Q(Out[3]));
d_flipflop a5(.D(D[4]),.Clk(Clk),.Clear(Clear),.Q(Out[4]));
d_flipflop a6(.D(D[5]),.Clk(Clk),.Clear(Clear),.Q(Out[5]));
d_flipflop a7(.D(D[6]),.Clk(Clk),.Clear(Clear),.Q(Out[6]));
d_flipflop a8(.D(D[7]),.Clk(Clk),.Clear(Clear),.Q(Out[7]));

d_flipflop a9(.D(D[8]),.Clk(Clk),.Clear(Clear),.Q(Out[8]));
d_flipflop a10(.D(D[9]),.Clk(Clk),.Clear(Clear),.Q(Out[9]));
d_flipflop a11(.D(D[10]),.Clk(Clk),.Clear(Clear),.Q(Out[10]));
d_flipflop a12(.D(D[11]),.Clk(Clk),.Clear(Clear),.Q(Out[11]));
d_flipflop a13(.D(D[12]),.Clk(Clk),.Clear(Clear),.Q(Out[12]));
d_flipflop a14(.D(D[13]),.Clk(Clk),.Clear(Clear),.Q(Out[13]));
d_flipflop a15(.D(D[14]),.Clk(Clk),.Clear(Clear),.Q(Out[14]));
d_flipflop a16(.D(D[15]),.Clk(Clk),.Clear(Clear),.Q(Out[15]));

d_flipflop a17(.D(D[16]),.Clk(Clk),.Clear(Clear),.Q(Out[16]));
d_flipflop a18(.D(D[17]),.Clk(Clk),.Clear(Clear),.Q(Out[17]));
d_flipflop a19(.D(D[18]),.Clk(Clk),.Clear(Clear),.Q(Out[18]));
d_flipflop a20(.D(D[19]),.Clk(Clk),.Clear(Clear),.Q(Out[19]));
d_flipflop a21(.D(D[20]),.Clk(Clk),.Clear(Clear),.Q(Out[20]));
d_flipflop a22(.D(D[21]),.Clk(Clk),.Clear(Clear),.Q(Out[21]));
d_flipflop a23(.D(D[22]),.Clk(Clk),.Clear(Clear),.Q(Out[22]));
d_flipflop a24(.D(D[23]),.Clk(Clk),.Clear(Clear),.Q(Out[23]));

d_flipflop a25(.D(D[24]),.Clk(Clk),.Clear(Clear),.Q(Out[24]));
d_flipflop a26(.D(D[25]),.Clk(Clk),.Clear(Clear),.Q(Out[25]));
d_flipflop a27(.D(D[26]),.Clk(Clk),.Clear(Clear),.Q(Out[26]));
d_flipflop a28(.D(D[27]),.Clk(Clk),.Clear(Clear),.Q(Out[27]));
d_flipflop a29(.D(D[28]),.Clk(Clk),.Clear(Clear),.Q(Out[28]));
d_flipflop a30(.D(D[29]),.Clk(Clk),.Clear(Clear),.Q(Out[29]));
d_flipflop a31(.D(D[30]),.Clk(Clk),.Clear(Clear),.Q(Out[30]));
d_flipflop a32(.D(D[31]),.Clk(Clk),.Clear(Clear),.Q(Out[31]));

endmodule

module d_e_dpip(
    input Clk,Clear,Start_RISC,
    input [31:0] Op1_d, Op2_d, Pc_d,Imm_d,pc_plus4_d,
    input [4:0] Rs1_d,Rs2_d,Rd_d,
    output [31:0] Op1_e, Op2_e, Pc_e,Imm_e,pc_plus4_e,
    output [4:0] Rs1_e,Rs2_e,Rd_e
);

register_32bit_c a1(.D(Op1_d),.Clear(Clear|Start_RISC),.Clk(Clk),.Out(Op1_e));
register_32bit_c a2(.D(Op2_d),.Clear(Clear|Start_RISC),.Clk(Clk),.Out(Op2_e));
register_32bit_c a3(.D(Pc_d),.Clear(Clear|Start_RISC),.Clk(Clk),.Out(Pc_e));
register_32bit_c a4(.D(Imm_d),.Clear(Clear|Start_RISC),.Clk(Clk),.Out(Imm_e));
register_32bit_c a5(.D(pc_plus4_d),.Clear(Clear|Start_RISC),.Clk(Clk),.Out(pc_plus4_e));

d_flipflop a6(.D(Rs1_d[0]), .Clk(Clk), .Clear(Clear|Start_RISC), .Q(Rs1_e[0]));
d_flipflop a7(.D(Rs1_d[1]), .Clk(Clk), .Clear(Clear|Start_RISC), .Q(Rs1_e[1]));
d_flipflop a8(.D(Rs1_d[2]), .Clk(Clk), .Clear(Clear|Start_RISC), .Q(Rs1_e[2]));
d_flipflop a9(.D(Rs1_d[3]), .Clk(Clk), .Clear(Clear|Start_RISC), .Q(Rs1_e[3]));
d_flipflop a10(.D(Rs1_d[4]), .Clk(Clk), .Clear(Clear|Start_RISC), .Q(Rs1_e[4]));

d_flipflop a11(.D(Rs2_d[0]), .Clk(Clk), .Clear(Clear|Start_RISC), .Q(Rs2_e[0]));
d_flipflop a12(.D(Rs2_d[1]), .Clk(Clk), .Clear(Clear|Start_RISC), .Q(Rs2_e[1]));
d_flipflop a13(.D(Rs2_d[2]), .Clk(Clk), .Clear(Clear|Start_RISC), .Q(Rs2_e[2]));
d_flipflop a14(.D(Rs2_d[3]), .Clk(Clk), .Clear(Clear|Start_RISC), .Q(Rs2_e[3]));
d_flipflop a15(.D(Rs2_d[4]), .Clk(Clk), .Clear(Clear|Start_RISC), .Q(Rs2_e[4]));

d_flipflop a16(.D(Rd_d[0]), .Clk(Clk), .Clear(Clear|Start_RISC), .Q(Rd_e[0]));
d_flipflop a17(.D(Rd_d[1]), .Clk(Clk), .Clear(Clear|Start_RISC), .Q(Rd_e[1]));
d_flipflop a18(.D(Rd_d[2]), .Clk(Clk), .Clear(Clear|Start_RISC), .Q(Rd_e[2]));
d_flipflop a19(.D(Rd_d[3]), .Clk(Clk), .Clear(Clear|Start_RISC), .Q(Rd_e[3]));
d_flipflop a20(.D(Rd_d[4]), .Clk(Clk), .Clear(Clear|Start_RISC), .Q(Rd_e[4]));

endmodule

module ex_mem_dpip(
    input [31:0] alu_result_e, write_data_e, pc_plus4_e,
    input Start_RISC,
    input [4:0] rd_e,
    input Clk,
    output [31:0] alu_result_m, write_data_m, pc_plus4_m,
    output [4:0] rd_m
);

register_32bit_c a1(.D(alu_result_e),.Clk(Clk),.Clear(Start_RISC),.Out(alu_result_m));
register_32bit_c a2(.D(write_data_e),.Clk(Clk),.Clear(Start_RISC),.Out(write_data_m));
register_32bit_c a3(.D(pc_plus4_e),.Clk(Clk),.Clear(Start_RISC),.Out(pc_plus4_m));

wire [4:0] cons;

d_flipflop h1(.Q(cons[0]), .D(rd_e[0]), .Clk(Clk),.Clear(Start_RISC));
d_flipflop h2(.Q(cons[1]), .D(rd_e[1]), .Clk(Clk),.Clear(Start_RISC));
d_flipflop h3(.Q(cons[2]), .D(rd_e[2]), .Clk(Clk),.Clear(Start_RISC));
d_flipflop h4(.Q(cons[3]), .D(rd_e[3]), .Clk(Clk),.Clear(Start_RISC));
d_flipflop h5(.Q(cons[4]), .D(rd_e[4]), .Clk(Clk),.Clear(Start_RISC));

assign rd_m = cons;

endmodule


module f_d_dpip(
    input Clk,Stall,Clear,Start_RISC,
    input [31:0] Ins_f,Pc_f,Pc_plus_f,
    output [31:0] Ins_d,Pc_d,Pc_plus_d
);

register_32bit_cen a1(.D(Ins_f), .Clear(Clear|Start_RISC), .Stall(Stall), .Clk(Clk), .Out(Ins_d));
register_32bit_cen a2(.D(Pc_f), .Clear(Clear|Start_RISC), .Stall(Stall), .Clk(Clk), .Out(Pc_d));
register_32bit_cen a3(.D(Pc_plus_f), .Clear(Clear|Start_RISC), .Stall(Stall), .Clk(Clk), .Out(Pc_plus_d));


endmodule

module mem_w_dpip(
    input [31:0] alu_result_m,
    input [4:0] rd_m,
    input Clk,Start_RISC,
    output [31:0] alu_result_w,
    output [4:0] rd_w
);

register_32bit_c a1(.D(alu_result_m),.Clk(Clk),.Clear(Start_RISC),.Out(alu_result_w));

 d_flipflop h1(.Q(rd_w[0]), .D(rd_m[0]), .Clk(Clk),.Clear(Start_RISC));
 d_flipflop h2(.Q(rd_w[1]), .D(rd_m[1]), .Clk(Clk),.Clear(Start_RISC));
 d_flipflop h3(.Q(rd_w[2]), .D(rd_m[2]), .Clk(Clk),.Clear(Start_RISC));
 d_flipflop h4(.Q(rd_w[3]), .D(rd_m[3]), .Clk(Clk),.Clear(Start_RISC));
 d_flipflop h5(.Q(rd_w[4]), .D(rd_m[4]), .Clk(Clk),.Clear(Start_RISC));




endmodule


module forwardinng_mux1(
    input [31:0] Operand1,Result_W,Mem_Addr,
    input [1:0] Select,
    output [31:0] forward_a
);
wire [31:0] connector;
mux2x1_32bit a1(.a(Operand1),.b(Result_W),.sel(Select[0]),.out(connector));
mux2x1_32bit a2(.a(connector),.b(Mem_Addr),.sel(Select[1]),.out(forward_a));

endmodule

module forwarding_mux2(
    input [31:0] Operand2,Result_W,Mem_Addr,
    input [1:0] Select,
    output [31:0] forward_b
);
wire [31:0] connector;
mux2x1_32bit b1(.a(Operand2),.b(Result_W),.sel(Select[0]),.out(connector));
mux2x1_32bit b2(.a(connector),.b(Mem_Addr),.sel(Select[1]),.out(forward_b));

endmodule

module forward(
   input [4:0] rs_e,rd_m,rd_w,
   input regwrite_m,regwrite_w,
   output [1:0] mux_val
);
// rs_e == rd_m
wire [4:0] connectors0;
xnor(connectors0[0],rs_e[0],rd_m[0]);
xnor(connectors0[1],rs_e[1],rd_m[1]);
xnor(connectors0[2],rs_e[2],rd_m[2]);
xnor(connectors0[3],rs_e[3],rd_m[3]);
wire connectors1;
and(connectors1,connectors0[0],connectors0[1],connectors0[2],connectors0[3]);
//rs_e != 0
wire connectors2;
or(connectors2,rs_e[0],rs_e[1],rs_e[2],rs_e[3]);
// rs_e == rd_w
wire [4:0] connectors3;
xnor(connectors3[0],rs_e[0],rd_w[0]);
xnor(connectors3[1],rs_e[1],rd_w[1]);
xnor(connectors3[2],rs_e[2],rd_w[2]);
xnor(connectors3[3],rs_e[3],rd_w[3]);
wire connectors4;
and(connectors4,connectors3[0],connectors3[1],connectors3[2],connectors3[3]);

wire [1:0] final_mux;
//(Rs_Execute == Rd_Memory)&(RegWrite_M)&(Rs_Execute != 0)
and(final_mux[0],connectors1,connectors2,regwrite_m);
//(Rs_Execute == Rd_Writeback)&(RegWrite_W)&(Rs_Execute != 0)
and(final_mux[1],connectors4,connectors2,regwrite_w);


mux2x1 a1(.A({1'b0,1'b1}),.S(final_mux[0]),.Y(mux_val[1]));
mux2x1 a2(.A({1'b0,1'b1}),.S(final_mux[1]),.Y(mux_val[0]));

endmodule


module hazard_unit(
    input [4:0] rs1_d,rs1_e,rs2_d,rs2_e,
    input [4:0] rd_e,rd_m,rd_w,
    input regwrite_m,regwrite_w,
    input result_src0,pc_jump,
    
    output [1:0] forward_a,forward_b,
    output flush_d,stall_d,stall_f,flush_e 
    );

forward f1(
   .rs_e(rs1_e),.rd_m(rd_m),.rd_w(rd_w),
   .regwrite_m(regwrite_m),.regwrite_w(regwrite_w),
   .mux_val(forward_a)
);

forward f2(
   .rs_e(rs2_e),.rd_m(rd_m),.rd_w(rd_w),
   .regwrite_m(regwrite_m),.regwrite_w(regwrite_w),
   .mux_val(forward_b)
);

//stall =  (Result_Src_0 == 1) & ((Rd_Execute == Rs1_Decode) | (Rd_Execute == Rs2_Decode))
//(Rd_Execute == Rs1_Decode)
wire [3:0] con;
xnor(con[0],rd_e[0],rs1_d[0]);
xnor(con[1],rd_e[1],rs1_d[1]);
xnor(con[2],rd_e[2],rs1_d[2]);
xnor(con[3],rd_e[3],rs1_d[3]);
wire con1;
and(con1,con[0],con[1],con[2],con[3]);
//(Rd_Execute == Rs2_Decode)
wire [3:0] con2;
xnor(con2[0],rd_e[0],rs2_d[0]);
xnor(con2[1],rd_e[1],rs2_d[1]);
xnor(con2[2],rd_e[2],rs2_d[2]);
xnor(con2[3],rd_e[3],rs2_d[3]);
wire con3;
and(con3,con[0],con[1],con[2],con[3]);
//
wire connecy;
wire stall;
or(connecy,con3,con1);
and(stall,connecy,result_src0);

assign stall_d = stall;
assign stall_f = stall;

assign flush_d = pc_jump;
or(flush_e,stall,pc_jump);


endmodule

//------------------------------------- RISC RV32I CPU -----------------------------------------------//

module RISC(
    output [31:0] Program_Counter,
    input [31:0] Instruction,
    input Clk, Start_RISC, Stall,
    input [31:0] Read_Mem,
    output [31:0] Alu_Result,
    output [31:0] Memory_Value_Mux,
    output Write_Enable
);
wire [4:0] Rd_W;

wire Pc_Jump,Is_Jalr;

pc_mux pc_mux(
    .add_extend(Add_Extend), 
    .add_reg(Alu_Result_Wire),
    .pc_plus4(Pc_Plus4),
    .is_jalr(Is_Jalr),
    .pc_jump(Pc_Jump),
    .next_pc(Pc_Mux)
);

wire [31:0] Next_Pc;
wire [31:0] Pc_Mux;
Program_Counter pc(
    .Clk(Clk), .Stall(Stall_F),.Start_RISC(Start_RISC),
    .Pc(Pc_Mux),
    .Next_Pc(Next_Pc)
);
assign Program_Counter = Next_Pc;
wire [31:0] Pc_Plus4;

// Fetch Stage

pc_add4 add4(
    .pc(Next_Pc),
    .pc_plus4(Pc_Plus4)
);//pc_target

wire [31:0] Imm_Value;
wire [31:0] Add_Extend;
wire [31:0] Alu_Result_Wire;

wire [31:0] Pc_D,Pc_Plus_D;
wire [31:0] Instruction_Decode;
// Fetch Decode Pipeline

f_d_dpip fd_pip(
    .Clk(Clk),.Stall(Stall_F),.Clear(Flush_D),.Start_RISC(Start_RISC),
    .Ins_f(Instruction),.Pc_f(Next_Pc),.Pc_plus_f(Pc_Plus4),
    .Ins_d(Instruction_Decode),.Pc_d(Pc_D),.Pc_plus_d(Pc_Plus_D)
);





wire Reg_Write;
wire [31:0] Operand1_Reg, Operand2_Reg;
wire [31:0] Write_Reg;


RegFile regfile(
    .Clk(Clk), 
//  .Write_Enable(Reg_Write_W),
    .Write_Enable(Reg_Write_M),
    .rs1(Instruction_Decode[19:15]), 
    .rs2(Instruction_Decode[24:20]),
 //   .rd(Rd_W),
    .rd(Rd_M),
    .Write_Data(Write_Reg),
    .Rd1(Operand1_Reg), 
    .Rd2(Operand2_Reg)
);

wire Is_Jump,Is_Branch;
wire Mem_Write, Src_A;
wire [3:0] Alu_Control;
wire [1:0] Src_B,Result_Src,Store_Sel;
wire [2:0] Load_Sel;

sign_extend extend(
    .instruction(Instruction_Decode), 
    .extension(Imm_Value)
);


instruction_decoder control_unit(

    .funct3(Instruction_Decode[14:12]),
    .funct7_5(Instruction_Decode[30]),
    .opcode(Instruction_Decode[6:0]),

    .is_jump(Is_Jump),
    .is_jalr(Is_Jalr), 
    .is_branch(Is_Branch), 
    .memwrite(Mem_Write), 
    .regwrite(Reg_Write), 
    .alu_srca(Src_A),
    .alu_control(Alu_Control),
    .alu_srcb(Src_B),
    .result_src(Result_Src),
    .Load_sel(Load_Sel),
    .Store_sel(Store_Sel)

);

// Decode Stage
    wire [31:0] Op1_E, Op2_E, Pc_E,Imm_E,Pc_Plus_E;
    wire [4:0] Rs1_E,Rs2_E,Rd_E;
// Decode Execute Pipeline
d_e_dpip de_pipeline(
    .Clk(Clk),.Clear(Flush_E),.Start_RISC(Start_RISC),
    .Op1_d(Operand1_Reg), .Op2_d(Operand2_Reg), .Pc_d(Pc_D),.Imm_d(Imm_Value),.pc_plus4_d(Pc_Plus_D),
    .Rs1_d(Instruction_Decode[19:15]),.Rs2_d(Instruction_Decode[24:20]),.Rd_d(Instruction_Decode[11:7]),
    .Op1_e(Op1_E), .Op2_e(Op2_E), .Pc_e(Pc_E), .Imm_e(Imm_E), .pc_plus4_e(Pc_Plus_E),
    .Rs1_e(Rs1_E),.Rs2_e(Rs2_E),.Rd_e(Rd_E)
);
wire Reg_write_E,Mem_Write_E;
wire Is_Jump_E,Is_Branch_E,Is_Jalr_E;
wire [1:0] Result_Src_E;
wire [2:0] Load_Sel_E;
wire [1:0] Store_Sel_E;
wire [3:0] Alu_Control_E;
wire Src_A_E;
wire [1:0] Src_B_E;
wire [2:0] trail;
d_e_cpip de_cpipeline(
    .Clk(Clk),.Clear(Flush_E),.Start_RISC(Start_RISC),
    .regwrite_d(Reg_Write),.memwrite_d(Mem_Write),
    .is_jump_d(Is_Jump),.is_branch_d(Is_Branch),.is_jalr_d(Is_Jalr),
    .result_src_d(Result_Src),
    .load_sel_d(Load_Sel),
    .store_sel_d(Store_Sel),
    .alu_control_d(Alu_Control),
    .alu_srca_d(Src_A),
    .alu_srcb_d(Src_B),
    .regwrite_e(Reg_write_E),.memwrite_e(Mem_Write_E),
    .is_jump_e(Is_Jump_E),.is_branch_e(Is_Branch_E),.is_jalr_e(Is_Jalr_E),
    .result_src_e(Result_Src_E),
    .load_sel_e(Load_Sel_E),
    .store_sel_e(Store_Sel_E),
    .alu_control_e(Alu_Control_E),
    .alu_srca_e(Src_A_E),
    .alu_srcb_e(Src_B_E),
    .funct3(Instruction_Decode[14:12]),
    .Funct3(trail)
);

pc_addimm add_imm(
    .pc(Pc_E), .imm_value(Imm_E),
    .add_extend(Add_Extend)
); //pc_target

wire Branch_U,Zero_F,Sign_F;

branch branch(
    .branch_u(Branch_U),.Zero_f(Zero_F),.Sign_f(Sign_F),
    .is_branch(Is_Branch_E),
    .is_jump(Is_Jump_E),
    .funct_3(trail),
    .pc_jump(Pc_Jump)
);



wire [31:0] Operand1_Alu,Operand2_Alu;
wire [31:0] Forward_A,Forward_B;
wire [1:0] Select_A, Select_B;

forwardinng_mux1 forward_a(
    .Operand1(Op1_E),.Result_W(Write_Reg_1),.Mem_Addr(Alu_Result_M),
    .Select(Select_A),
    .forward_a(Forward_A)
);

forwarding_mux2 forward_b(
    .Operand2(Op2_E),.Result_W(Write_Reg_1),.Mem_Addr(Alu_Result_M),
    .Select(Select_B),
    .forward_b(Forward_B)
);

alusrc_a alu_srca(
    .Operand1(Forward_A),
    .Select(Src_A_E),
    .Alu_a(Operand1_Alu)
);

alusrc_b alu_srcb( 
    .Operand2(Forward_B),.Imm_Value(Imm_E),.Pc_Imm(Add_Extend),
    .Select(Src_B_E),
    .Alu_b(Operand2_Alu)
);


alu alu(
    .Op1(Operand1_Alu),.Op2(Operand2_Alu),
    .Alu_Control(Alu_Control_E),
    .Result(Alu_Result_Wire),
    .Zero_f(Zero_F),.Sign_f(Sign_F),.branch_u(Branch_U));


// Execute Stage
wire [31:0] Alu_Result_M, Write_Data_M, Pc_Plus_M;
wire [4:0] Rd_M;

ex_mem_dpip em_pipeline(
    .alu_result_e(Alu_Result_Wire), .write_data_e(Forward_B), .pc_plus4_e(Pc_Plus_E),
    .Start_RISC(Start_RISC),
    .rd_e(Rd_E),
    .Clk(Clk),
    .alu_result_m(Alu_Result_M), .write_data_m(Write_Data_M), .pc_plus4_m(Pc_Plus_M),
    .rd_m(Rd_M)
);


    wire Reg_Write_M,Mem_Write_M;
    wire [1:0] Result_Src_M;
    wire [2:0] Load_Sel_M;
    wire [1:0] Store_Sel_M;
 ex_mem_cpip em_cpipeline(
    .regwrite_e(Reg_write_E),
    .Clk(Clk),.memwrite_e(Mem_Write_E),
    .Start_RISC(Start_RISC),
    .result_src_e(Result_Src_E),
    .load_sel_e(Load_Sel_E),
    .store_sel_e(Store_Sel_E),
    .regwrite_m(Reg_Write_M),.memwrite_m(Mem_Write_M),
    .result_src_m(Result_Src_M),
    .load_sel_m(Load_Sel_M),
    .store_sel_m(Store_Sel_M)
);


store_mux store_mux(
    .sel(Store_Sel_M), 
    .store_value(Write_Data_M),
    .store(Memory_Value_Mux)
);

wire [31:0] RegWrite_Data;

load_mux load_mux(
    .sel(Load_Sel), 
    .load_value(Read_Mem),
    .load(RegWrite_Data));

assign Alu_Result = Alu_Result_M;
wire [31:0] Alu_Result_W, Read_Data_W, Pc_Plus_W;

resultsrc_mux res_src(
    .Alu_Res(Alu_Result_M), .Data_Mem(RegWrite_Data), .Pc_plus4(Pc_Plus_M),
    .result_src(Result_Src_W),
    .write_back(Write_Reg)  
);


mem_w_dpip mw_pipeline(
    .alu_result_m(Write_Reg), 
    .rd_m(Rd_M),
    .Clk(Clk),.Start_RISC(Start_RISC),
    .alu_result_w(Write_Reg_1),
    .rd_w(Rd_W)
);    

// Memory Access Stage
wire Reg_Write_W;
wire [1:0] Result_Src_W;

mem_wb_cpip mw_cpipeline(
    .regwrite_m(Reg_Write_M),.Clk(Clk),
    .Start_RISC(Start_RISC),
    .result_src_m(Result_Src_M),
    .regwrite_w(Reg_Write_W),
    .result_src_w(Result_Src_W)
);

wire [31:0] Write_Reg_1;

// Write Back Stage
wire Stall_D,Stall_F,Flush_D,Flush_E;

hazard_unit hazard(
    .rs1_d(Instruction_Decode[19:15]),.rs1_e(Rs1_E),.rs2_d(Instruction_Decode[24:20]),.rs2_e(Rs2_E),
    .rd_e(Instruction_Decode[11:7]),.rd_m(Rd_M),.rd_w(Rd_W),
    .regwrite_m(Reg_Write_M),.regwrite_w(Reg_Write_W),
    .result_src0(Result_Src_E[0]),.pc_jump(Pc_Jump),
    
    .forward_a(Select_A),.forward_b(Select_B),
    .flush_d(Flush_D),.stall_d(Stall_D),.stall_f(Stall_F),.flush_e(Flush_E) 
    );


endmodule


//------------------------------------Instruction Memory----------------------------------------------//

module Instruction_Memory (
    input [31:0] Address,
    output reg [31:0] Read_Data
);

 //This could be considered as ROM because processor cant write in it 
// But we are writing so Technically not a ROM just memory maybe....    
reg [7:0] MEMORY [128:0] ;

initial begin
    {MEMORY[3],MEMORY[2],MEMORY[1],MEMORY[0]} = 32'h00500113;
    {MEMORY[7],MEMORY[6],MEMORY[5],MEMORY[4]} = 32'h00C00193;
  //  {MEMORY[11],MEMORY[10],MEMORY[9],MEMORY[8]} = 32'h00219463;
    {MEMORY[11],MEMORY[10],MEMORY[9],MEMORY[8]} = 32'hFF718393;
    {MEMORY[15],MEMORY[14],MEMORY[13],MEMORY[12]} = 32'h0023E233;
    {MEMORY[19],MEMORY[18],MEMORY[17],MEMORY[16]} = 32'h0041C2B3;
    {MEMORY[23],MEMORY[22],MEMORY[21],MEMORY[20]} = 32'h004283B3;
    {MEMORY[27],MEMORY[26],MEMORY[25],MEMORY[24]} = 32'h02728863;
    {MEMORY[31],MEMORY[30],MEMORY[29],MEMORY[28]} = 32'h0041A233;
    {MEMORY[35],MEMORY[34],MEMORY[33],MEMORY[32]} = 32'h00020463;
    {MEMORY[39],MEMORY[38],MEMORY[37],MEMORY[36]} = 32'h00000293;
    {MEMORY[43],MEMORY[42],MEMORY[41],MEMORY[40]} = 32'h0023A233;
    {MEMORY[47],MEMORY[46],MEMORY[45],MEMORY[44]} = 32'h005203B3;
    {MEMORY[51],MEMORY[50],MEMORY[49],MEMORY[48]} = 32'h402383B3;
    {MEMORY[55],MEMORY[54],MEMORY[53],MEMORY[52]} = 32'h0471AA23;
    {MEMORY[59],MEMORY[58],MEMORY[57],MEMORY[56]} = 32'h06002103;
    {MEMORY[63],MEMORY[62],MEMORY[61],MEMORY[60]} = 32'h005104B3;
    {MEMORY[67],MEMORY[66],MEMORY[65],MEMORY[64]} = 32'h008001EF;
    {MEMORY[71],MEMORY[70],MEMORY[69],MEMORY[68]} = 32'h00100113;
    {MEMORY[75],MEMORY[74],MEMORY[73],MEMORY[72]} = 32'h00910133;
    {MEMORY[79],MEMORY[78],MEMORY[77],MEMORY[76]} = 32'h00100213;
    {MEMORY[83],MEMORY[82],MEMORY[81],MEMORY[80]} = 32'h800002B7;
    {MEMORY[87],MEMORY[86],MEMORY[85],MEMORY[84]} = 32'h0042A333;
    {MEMORY[91],MEMORY[90],MEMORY[89],MEMORY[88]} = 32'h00030063;
    {MEMORY[95],MEMORY[94],MEMORY[93],MEMORY[92]} = 32'hABCDE4B7;
    {MEMORY[99],MEMORY[98],MEMORY[97],MEMORY[96]} = 32'h00910133;
    {MEMORY[103],MEMORY[102],MEMORY[101],MEMORY[100]} = 32'h0421A023;
    {MEMORY[107],MEMORY[106],MEMORY[105],MEMORY[104]} = 32'h00210063;
end

always @(*) begin
    Read_Data = {MEMORY[Address+3],MEMORY[Address+2],MEMORY[Address+1],MEMORY[Address]};
    //Considering as a Little Endian Processor.....
end

endmodule



//---------------------------------------Data Memory---------------------------------------------//

// Just a Memory with no values i.e RAM basically 
module Data_Memory (
    input [31:0] Address , Write_Data,
    input Clk , Write_Enable,
    output [31:0] Read_Data
);
//Cant perform Read and write simultaneously so address is for both
reg [31:0] RAM[127:0] ;// 128*32 Memory Can be any size tho

assign Read_Data = RAM[Address[31:2]];//Since First 2 Bits are considered Offset

always @(posedge Clk)
begin
    if(Write_Enable)
         RAM[Address[31:2]] <= Write_Data ;
end

endmodule

// CPU CPU CPU CPU CPU CPU CPU CPU CPU CPU CPU CPU CPU CPU CPU CPU CPU CPU CPU CPU CPU CPU CPU CPU CPU CPU CPU CPU CPU CPU CPU CPU CPU CPU CPU CPU CPU CPU CPU CPU CPU CPU CPU CPU CPU CPU CPU
module cpu(
    input Clk,
    input Start_RISC,
    output [31:0] Out,
    output [31:0] Ins
);

    wire [31:0] Program_Counter;
    wire [31:0] Instruction;
    wire [31:0] Read_Mem;
    wire [31:0] Alu_Result;
    wire [31:0] Write_Data;
    wire Write_Enable;

RISC risc(
    .Program_Counter(Program_Counter),
    .Instruction(Instruction),
    .Clk(Clk),.Start_RISC(Start_RISC),
    .Read_Mem(Read_Mem),
    .Alu_Result(Alu_Result),
    .Memory_Value_Mux(Write_Data),
    .Write_Enable(Write_Enable)
);

assign Out = Alu_Result;

Data_Memory datamemory(
    .Address(Alu_Result) , .Write_Data(Write_Data),
    .Clk(Clk) , .Write_Enable(Write_Enable),
    .Read_Data(Read_Mem)
);

Instruction_Memory instructionmemory(
    .Address(Program_Counter) ,
    .Read_Data(Instruction) 
);
assign Ins = Instruction;

endmodule

