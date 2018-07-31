module PC_module(PC_in, PC_out,PC_add,clk,rst,PCload);
input [31:0] PC_in;
output reg [31:0] PC_out;
output reg [31:0] PC_add;
input clk,rst,PCload;


always @( posedge rst)
begin
	PC_out=32'hfffffffc;
	PC_add=32'h00000000;
end
always @(posedge clk)
begin
if ((PCload)&&(rst==0))
begin
	PC_out=PC_in;
end
PC_add=PC_out+4; 
end
endmodule
