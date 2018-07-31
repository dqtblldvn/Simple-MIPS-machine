module ID_EX_reg(Rdata1in,Rdata2in,Rdata1out,Rdata2out,immextin,immextout,shamtin,shamtout,IF_ID_Rs,IF_ID_Rt,IF_ID_Rd,ID_EX_Rs,ID_EX_Rt,ID_EX_Rd,
ALUCtrlin,ALUCtrlout,ALUSrcin,ALUSrcout,BWin,BWout,MemWritein,MemWriteout,RegDstin,RegDstout,
MemReadin,MemReadout,RegWritein,RegWriteout,MemToRegin,MemToRegout,clk,rst);
input [31:0] Rdata1in,Rdata2in,immextin;
input [4:0] shamtin,IF_ID_Rs,IF_ID_Rt,IF_ID_Rd;
input [3:0] ALUCtrlin;
input BWin,MemWritein,MemReadin,RegWritein,MemToRegin,RegDstin,ALUSrcin,clk,rst;
output reg [31:0] Rdata1out,Rdata2out,immextout;
output reg [4:0] shamtout,ID_EX_Rs,ID_EX_Rt,ID_EX_Rd;
output reg [3:0] ALUCtrlout;
output reg BWout,MemWriteout,MemReadout,RegWriteout,MemToRegout,RegDstout,ALUSrcout;

always @(posedge clk) begin
if (rst) begin
Rdata1out=32'h000000;Rdata2out=32'h000000;immextout=32'h000000;
shamtout=5'b00000;ID_EX_Rs=5'b00000;ID_EX_Rt=5'b00000;ID_EX_Rd=5'b00000;
ALUCtrlout=4'b0000;
BWout=0;MemWriteout=0;MemReadout=0;RegWriteout=0;MemToRegout=0;RegDstout=0;ALUSrcout=0;
end
else
begin
Rdata1out=Rdata1in;Rdata2out=Rdata2in;immextout=immextin;
shamtout=shamtin;ID_EX_Rs=IF_ID_Rs;ID_EX_Rt=IF_ID_Rt;ID_EX_Rd=IF_ID_Rd;
ALUCtrlout=ALUCtrlin;
BWout=BWin;MemWriteout=MemWritein;MemReadout=MemReadin;RegWriteout=RegWritein;MemToRegout=MemToRegin;RegDstout=RegDstin;ALUSrcout=ALUSrcin;
end
end

endmodule
