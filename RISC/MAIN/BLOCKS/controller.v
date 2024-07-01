`include "MAIN/BLOCKS/BUILDING BLOCKS/controller_blocks.v"
`include "MAIN/BLOCKS/BUILDING BLOCKS/controller_pipeline.v"
module Controller (
    input Clk, Reset,
    input [6:0] Opcode,
    input [2:0] funct3,
    input funct7_5,
    input Zero_E, Sign_E, Flush_E,
    output Result_Src_0, MemWrite_M_O, PCJalSrc_E_O, PCSrc_E_O, Alu_SrcA_E_O, RegWriteM_O, RegWriteW_O,
    output [1:0] Alu_SrcB_E_O, Result_Src_W_O,
    output [2:0] ImmSrc_D_O,
    output [3:0] Alu_Control_E_O
);
/////////////////////
wire RegWrite_D, Branch_D, Jump_D, MemWrite_D, AluSrcA_D;
wire [1:0] AluSrcB_D, ResultSrc_D, AluOP;
wire [2:0] ImmSrc_D;
wire [3:0] Alu_Control_D;
//Connections Between Main and ALu Decoder First

/////////////////////
wire RegWrite_E, Branch_E, Jump_E, MemWrite_E, AluSrcA_E;
wire [1:0] AluSrcB_E, ResultSrc_E;
wire [3:0] AluControl_E;
//Connections Between  Pipeline Id/Iex 

/////////////////////
wire RegWrite_M,MemWrite_M; 
wire [1:0] ResultSrc_M;
//Connections Between Pipeline Iex/Imem

/////////////////////
wire RegWrite_W;
wire [1:0] Result_Src_W;
//Connections Between Pipeline Imem/Iw

Main_Decoder Decoder1(Opcode,RegWrite_D,Branch_D,Jump_D,MemWrite_D,AluSrcA_D,AluSrcB_D,ResultSrc_D,AluOP,ImmSrc_D);
Alu_Decoder  Decoder2(Opcode[5],funct7_5,funct3,AluOP,Alu_Control_D);
//Connection between Decoders and Id-Iex
C_Id_Iex Pipeline1(Clk,Reset,Flush_E,RegWrite_D,Branch_D,Jump_D,MemWrite_D,AluSrcA_D,AluSrcB_D,ResultSrc_D,Alu_Control_D,
                                     RegWrite_E,Branch_E,Jump_E,MemWrite_E,AluSrcA_E,AluSrcB_E,ResultSrc_E,AluControl_E);
C_Iex_Imem Pipeline2(Clk,Reset,RegWrite_E,MemWrite_E,ResultSrc_E,RegWrite_M,MemWrite_M,ResultSrc_M);
C_Imem_Iw Pipeline3(Clk,Reset,RegWrite_M,ResultSrc_M,RegWrite_W,Result_Src_W);

assign Result_Src_0 = ResultSrc_E[0];
assign MemWrite_M_O = MemWrite_M;
assign Alu_SrcA_E_O = AluSrcA_E;
assign RegWriteM_O = RegWrite_M;
assign RegWriteW_O = RegWrite_W;
assign Alu_SrcB_E_O = AluSrcB_E;
assign Result_Src_W_O = Result_Src_W;
assign ImmSrc_D_O = ImmSrc_D;
assign Alu_Control_E_O = AluControl_E;

///////////////////////
wire Branch_Wire;
assign Branch_Wire = ((funct3[2]) ? (funct3[0] ? Zero_E : ~Zero_E ) : (funct3[0] ? Sign_E : ~Sign_E ));
//Technically Connections for Branch Operations funct3 - > | 000-BEQ | 001-BNE | 110-BLTU | 111-BGTU |
assign PCSrc_E_O = (Branch_E & Branch_Wire ) | Jump_E;
// Cases for When do we need to jump
assign PCJalSrc_E_O = (Opcode == 7'b1100111) ? 1'b1 : 1'b0;//Unconditional Jump Opcode
//This Should also be passed as  the control Signal.... But That Opcode is not included in Maiin Decoder



endmodule