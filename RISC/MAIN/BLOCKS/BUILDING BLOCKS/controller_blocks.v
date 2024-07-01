// ALU is Mainly used for R-Type and I-Type Instructions
// The funct3 values remain same for both operations in RV-32 I&R
// Subtraction only in R-Type
module Alu_Decoder (
    input opcode_5,
    input funct7_5,
    input [2:0] funct3,
    input [1:0] AluOP,
    output reg [3:0] Alu_Control
);

wire RSub ; 
wire Sra  ;
assign RSub = opcode_5 & funct7_5 ; //opcode_5 1 for R and funct7_5 1 for SUB
assign Sra  = funct7_5 ; // doesnt depend on opcode if funct7_5 is 1 for Sra and 0 for Srl 
localparam ADD = 3'b000 , // ADD/SUB it's 000
           SLL = 3'b001 ,
           SLT = 3'b010 ,
           SLTU = 3'b011 ,
           XOR = 3'b100 ,
           SRL = 3'b101 , // SRL/SRA it's 101
           OR  = 3'b110 ,
           AND = 3'b111 ;

always @(*) begin
    case(AluOP)
    2'b00 : Alu_Control = 4'b0000 ; // Addition
    2'b01 : Alu_Control = 4'b0001 ; // Subtraction
    default : case (funct3)
            3'b000  : Alu_Control = (RSub) ? {ADD,1'b1} : {ADD,1'b0} ;
            3'b001  : Alu_Control = {SLL,1'b0};
            3'b010  : Alu_Control = {SLT,1'b0};
            3'b011  : Alu_Control = {SLTU,1'b0};
            3'b100  : Alu_Control = {XOR,1'b0};
            3'b101  : Alu_Control = (Sra) ? {SRL,1'b1} : {SRL,1'b0};
            3'b110  : Alu_Control = {OR,1'b0};
            3'b111  : Alu_Control = {AND,1'b0};
            // Instead we can use this also here Alu_Control = {funct3,funct7} But Special case for RSub and Sra Keeping the above code for better clarity
            default : Alu_Control = 4'bxxxx;
    endcase
    endcase
end

    
endmodule


module Main_Decoder (
     input [6:0] Opcode ,
     output reg RegWrite, Branch, Jump, MemWrite, AluSrcA, 
     output reg [1:0] AluSrcB, ResultSrc, AluOP,
     output reg [2:0] ImmSrc
);
// R,B,I,J,L,S - Type of Instructions 
localparam R_Type = 7'b0110011,
           I_Type = 7'b0010011,// I type Alu or Computational
           B_Type = 7'b1100011,
           J_Type = 7'b1101111,
           S_Type = 7'b0100011, // SB SH SW
           L_Type = 7'b0000011, // LB LH LW
           Def    = 7'b0000000; // Default Type
           
always @(*) begin
    case (Opcode)
    R_Type    :begin
        RegWrite  = 1'b1;
        ImmSrc    = 3'bxxx;
        AluSrcA   = 1'b0;
        AluSrcB   = 2'b00;
        MemWrite  = 1'b0;
        ResultSrc = 2'b00;
        Branch    = 1'b0;
        AluOP     = 2'b10;
        Jump      = 1'b0;
        
    end
    I_Type    :begin
        RegWrite  = 1'b1;
        ImmSrc    = 3'b000;
        AluSrcA   = 1'b0;
        AluSrcB   = 2'b01;
        MemWrite  = 1'b0;
        ResultSrc = 2'b00;
        Branch    = 1'b0;
        AluOP     = 2'b10;
        Jump      = 1'b0;   
    end
    B_Type    :begin
        RegWrite  = 1'b0;
        ImmSrc    = 3'b010;
        AluSrcA   = 1'b0;
        AluSrcB   = 2'b00;
        MemWrite  = 1'b0;
        ResultSrc = 2'b00;
        Branch    = 1'b1;
        AluOP     = 2'b01;
        Jump      = 1'b0;    
    end
    J_Type    :begin
        RegWrite  = 1'b1;
        ImmSrc    = 3'b011;
        AluSrcA   = 1'b0;
        AluSrcB   = 2'b00;
        MemWrite  = 1'b0;
        ResultSrc = 2'b10;
        Branch    = 1'b0;
        AluOP     = 2'b00;
        Jump      = 1'b1;   
    end
    S_Type    :begin
        RegWrite  = 1'b0;
        ImmSrc    = 3'b001;
        AluSrcA   = 1'b0;
        AluSrcB   = 2'b01;
        MemWrite  = 1'b1;
        ResultSrc = 2'b00;
        Branch    = 1'b0;
        AluOP     = 2'b00;
        Jump      = 1'b0;   
    end
    L_Type    :begin
        RegWrite  = 1'b1;
        ImmSrc    = 3'b000;
        AluSrcA   = 1'b0;
        AluSrcB   = 2'b01;
        MemWrite  = 1'b0;
        ResultSrc = 2'b01;
        Branch    = 1'b0;
        AluOP     = 2'b00;
        Jump      = 1'b0;   
    end 
    default:begin
        RegWrite  = 1'b0;
        ImmSrc    = 3'b000;
        AluSrcA   = 1'b0;
        AluSrcB   = 2'b00;
        MemWrite  = 1'b0;
        ResultSrc = 2'b00;
        Branch    = 1'b0;
        AluOP     = 2'b00;
        Jump      = 1'b0;   
        end
    endcase   
end

endmodule





