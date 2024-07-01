//Pipeline Between Decode and Execute but for Control Signals
module C_Id_Iex (
    input Clk,Reset,Clear,
    input RegWrite_D, Branch_D, Jump_D, MemWrite_D, AluSrcA_D, 
    input [1:0] AluSrcB_D, ResultSrc_D,
    input [3:0] AluControl_D, 
    output reg RegWrite_E, Branch_E, Jump_E, MemWrite_E, AluSrcA_E, 
    output reg [1:0] AluSrcB_E, ResultSrc_E,
    output reg [3:0] AluControl_E
);

always @(posedge Clk or posedge Reset)
begin
    if(Reset)
    begin
         RegWrite_E <= 0 ; 
         Branch_E   <= 0 ;
         Jump_E     <= 0 ;
         MemWrite_E <= 0 ;
         AluSrcA_E  <= 0 ; 
         AluSrcB_E  <= 0 ;
         ResultSrc_E<= 0 ;
         AluControl_E<=0 ; 
    end
    else if(Clear)
    begin
        RegWrite_E <= 0 ; 
        Branch_E   <= 0 ;
        Jump_E     <= 0 ;
        MemWrite_E <= 0 ;
        AluSrcA_E  <= 0 ; 
        AluSrcB_E  <= 0 ;
        ResultSrc_E<= 0 ;
        AluControl_E<=0 ;         
    end
    else
    begin
        RegWrite_E <= RegWrite_D ; 
        Branch_E   <= Branch_D ;
        Jump_E     <= Jump_D ;
        MemWrite_E <= MemWrite_D ;
        AluSrcA_E  <= AluSrcA_D ; 
        AluSrcB_E  <= AluSrcB_D ;
        ResultSrc_E<= ResultSrc_D ;
        AluControl_E<=AluControl_D; 
    end
end
    
endmodule

module C_Iex_Imem (
    input Clk,Reset,
    input RegWrite_E, MemWrite_E,
    input [1:0] ResultSrc_E,
    output reg RegWrite_M, MemWrite_M,
    output reg [1:0] ResultSrc_M
);

always @(posedge Clk or posedge Reset) begin
    if(Reset) begin
        RegWrite_M <= 0;
        MemWrite_M <= 0;
        ResultSrc_M<= 0;
    end

    else begin
        RegWrite_M <= RegWrite_E;
        MemWrite_M <= MemWrite_E;
        ResultSrc_M<= ResultSrc_E;
    end
    
end

endmodule

module C_Imem_Iw (
    input Clk, Reset,
    input RegWrite_M, 
    input [1:0] ResultSrc_M,
    output reg RegWrite_W,
    output reg [1:0] ResultSrc_W
);

always @(posedge Clk or posedge Reset) begin
    if(Reset) begin
        RegWrite_W <= 0; 
        ResultSrc_W <= 0;
    end
    else begin
        RegWrite_W <= RegWrite_M ;
        ResultSrc_W <= ResultSrc_M ;
    end
end
    
endmodule
