module ALU_block(clk,rst,T1,T2,shamt,ALUOp,OV,Result);
input clk,rst;
input [31:0] T1;
input [31:0] T2;
input [3:0] ALUOp;
input [4:0] shamt;
output reg OV;
output reg [31:0] Result;
reg [32:0] tmp;


always @(posedge clk or ALUOp or T1 or T2) begin
if (rst)
begin OV=0; Result=32'b00000000000000000000000000000000; end
else
begin
case (ALUOp)
4'b0000: //And
begin
Result = T1 & T2;
end
4'b0001: //Or
begin
Result = T1 | T2;
end
4'b0010: //Add
begin
tmp={T1[31],T1[31:0]}+{T2[31],T2[31:0]};
if (tmp[32]!=tmp[31])
	OV=1;
else
Result=tmp[31:0];
end
4'b0011: //Nor
begin 
Result = ~(T1 | T2);
end
4'b0100: //Shift left
begin
Result = T2 << shamt;
end
4'b0101: //Shift right
begin
Result = T2 >> shamt;
end
//4'b0110: //BNE,BEQ
//begin
//if ((T1 - T2)==0) Zero=1;
//else Zero=0;
//end
4'b0111: //SLT
begin
if (T1<T2) 
Result=32'b00000000000000000000000000000001;
else Result=32'b00000000000000000000000000000000;
end
4'b1000: //LUI
begin
Result={T2[15:0],16'b0000000000000000};
end
endcase
end
end
endmodule
