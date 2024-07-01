module Forward2 (
    input [31:0] rd2, Result_WriteBack, Alu_Result_M,
    input [1:0] Select,
    output [31:0] Result
);

// 00 - rd2 01 - Result Writeback 10 - Alu Resultv M
assign Result = (Select[1])?Alu_Result_M:((Select[0])?Result_WriteBack:rd2);

endmodule

//This Mux is for avoiding Hazards in Digital Circuits
module Forward1 (
    input [31:0] rd1, Result_WriteBack, Alu_Result_M,
    input [1:0] Forward,
    output [31:0] Result
);
// 00 - RD1 01 - ResultsW 10 - AluResultM
assign Result = Forward[1] ? Alu_Result_M : ((Forward[0]) ? Result_WriteBack : rd1 ) ;

endmodule

//Extending Immediate Value based on Type of Instructions 
// IMM SRC for R - xxx I - 000 B - 010 J - 011 S - 001 L - 000
module Sign_Extend (
    input [31:0] Instruction,
    input [2:0] ImmSrc,
    output reg [31:0] Imm_Extend
);
localparam I = 3'b000,
           B = 3'b010,
           J = 3'b011,
           S = 3'b001,
           L = 3'b000;

always @(*)
begin
    case(ImmSrc)
        I : Imm_Extend = {{20{Instruction[31]}},Instruction[31:20]};
        B : Imm_Extend = {{19{Instruction[31]}},Instruction[31],Instruction[7],Instruction[30:25],Instruction[11:8],1'b0};
        J : Imm_Extend = {{11{Instruction[31]}},Instruction[31],Instruction[19:12],Instruction[20],Instruction[30:21],1'b0};
        S : Imm_Extend = {{20{Instruction[31]}},Instruction[31:25],Instruction[11:7]};
        L : Imm_Extend = {{20{Instruction[31]}},Instruction[31:20]};
        default Imm_Extend = 32'b0;
    endcase
end

endmodule

module Alu (
    input [31:0] rs1,
    input [31:0] rs2,
    output reg [31:0] result,
    input [3:0] control,
    output reg Zero_F , Sign_F 
);
// control [2:0] is funct3 and control[3] is funct7[6]

localparam ADD = 3'b000 , // ADD/SUB it's 000
           SLL = 3'b001 ,
           SLT = 3'b010 ,
           SLTU = 3'b011 ,
           XOR = 3'b100 ,
           SRL = 3'b101 , // SRL/SRA it's 101
           OR  = 3'b110 ,
           AND = 3'b111 ;

wire [31:0] Add ;
wire [31:0] Shift ;
//control[3:1] is basically funct3
assign Add = rs1 + (control[0] ? (~rs2) : rs2) + control[0]; //control[3] == 0 Add and control[3] == 1 Sub Operation
assign Shift = rs1 >> rs2 ;
assign Shift[31] = (control[0]) ? rs1[31] : 0 ; //control[3] == 0 Right Shift and control[3] == 1 Arthemetic Right Shift i.e sign bit doesn't change

always @(*)
begin
    case (control[3:1])
        ADD : result = Add; // Both Add and Subtract
        SLL : result = rs1 << rs2 ;
        SLT : result = ($signed(rs1)<$signed(rs2)) ? 32'b1 : 32'b0 ; 
        SLTU : result = (rs1 < rs2) ? 32'b1 : 32'b0 ;
        XOR : result = rs1 ^ rs2 ;
        SRL : result = Shift ;
        OR  : result = rs1 | rs2 ;
        AND : result = rs1 & rs2 ;
        default : result = 32'bx ; 
    endcase
    // Assigning Flags as Outputs of ALU 
     Zero_F = &(~result) ;
     Sign_F = result[31] ;
end

endmodule
// Done

module Adder (
    input [31:0] Data1, Data2,
    output [31:0] Result
);
    
  assign Result = Data1 + Data2 ;

endmodule


module Mux2 (
    input Select,
    input [31:0] Data1, Data2,
    output [31:0] Result
);
    
assign Result = (Select) ? Data2 : Data1;

endmodule

module Mux3 (
    input [1:0] Select,
    input [31:0] Data1, Data2, Data3,
    output [31:0] Result
);
    
assign Result = (Select[1]) ? Data3 : ((Select[0]) ? Data2 : Data1 ) ;

endmodule

module Pc_Mux (
    input [31:0] Pc4F , JumpTarget ,
    input PcSrc,
    output [31:0] Pc_Reg
);

assign Pc_Reg = (PcSrc) ? JumpTarget : Pc4F ;
    
endmodule

module Pc_Mux2 (
    input [31:0] Pc_Target , Alu_result ,
    input Pc_JalSrc,
    output [31:0] Jump_Target
);
    assign Jump_Target = (Pc_JalSrc) ? Alu_result : Pc_Target;    

endmodule

module Program_Counter (
    input Clk,Reset,Enable,
    input [31:0] Pc,
    output reg [31:0] Pc_next
);

always @(posedge Clk or posedge Reset) begin
    if(Reset) begin
        Pc_next <= 0;
    end
    else if(Enable)
         Pc_next <= Pc ;
end
    
endmodule


module RegFile (
    input Clk, Write_Enable,
    input [4:0] rs1, rs2, rd,
    input [31:0] Write_Data,
    output reg [31:0] Rd1, Rd2
);
    
reg [31:0] RegisterFile [31:0] ;
// RegisterFIle[0] --> Constant always 0 cant be changed
always @(*) begin
    Rd1 = (rs1 != 0) ? RegisterFile[rs1] : 0 ;
    Rd2 = (rs2 != 0) ? RegisterFile[rs2] : 0 ; 
end

always @(negedge Clk)
begin
    if(Write_Enable)
        RegisterFile[rd] <= Write_Data;
end

endmodule
module ResultSrc_Mux (
    input [31:0] Alu_Result_W, Read_DataW, PC4_WriteBack,
    input [1:0] ResultSrc,
    output [31:0] Result_WriteBack
);
// 00 - WriteBack at ALU Result 
// 01 - WriteBack at Rd 
// 10 - WriteBack at PCPLus4
    assign Result_WriteBack = ResultSrc[1] ? PC4_WriteBack : (ResultSrc[0] ? Read_DataW : Alu_Result_W  ) ;
endmodule

