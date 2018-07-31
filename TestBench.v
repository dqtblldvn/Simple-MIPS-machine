module TestBench();
reg rst,clk;
wire OV;

MIPS_Machine Machine(clk,rst,OV);
initial begin
rst=1;
clk=0;
#20 rst=0; 
end
always
begin 
#4 clk=~clk;
end
endmodule

