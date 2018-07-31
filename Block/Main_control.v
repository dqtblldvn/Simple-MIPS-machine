module main_control(clk,rst,opcode,funct,RegDst,RegWrite,ALUSrc,ALUOp,Branch,BNE,ZorS,JALCtrl,MemWrite,MemRead,MemToReg,BW,JumpReg);
input clk,rst;
input [5:0] opcode;
input [5:0] funct;
output reg RegDst,RegWrite,ALUSrc,Branch,BNE,ZorS,JALCtrl,MemWrite,MemRead,MemToReg,BW,JumpReg;
output reg [3:0] ALUOp;

always @(posedge clk or opcode or funct) begin
if (rst) 
begin
RegDst=0; RegWrite=0; ALUSrc=0; Branch=0; BNE=0; ZorS=0; JALCtrl=0; MemWrite=0; MemRead=0; MemToReg=0; BW=0;
ALUOp=4'b0000; JumpReg=0;
end
else
begin
case(opcode)
6'b000000: //R-type instructions
begin
case(funct)
6'b100000: //ADD
begin
RegDst=1; RegWrite=1; ALUSrc=0; Branch=0; BNE=0; ZorS=0; JALCtrl=0; MemWrite=0; MemRead=0; MemToReg=0; BW=0;
ALUOp=4'b0010; JumpReg=0;
end
6'b100100: //AND
begin
RegDst=1; RegWrite=1; ALUSrc=0; Branch=0; BNE=0; ZorS=0; JALCtrl=0; MemWrite=0; MemRead=0; MemToReg=0; BW=0;
ALUOp=4'b0000; JumpReg=0;
end
6'b100111: //NOR
begin
RegDst=1; RegWrite=1; ALUSrc=0; Branch=0; BNE=0; ZorS=0; JALCtrl=0; MemWrite=0; MemRead=0; MemToReg=0; BW=0;
ALUOp=4'b0011; JumpReg=0;
end
6'b100101: //OR
begin
RegDst=1; RegWrite=1; ALUSrc=0; Branch=0; BNE=0; ZorS=0; JALCtrl=0; MemWrite=0; MemRead=0; MemToReg=0; BW=0;
ALUOp=4'b0001; JumpReg=0;
end
6'b101010: //SLT
begin
RegDst=1; RegWrite=1; ALUSrc=0; Branch=0; BNE=0; ZorS=0; JALCtrl=0; MemWrite=0; MemRead=0; MemToReg=0; BW=0;
ALUOp=4'b0111; JumpReg=0;
end
6'b001000: //JR
begin
RegDst=0; RegWrite=0; ALUSrc=0; Branch=0; BNE=0; ZorS=0; JALCtrl=0; MemWrite=0; MemRead=0; MemToReg=0; BW=0;
JumpReg=1;
end
6'b000000: //SLL
begin
RegDst=1; RegWrite=1; ALUSrc=0; Branch=0; BNE=0; ZorS=0; JALCtrl=0; MemWrite=0; MemRead=0; MemToReg=0; BW=0;
ALUOp=4'b0100; JumpReg=0;
end
6'b000010: //SRL
begin
RegDst=1; RegWrite=1; ALUSrc=0; Branch=0; BNE=0; ZorS=0; JALCtrl=0; MemWrite=0; MemRead=0; MemToReg=0; BW=0;
ALUOp=4'b0101; JumpReg=0;
end
endcase
end

6'b001000: //ADDI
begin
RegDst=0; RegWrite=1; ALUSrc=1; Branch=0; BNE=0; ZorS=1; JALCtrl=0; MemWrite=0; MemRead=0; MemToReg=0; BW=0;
ALUOp=4'b0010; JumpReg=0;
end

6'b001100: //ANDI
begin
RegDst=0; RegWrite=1; ALUSrc=1; Branch=0; BNE=0; ZorS=1; JALCtrl=0; MemWrite=0; MemRead=0; MemToReg=0; BW=0;
ALUOp=4'b0000; JumpReg=0;
end

6'b000100: //BEQ
begin
RegDst=0; RegWrite=0; ALUSrc=0; Branch=1; BNE=0; ZorS=1; JALCtrl=0; MemWrite=0; MemRead=0; MemToReg=0; BW=0;
ALUOp=4'b0110; JumpReg=0;
end

6'b000101: //BNE
begin
RegDst=0; RegWrite=0; ALUSrc=0; Branch=0; BNE=1; ZorS=1; JALCtrl=0; MemWrite=0; MemRead=0; MemToReg=0; BW=0;
ALUOp=4'b0110; JumpReg=0;
end

6'b000010: //J
begin
RegDst=0; RegWrite=0; ALUSrc=0; Branch=0; BNE=0; ZorS=0; JALCtrl=1; MemWrite=0; MemRead=0; MemToReg=0; BW=0;
JumpReg=0;
end

6'b000011: //JAL
begin
RegDst=0; RegWrite=1; ALUSrc=0; Branch=0; BNE=0; ZorS=0; JALCtrl=1; MemWrite=0; MemRead=0; MemToReg=0; BW=0;
JumpReg=0;
end

6'b100100: //LBU
begin
RegDst=0; RegWrite=1; ALUSrc=1; Branch=0; BNE=0; ZorS=1; JALCtrl=0; MemWrite=0; MemRead=1; MemToReg=1; BW=0;
ALUOp=4'b0010; JumpReg=0;
end

6'b100011: //LW
begin
RegDst=0; RegWrite=1; ALUSrc=1; Branch=0; BNE=0; ZorS=1; JALCtrl=0; MemWrite=0; MemRead=1; MemToReg=1; BW=1;
ALUOp=4'b0010; JumpReg=0;
end

6'b001111: //LUI
begin
RegDst=0; RegWrite=1; ALUSrc=1; Branch=0; BNE=0; ZorS=0; JALCtrl=0; MemWrite=0; MemRead=0; MemToReg=0; BW=0;
ALUOp=4'b1000; JumpReg=0;
end

6'b001101: //ORI
begin
RegDst=0; RegWrite=1; ALUSrc=1; Branch=0; BNE=0; ZorS=0; JALCtrl=0; MemWrite=0; MemRead=0; MemToReg=0; BW=0;
ALUOp=4'b0001; JumpReg=0;
end

6'b001010: //SLTI
begin
RegDst=0; RegWrite=1; ALUSrc=1; Branch=0; BNE=0; ZorS=1; JALCtrl=0; MemWrite=0; MemRead=0; MemToReg=0; BW=0;
ALUOp=4'b0111; JumpReg=0;
end

6'b101000: //SB
begin
RegDst=0; RegWrite=0; ALUSrc=1; Branch=0; BNE=0; ZorS=1; JALCtrl=0; MemWrite=1; MemRead=0; MemToReg=0; BW=0;
ALUOp=4'b0010; JumpReg=0;
end

6'b101011: //SW
begin
RegDst=0; RegWrite=0; ALUSrc=1; Branch=0; BNE=0; ZorS=1; JALCtrl=0; MemWrite=1; MemRead=0; MemToReg=0; BW=1;
ALUOp=4'b0010; JumpReg=0;
end

default:
begin
RegDst=0; RegWrite=0; ALUSrc=0; Branch=0; BNE=0; ZorS=0; JALCtrl=0; MemWrite=0; MemRead=0; MemToReg=0; BW=0;
ALUOp=4'b0000; JumpReg=0;
end

endcase
end
end
endmodule
