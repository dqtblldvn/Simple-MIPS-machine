module MIPS_Machine(clk,rst,OV);
input clk,rst;
output OV;
wire [31:0] PC_in,PC_out,IF_PC_add,ID_PC_add,ID_imm,ID_rdt1,ID_rdt2,WriteData,T1,T2,T3,T4,EX_ALUResult,MEM_ALUResult,MEM_rdt2,MEM_ReadData,PT2,EX_imm,
WB_ALUResult,WB_ReadData,MemJal,EX_rdt1,EX_rdt2,PCJAL,PCReg,PCBranch,PCJAL2;
wire PCload,Branch,Zero,BNE,PCSrc,ID_RegDst,ID_RegWrite,ID_ALUSrc,ZorS,JALCtrl,ID_MemWrite,ID_MemRead,ID_MemToReg,ID_BW,JumpReg,WB_RegWrite,
MEM_MemRead,MEM_MemWrite,MEM_BW,EX_ALUSrc,WB_MemToReg,EX_RegDst,ControlLoad,IDA_RegDst,IDA_RegWrite,IDA_ALUSrc,IDA_MemWrite,IDA_MemRead,IDA_MemToReg,IDA_BW,
IF_ID_Write,EX_BW,EX_MemWrite,EX_MemRead,EX_RegWrite,EX_MemToReg,MEM_RegWrite,ID_ins_26,IF_ins_26,BRAL;
wire [25:0] ID_ins_25_0,IF_ins_25_0;
wire [5:0] IF_ins_5_0,IF_ins_31_26,ID_ins_31_26,ID_ins_5_0;
wire [15:0] IF_ins_15_0,ID_ins_15_0;
wire [4:0] IF_ins_15_11,IF_ins_20_16,IF_ins_25_21,IF_ins_10_6,ID_ins_25_21,ID_ins_20_16,write_reg,EX_ins_10_6,ID_ins_15_11,RegJAL,EX_ins_20_16,EX_ins_15_11,
EX_Rdest,ID_ins_10_6,EX_ins_25_21,MEM_Rdest,WB_Rdest;
wire [3:0] ID_ALUOp,EX_ALUOp,IDA_ALUOp; 
wire [1:0] forward_a,forward_b,forward_c,forward_d;
wire [17:0] imm_sl2;

