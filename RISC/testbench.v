
module tb();
    reg Clk,Reset;
    wire [31:0] AluResult_Memory;

    Top DUT(Clk,Reset,AluResult_Memory);
    initial begin
        $dumpfile("dff.vcd");
        $dumpvars(0);
      end
    initial begin
    forever begin
       #50 Clk = ~Clk ; 
    end
    end
    initial begin
        Clk = 1'b0;
        Reset = 1'b1;
        #60;
        Reset = 1'b0;
       
        $monitor("%d",AluResult_Memory);
    end
endmodule