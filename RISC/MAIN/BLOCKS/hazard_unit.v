module Hazard_Unit (
    input [4:0] Rs1_Decode,Rs1_Execute,Rs2_Decode,Rs2_Execute,
    input [4:0] Rd_Execute,Rd_Memory,Rd_Writeback,
    input RegWrite_M, RegWrite_W,
    input Result_Src_0,  PCSrc_E_O,
    output [1:0] Forward_AE, Forward_BE,
    output StallD, StallF, FlushD, Flush_E
);

wire l_Stall;

assign Forward_AE = ((Rs1_Execute == Rd_Memory)&(RegWrite_M)&(Rs1_Execute != 0)) ? 2'b10 :
                    ((Rs1_Execute == Rd_Writeback)&(RegWrite_W)&(Rs1_Execute != 0)) ? 2'b01 : 2'b00;

assign Forward_BE = ((Rs2_Execute == Rd_Memory)&(RegWrite_M)&(Rs2_Execute != 0)) ? 2'b10 :
                    ((Rs2_Execute == Rd_Writeback)&(RegWrite_W)&(Rs2_Execute != 0)) ? 2'b01 : 2'b00;

assign l_Stall = (Result_Src_0 == 1) & ((Rd_Execute == Rs1_Decode) | (Rd_Execute == Rs2_Decode));
assign StallF  = l_Stall;
assign StallD  = l_Stall;

assign Flush_E = l_Stall | PCSrc_E_O;
assign FlushD  = PCSrc_E_O;

endmodule
