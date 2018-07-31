module registerfile(rdt1, rdt2, rst,
		    reg1, reg2, write_reg, write_data, clk, RegWrite,JALsave,PC_add);

input[4:0] reg1,reg2;
input [4:0] write_reg;
input[31:0]write_data,PC_add;
input clk, rst,RegWrite,JALsave;
output reg[31:0] rdt1;
output reg[31:0] rdt2;
reg[31:0] file[31:0];
reg[4:0] i;
reg [4:0] tmpadd1,tmpadd2;
always @(posedge clk or write_data or reg1 or reg2) begin
if (rst) 
begin 
file[0]=32'h00000000;
file[1]=32'h00000000;
file[2]=32'h00000000;
file[3]=32'h00000000;
file[4]=32'h00000000;
file[5]=32'h00000000;
file[6]=32'h00000000;
file[7]=32'h00000000;
file[8]=32'h00000000;
file[9]=32'h00000000;
file[10]=32'h00000000;
file[11]=32'h00000000;
file[12]=32'h00000000;
file[13]=32'h00000000;
file[14]=32'h00000000;
file[15]=32'h00000000;
file[16]=32'h00000000;
file[17]=32'h00000000;
file[18]=32'h00000000;
file[19]=32'h00000000;
file[20]=32'h00000000;
file[21]=32'h00000000;
file[22]=32'h00000000;
file[23]=32'h00000000;
file[24]=32'h00000000;
file[25]=32'h00000000;
file[26]=32'h00000000;
file[27]=32'h00000000;
file[28]=32'h00000000;
file[29]=32'h00000000;
file[30]=32'h00000000;
file[31]=32'h00000000;
end
else
begin 
	tmpadd1=reg1;
	tmpadd2=reg2;
	if (RegWrite==1)
	file[write_reg]<=write_data;
	if (JALsave==1)
	file[31]<=PC_add;
end
end
always @(negedge clk)
begin
	rdt1=file[tmpadd1];
	rdt2=file[tmpadd2];
end
endmodule
