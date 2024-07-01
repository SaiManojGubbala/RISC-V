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