assign JALsave=JALCtrl&ID_ins_26;
assign BRAL=(((IF_ins_31_26==6'b000100)|(IF_ins_31_26==6'b000101)) && ((ID_ins_31_26==6'b100011)|(ID_ins_31_26==6'b100100)));
PC_module PC1(PC_in,PC_out,IF_PC_add,clk,rst,PCload);
PCcal PC2(ID_PC_add,ID_ins_25_0,imm_sl2,PCBranch,PCJAL);
PCSource PCZ(Branch, Zero, BNE, PCSrc);
InstructionMemory InsMem(rst,PC_out,clk,IF_ins_25_0,IF_ins_5_0,IF_ins_15_0,IF_ins_15_11,IF_ins_20_16,IF_ins_25_21,IF_ins_31_26,IF_ins_10_6,IF_ins_26);
main_control Ctrl(clk,rst,ID_ins_31_26,ID_ins_5_0,ID_RegDst,ID_RegWrite,ID_ALUSrc,ID_ALUOp,Branch,BNE,ZorS,JALCtrl,ID_MemWrite,ID_MemRead,ID_MemToReg,ID_BW,JumpReg);
ImmediateExtend ImmExt(ID_ins_15_0,ZorS,ID_imm,imm_sl2);
registerfile RegFile(ID_rdt1, ID_rdt2, rst, ID_ins_25_21, ID_ins_20_16, write_reg,WriteData, clk, WB_RegWrite,JALsave,ID_PC_add);
ALU_block ALU(clk,rst,T1,T2,EX_ins_10_6,EX_ALUOp,OV,EX_ALUResult);
DataMemory DataMem(rst,MEM_ALUResult,MEM_rdt2,MEM_ReadData,MEM_MemRead,MEM_MemWrite,MEM_BW);
MUX21_32bit MBranch(IF_PC_add,PCBranch,PCSrc,PCJAL2);
MUX21_32bit MJAL(PCJAL2,PCJAL,JALCtrl,PCReg);
MUX21_32bit MJR(PCReg,ID_rdt1,JumpReg,PC_in);
assign write_reg=WB_Rdest;
MUX21_32bit MALU(PT2,EX_imm,EX_ALUSrc,T2);
MUX21_32bit MALUorMEM(WB_ALUResult,WB_ReadData,WB_MemToReg,WriteData);
MUX21_32bit #5 MRdest(EX_ins_20_16,EX_ins_15_11,EX_RegDst,EX_Rdest);
MUX31_32bit forwarda(EX_rdt1,WriteData,MEM_ALUResult,forward_a,T1);
MUX31_32bit forwardb(EX_rdt2,WriteData,MEM_ALUResult,forward_b,PT2);
MUX31_32bit forwardc(ID_rdt1,MEM_ALUResult,EX_ALUResult,forward_c,T3);
MUX31_32bit forwardd(ID_rdt2,MEM_ALUResult,EX_ALUResult,forward_d,T4);
MUX21_32bit #1 HRegDst(1'b0,ID_RegDst,ControlLoad,IDA_RegDst);
MUX21_32bit #1 HRegWrite(1'b0,ID_RegWrite,ControlLoad,IDA_RegWrite);
MUX21_32bit #1 HALUSrc(1'b0,ID_ALUSrc,ControlLoad,IDA_ALUSrc);
MUX21_32bit #4 HALUOp(4'b0000,ID_ALUOp,ControlLoad,IDA_ALUOp);
MUX21_32bit #1 HMemWrite(1'b0,ID_MemWrite,ControlLoad,IDA_MemWrite);
MUX21_32bit #1 HMemRead(1'b0,ID_MemRead,ControlLoad,IDA_MemRead);
MUX21_32bit #1 HMemToReg(1'b0,ID_MemToReg,ControlLoad,IDA_MemToReg);
MUX21_32bit #1 HBW(1'b0,ID_BW,ControlLoad,IDA_BW);
Hazard_Detection_Unit HDU(PCload,IF_ID_Write,EX_ins_20_16,ID_ins_20_16,ControlLoad,EX_MemRead,ID_ins_25_21,rst,BRAL);
assign IF_Flush=PCSrc|JALCtrl|JumpReg;
Forwarding_Unit FU(MEM_Rdest,EX_ins_25_21,EX_ins_20_16,WB_Rdest,MEM_RegWrite,WB_RegWrite,forward_a,forward_b,
		ID_ins_25_21,ID_ins_20_16,EX_Rdest,forward_c,forward_d);
IF_ID_reg IFID(IF_ID_Write,IF_PC_add,clk,ID_PC_add,rst,IF_ins_5_0,ID_ins_5_0,IF_ins_31_26,ID_ins_31_26,IF_ins_25_21,ID_ins_25_21,IF_ins_20_16,ID_ins_20_16,
IF_ins_15_11,ID_ins_15_11,IF_ins_25_0,ID_ins_25_0,IF_ins_10_6,ID_ins_10_6,IF_ins_15_0,ID_ins_15_0,IF_Flush,IF_ins_26,ID_ins_26,BRAL);
ID_EX_reg IDEX(ID_rdt1,ID_rdt2,EX_rdt1,EX_rdt2,ID_imm,EX_imm,ID_ins_10_6,EX_ins_10_6,ID_ins_25_21,ID_ins_20_16,ID_ins_15_11,EX_ins_25_21,EX_ins_20_16,EX_ins_15_11,
IDA_ALUOp,EX_ALUOp,IDA_ALUSrc,EX_ALUSrc,IDA_BW,EX_BW,IDA_MemWrite,EX_MemWrite,IDA_RegDst,EX_RegDst,
IDA_MemRead,EX_MemRead,IDA_RegWrite,EX_RegWrite,IDA_MemToReg,EX_MemToReg,clk,rst);
EX_MEM_reg EXMEM(EX_ALUResult,MEM_ALUResult,PT2,MEM_rdt2,EX_Rdest,MEM_Rdest,EX_RegWrite,MEM_RegWrite,EX_BW,MEM_BW,EX_MemWrite,MEM_MemWrite,EX_MemRead,MEM_MemRead,
EX_MemToReg,MEM_MemToReg,clk,rst);
MEM_WB_reg MEMWB(MEM_ALUResult,WB_ALUResult,MEM_ReadData,WB_ReadData,MEM_MemToReg,WB_MemToReg,MEM_Rdest,WB_Rdest,MEM_RegWrite,WB_RegWrite,clk,rst);
Comparator Comp(T3,T4,Zero);
endmodule
