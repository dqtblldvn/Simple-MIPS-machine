module DataMemory(rst,Addr,WriteData,ReadData,MemRead,MemWrite,BW);

input          rst;
input    MemWrite,MemRead,BW;
input  [31:0] Addr;
input  [31:0] WriteData;
output reg [31:0] ReadData;

reg    [15:0] i;
reg [7:0] memDATA [65535:0];


always@(posedge rst) begin
	memDATA[0]=8'h00;  memDATA[1]=8'h47;  memDATA[2]=8'h13;  memDATA[3]=8'h04;
	memDATA[4]=8'h65;  memDATA[5]=8'h8F;  memDATA[6]=8'hA0;  memDATA[7]=8'h25;
	memDATA[8]=8'h90;  memDATA[9]=8'h09;  memDATA[10]=8'h72; memDATA[11]=8'h25;
	memDATA[12]=8'h88; memDATA[13]=8'h88; memDATA[14]=8'h11; memDATA[15]=8'h00;
	memDATA[16]=8'h00; memDATA[17]=8'h00; memDATA[18]=8'h00; memDATA[19]=8'h05;
	memDATA[20]=8'h00; memDATA[21]=8'h00; memDATA[22]=8'h00; memDATA[23]=8'h0C;
	memDATA[24]=8'h00; memDATA[25]=8'h00; memDATA[26]=8'h00; memDATA[27]=8'h14;
	memDATA[28]=8'h00; memDATA[29]=8'hA0; memDATA[30]=8'h90; memDATA[31]=8'h25;
	memDATA[32]=8'h5B; memDATA[33]=8'h03; memDATA[34]=8'h20; memDATA[35]=8'hE4;
	memDATA[36]=8'hAA; memDATA[37]=8'hAA; memDATA[38]=8'hAA; memDATA[39]=8'hAA;
	memDATA[40]=8'h00; memDATA[41]=8'h00; memDATA[42]=8'h00; memDATA[43]=8'h20;
	memDATA[50]=8'h07; memDATA[51]=8'hFE; memDATA[52]=8'h10; memDATA[53]=8'hA6;    		                
end
always @(MemRead or MemWrite or BW or Addr or WriteData)
begin
if (rst==0) begin 
if (MemWrite) begin
	if (BW==0) //SB
	memDATA[Addr[15:0]]=WriteData[7:0];
	else //SW
	begin
	memDATA[Addr[15:0]]=WriteData[31:24];
	memDATA[Addr[15:0]+1]=WriteData[23:16];
	memDATA[Addr[15:0]+2]=WriteData[15:8];
	memDATA[Addr[15:0]+3]=WriteData[7:0];
	end
	end
if (MemRead) begin
if (BW==0) //LBU
	ReadData={24'h000000,memDATA[Addr[15:0]]};
	else //LW
	begin
	ReadData[31:24]=memDATA[Addr[15:0]];
	ReadData[23:16]=memDATA[Addr[15:0]+1];
	ReadData[15:8]=memDATA[Addr[15:0]+2];
	ReadData[7:0]=memDATA[Addr[15:0]+3];
	end
	end
end
end
endmodule
