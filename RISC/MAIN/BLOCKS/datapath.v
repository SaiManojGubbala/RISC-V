`include "MAIN/BLOCKS/BUILDING BLOCKS/datapath_blocks.v"
`include "MAIN/BLOCKS/BUILDING BLOCKS/datapath_pipeline.v"
module DataPath (
    input Clk,Reset,
    input PCJalSrc_E_O,PCSrc_E_O,Stall_F,Stall_D,Flush_D,Flush_E,RegWriteW_O,Alu_SrcA_E_O,
    input [1:0] Result_Src_W_O,Forward_AE,Forward_BE,Alu_SrcB_E_O,
    input [2:0] ImmSrc_D_O,
    input [3:0] Alu_Control_E_O,
    input [31:0] Instruction_Fetch,
    input [31:0] ReadData_Memory,
    output [31:0] Pc_F,Instruction_Decode,Alu_Result_M,WriteData_Mem,
    output Zero_E,Sign_E,
    output [4:0] Rs1_Decode, Rs1_Execute, Rs2_Decode, Rs2_Execute,
    output [4:0] Rd_Execute, Rd_Memory, Rd_Writeback
);
// Making Program Counter Connections
wire [31:0] JumpTarget_W, // Just a wire b/w 2 muxes not connected anywhere
            IncrementPc,// Obtained at decode stage and sent through pipeline until writeback **
            Pc_Value_W, // Connector between output mux and program counter not connected anywhere 
            Alu_Result_W, // No pipeline directly connected fro ALU Result but is connected to pipeline **
            PC_Target_W, // No pipeline calculated in execution stage connected to mux **
            PC_Next_W; // connected to Pc_F and input to adder
Pc_Mux2 Multiplexer2 (PC_Target_W,Alu_Result_E_W,PCJalSrc_E_O,JumpTarget_W) ;
Pc_Mux Multiplexer1 (IncrementPc,JumpTarget_W,PCSrc_E_O,Pc_Value_W) ;

Program_Counter PC(Clk,Reset,~Stall_F,Pc_Value_W,PC_Next_W); // Pc_F input to instruction memory so its an output here

assign Pc_F = PC_Next_W ;
////////////////////////////////////////////////////////////////////////////////////
// Fetch Stage Connections
wire [31:0] Instruction_Decode_W ,// Connected to output reg file and imm xtnd
            PC_Decode_W ,
            PC4_Decode_W ; // Directly connected to nect pipeline
Adder Add_Circuit1 (PC_Next_W,32'd4,IncrementPc);
If_Id Pipeline2 (Clk,Reset,Flush_D,~Stall_D,Instruction_Fetch,PC_Next_W,IncrementPc,Instruction_Decode_W,PC_Decode_W,PC4_Decode_W);

assign Instruction_Decode = Instruction_Decode_W ;
////////////////////////////////////////////////////////////////////////////////////
// Decode Stage Connections 
wire [31:0] Imm_Extend_W;
wire [4:0] rd_W; //comes to rd location as input from WriteBack Module and connected to hazard unit
wire [31:0] Result_W,Rd1W,Rd2W;//Result of Write Back Operation connected to reg file only
//Pipeline Outputs
wire [31:0] Read_Data1_E_W, Read_Data2_E_W, Pc_E_W, Pc4_E_W, Imm_Extend_E_W;
wire [4:0] Rs1_E_W, Rs2_E_W, Rd_E_W; 
//////////////////
Sign_Extend Extend (Instruction_Decode_W,ImmSrc_D_O,Imm_Extend_W);
RegFile Regiters (Clk,RegWriteW_O,Instruction_Decode_W[19:15],Instruction_Decode_W[24:20],rd_W,Result_W,Rd1W,Rd2W);
Id_Iex Pipeline3 (Clk,Reset,Flush_E,Rd1W,Rd2W,PC_Decode_W,PC4_Decode_W,Imm_Extend_W,Instruction_Decode_W[19:15],Instruction_Decode_W[24:20],Instruction_Decode_W[11:7],Read_Data1_E_W,Read_Data2_E_W,Pc_E_W,Pc4_E_W,Imm_Extend_E_W,Rs1_E_W, Rs2_E_W, Rd_E_W);
////////////////////////////////////////////////////////////////////////////////////
// Execute Stage Connections Outputs of Pipeline3 Most of them
wire [31:0] Alu_Result_M_W;
wire [31:0] Connector [3:0];
wire [31:0] Alu_Result_E_W;
wire [1:0] Flags ; 
Forward1 Multiplexer3 (Read_Data1_E_W,Result_W,Alu_Result_M_W,Forward_AE,Connector[0]);
Mux2 Multiplexer4 (Alu_SrcA_E_O,Connector[0],32'd0,Connector[1]);
Forward2 Multiplexer5 (Read_Data2_E_W,Result_W,Alu_Result_M_W,Forward_BE,Connector[2]);
Mux3 Multiplexer6 (Alu_SrcB_E_O,Connector[2],Imm_Extend_E_W,PC_Target_W,Connector[3]);
Adder Add_Circuit2 (Pc_E_W,Imm_Extend_E_W,PC_Target_W);
Alu ALU (Connector[1],Connector[3],Alu_Result_E_W,Alu_Control_E_O,Flags[0],Flags[1]);
assign Zero_E  = Flags[0] ;
assign Sign_E  = Flags[1] ;
//Pipeline Outputs
wire [31:0] Write_Data_M_W, PC4_Memory_W;
wire [4:0] Rd_M_W;
wire [31:0] Alu_Result_W_W, Read_DataW_W, PC4_WriteBack_W;

///////////////////
Iex_IMem Pipeline4(Clk,Reset,Alu_Result_E_W,Connector[2],Pc4_E_W,Rd_E_W, Alu_Result_M_W, Write_Data_M_W, PC4_Memory_W, Rd_M_W);
assign Alu_Result_M = Alu_Result_M_W ;
assign WriteData_Mem = Write_Data_M_W ;
Imem_Iw Pipeline5(Clk,Reset,Alu_Result_M_W,ReadData_Memory,PC4_Memory_W,Rd_M_W,Alu_Result_W_W, Read_DataW_W, PC4_WriteBack_W,rd_W);
ResultSrc_Mux Multiplexer7(Alu_Result_W_W,Read_DataW_W,PC4_WriteBack_W,Result_Src_W_O,Result_W);

assign Rs1_Decode = Instruction_Decode_W[19:15];
assign Rs2_Decode = Instruction_Decode_W[24:20];
assign Rs1_Execute = Rs1_E_W;
assign Rs2_Execute = Rs2_E_W;
assign Rd_Execute  = Rd_E_W;
assign Rd_Memory   = Rd_M_W;
assign Rd_Writeback =  rd_W;
endmodule
