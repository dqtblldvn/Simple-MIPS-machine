module EX_MEM_reg(ALUResultin,ALUResultout,Rdata2in,Rdata2out,RDestin,EX_MEM_Rdest,RegWritein,RegWriteout,BWin,BWout,MemWritein,MemWriteout,MemReadin,MemReadout,
MemToRegin,MemToRegout,clk,rst);
input [31:0] ALUResultin,Rdata2in;
input [4:0] RDestin;
input RegWritein,BWin,MemWritein,MemReadin,MemToRegin,clk,rst;
output reg [31:0] ALUResultout,Rdata2out;
output reg [4:0] EX_MEM_Rdest;
output reg RegWriteout,BWout,MemWriteout,MemReadout,MemToRegout;

always @(posedge clk) begin
if (rst) begin
ALUResultout=32'h000000;Rdata2out=32'h000000;
EX_MEM_Rdest=5'b00000;
RegWriteout=0;BWout=0;MemWriteout=0;MemReadout=0;MemToRegout=0;
end
else
begin
ALUResultout=ALUResultin;Rdata2out=Rdata2in;
EX_MEM_Rdest=RDestin;
RegWriteout=RegWritein;BWout=BWin;MemWriteout=MemWritein;MemReadout=MemReadin;MemToRegout=MemToRegin;
end
end

endmodule
