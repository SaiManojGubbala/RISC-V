// IEx - Instruction Execute IMem - Memory Stages....
// Pipeline register seperating execute and memory stages Iex_IMem Pipeline4(Clk,Reset,Alu_Result_E_W,Connector[2],Pc4_E_W,Rd_E_W, Alu_Result_M_W, Write_Data_M_W, PC4_Memory_W, Rd_M_W);
module Iex_IMem (
    input Clk, Reset,
    input [31:0] Alu_Result_E , Write_Data_E, PC4_Execute,
    input [4:0] Rd_E,
    output reg [31:0] Alu_Result_M, Write_Data_M, PC4_Memory,
    output reg [4:0] Rd_M
);

always @(posedge Clk or posedge Reset) begin
    if(Reset) begin
        Alu_Result_M <= 0;
        Write_Data_M <= 0;
        PC4_Memory   <= 0;
        Rd_M         <= 0;
    end

    else begin
        Alu_Result_M <= Alu_Result_E;
        Write_Data_M <= Write_Data_E;
        PC4_Memory   <= PC4_Execute;
        Rd_M         <= Rd_E;
    end
    
end
    
endmodule 

//ID - Instruction Decode IEx - Instruction Execute
//Pipeline Register Seperating Instruction Decode and Instruction Execute
module Id_Iex (
    input Clk, Reset, Clear,
    input [31:0] Read_Data1 , Read_Data2, PC_Decode, PC4_Decode, Imm_Extnd,
    input [4:0] Rs1_Decode, Rs2_Decode, Rd_Decode,
    output reg [31:0] Read_Data1_E, Read_Data2_E, PC_Execute, PC4_Execute, Imm_Extend_exe,
    output reg [4:0] Rs1_Execute, Rs2_Execute, Rd_Execute
);

always @(posedge Clk or posedge Reset ) begin
    if(Reset) begin
        Rd_Execute <= 0;
        Rs1_Execute <= 0;
        Rs2_Execute <= 0;
        Read_Data2_E <= 0;
        Read_Data1_E <= 0;
        PC_Execute <= 0;
        PC4_Execute <= 0;
        Imm_Extend_exe <= 0;
    end
    else if(Clear) begin
        Rd_Execute <= 0;
        Rs1_Execute <= 0;
        Rs2_Execute <= 0;
        Read_Data2_E <= 0;
        Read_Data1_E <= 0;
        PC_Execute <= 0;
        PC4_Execute <= 0;
        Imm_Extend_exe <= 0;
    end
    else begin
        Rd_Execute <= Rd_Decode;
        Rs1_Execute <= Rs1_Decode;
        Rs2_Execute <= Rs2_Decode;
        Read_Data2_E <= Read_Data2;
        Read_Data1_E <= Read_Data1;
        PC_Execute <= PC_Decode;
        PC4_Execute <= PC4_Decode;
        Imm_Extend_exe <= Imm_Extnd;
    end
    
end

endmodule

// imem - Memory Stage iw - WriteBack Stage
// Pipeining between Memory and WriteBack Stage 
module Imem_Iw (
    input Clk, Reset,
    input [31:0] Alu_Result_M, Read_DataM, PC4_Memory,
    input [4:0] Rd_M,
    output reg [31:0] Alu_Result_W, Read_DataW, PC4_WriteBack,
    output reg [4:0] Rd_W
);

always @(posedge Clk or posedge Reset) begin
    if(Reset) begin
        Alu_Result_W <= 0;
        Read_DataW <= 0;
        PC4_WriteBack <= 0;
        Rd_W <= 0;
    end

    else begin
        Alu_Result_W <= Alu_Result_M;
        Read_DataW <= Read_DataM;
        PC4_WriteBack <= PC4_Memory;
        Rd_W <= Rd_M;
    end
    
end

endmodule

//IF - Instruction Fetch ID - Instruction Decode
// So this is a pipeline reister that seperates Instruction Fetch and Decode Stages
module If_Id (
    input Clk, Reset, Clear, Enable,
    input [31:0] Instruction_Fetch, PC_Fetch, PC4_Fetch,
    output reg[31:0] Instruction_Decode, PC_Decode, PC4_Decode
);

always @(posedge Clk or posedge Reset)
    begin
    if(Reset) begin
        Instruction_Decode <= 0;
        PC_Decode <= 0;
        PC4_Decode <= 0;
     end    

     else if(Enable) begin
        if(Clear) begin
            Instruction_Decode <= 0;
            PC_Decode <= 0;
            PC4_Decode <= 0;
        end
        else begin
            Instruction_Decode <= Instruction_Fetch;
            PC_Decode <= PC_Fetch;
            PC4_Decode <= PC4_Fetch;
        end
     end
    end
endmodule
