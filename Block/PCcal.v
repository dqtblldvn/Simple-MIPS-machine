module PCcal(PC_add,ins_25_0,imm_sl2,PCBranch,PCJAL);
input [31:0] PC_add;
input [25:0] ins_25_0;
input [17:0] imm_sl2;
output reg [31:0] PCBranch;
output reg [31:0] PCJAL;

always @(PC_add or ins_25_0 or imm_sl2)
begin
	PCBranch=imm_sl2+PC_add;
	PCJAL={PC_add[31:28],ins_25_0,2'b00};
end
endmodule
