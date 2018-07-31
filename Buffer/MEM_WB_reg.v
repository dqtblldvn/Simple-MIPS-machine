module MEM_WB_reg(addrin,addrout,datamemin,datamemout,MemToRegin,MemToRegout,EX_MEM_Rdest,MEM_WB_Rdest,RegWritein,RegWriteout,clk,rst);
input [31:0] addrin,datamemin;
input MemToRegin,RegWritein,clk,rst;
input [4:0] EX_MEM_Rdest;
output reg [31:0] addrout,datamemout;
output reg MemToRegout,RegWriteout;
output reg [4:0] MEM_WB_Rdest;

always @(posedge clk) begin
if (rst) begin
addrout=32'h000000;datamemout=32'h000000;
MemToRegout=0;RegWriteout=0;
MEM_WB_Rdest=5'b00000;
end
else
begin
addrout=addrin;datamemout=datamemin;
MemToRegout=MemToRegin;RegWriteout=RegWritein;
MEM_WB_Rdest=EX_MEM_Rdest;
end
end

endmodule
