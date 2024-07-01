`include "MAIN/BLOCKS/hazard_unit.v"
`include "MAIN/BLOCKS/controller.v"
`include "MAIN/BLOCKS/datapath.v"


module RISC_V (
    input Clk,Reset,
    input [31:0] Instruction,ReadData_Memory,
    output [31:0] Pc,AluResult_Memory,WriteData_Memory,
    output Memory_Write
);
wire regwritem,regwritew,pc_src_o,pc_jal_src_o;
wire [31:0] Instruction_Decode;
wire Zero , Sign ;
wire stalld,stallf,flushd,flushe,resultsrc_0,alusrca;
wire [1:0]forwarda,forwardb,alusrcb,resultsrc;
wire [2:0] imm_src;
wire [3:0] alucontrol;
wire [4:0]rs1d,rs2d,rs1e,rs2e,rde,rdm,rdw;

Hazard_Unit hazard(rs1d,rs1e,rs2d,rs2e,rde,rdm,rdw,regwritem,regwritew,resultsrc_0,pc_src_o,forwarda,forwardb,stalld,stallf,flushd,flushe);
Controller control(Clk,Reset,Instruction_Decode[6:0],Instruction_Decode[14:12],Instruction_Decode[30],Zero, Sign, flushe,
                  resultsrc_0,Memory_Write,pc_jal_src_o,pc_src_o,alusrca,regwritem,regwritew,alusrcb,resultsrc,imm_src,alucontrol);
DataPath datapath(Clk,Reset,pc_jal_src_o,pc_src_o,stallf,stalld,flushd,flushe,regwritew,alusrca,resultsrc,forwarda,forwardb,alusrcb,imm_src,alucontrol,Instruction,ReadData_Memory,
                  Pc,Instruction_Decode,AluResult_Memory,WriteData_Memory,Zero,Sign,rs1d,rs1e,rs2d,rs2e,rde,rdm,rdw);


endmodule