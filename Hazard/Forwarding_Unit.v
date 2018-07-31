module Forwarding_Unit(EX_MEM_Rd,ID_EX_Rs,ID_EX_Rt,MEM_WB_Rd,EX_MEM_regW,MEM_WB_regW,forward_a,forward_b,
			IF_ID_Rs,IF_ID_Rt,ID_EX_Rdest,forward_c,forward_d);
input[4:0] EX_MEM_Rd, ID_EX_Rs , ID_EX_Rt, MEM_WB_Rd, IF_ID_Rs,IF_ID_Rt,ID_EX_Rdest;
input 		EX_MEM_regW, MEM_WB_regW; 
output reg[1:0] forward_a, forward_b,forward_c,forward_d;

//Forward A
always @(EX_MEM_regW or EX_MEM_Rd or ID_EX_Rs or MEM_WB_regW or MEM_WB_Rd) 
begin
	
	if((EX_MEM_regW) && (EX_MEM_Rd != 5'b00000) && (EX_MEM_Rd == ID_EX_Rs))
		forward_a = 2'b10;
	else if((MEM_WB_regW) && (MEM_WB_Rd != 5'b00000) && (MEM_WB_Rd == ID_EX_Rs) && ((EX_MEM_Rd != ID_EX_Rs))|(EX_MEM_regW==0))
		forward_a = 2'b01;
	else forward_a = 2'b00;
end
//Forward B
always @(EX_MEM_regW or EX_MEM_Rd or ID_EX_Rt or MEM_WB_regW or MEM_WB_Rd) 
begin
	if((EX_MEM_regW) && (EX_MEM_Rd != 5'b00000) && (EX_MEM_Rd == ID_EX_Rt)) 
		forward_b = 2'b10;
	else if((MEM_WB_regW) && (MEM_WB_Rd != 5'b00000) && (MEM_WB_Rd == ID_EX_Rt) && ((EX_MEM_Rd != ID_EX_Rt)|(EX_MEM_regW==0)))
		forward_b = 2'b01;
	else forward_b = 2'b00;
end


//Forward C
always @(EX_MEM_Rd or IF_ID_Rs or ID_EX_Rdest) 
begin
	
	if((ID_EX_Rdest != 5'b00000) && (ID_EX_Rdest == IF_ID_Rs))
		forward_c = 2'b10;
	else if((EX_MEM_Rd != 5'b00000) && (EX_MEM_Rd == IF_ID_Rs) && (ID_EX_Rdest != IF_ID_Rs))
		forward_c = 2'b01;
	else forward_c = 2'b00;
end

//Forward D
always @(EX_MEM_Rd or IF_ID_Rt or ID_EX_Rdest) 
begin
	
	if((ID_EX_Rdest != 5'b00000) && (ID_EX_Rdest == IF_ID_Rt))
		forward_d = 2'b10;
	else if((EX_MEM_Rd != 5'b00000) && (EX_MEM_Rd == IF_ID_Rt) && (ID_EX_Rdest != IF_ID_Rt))
		forward_d = 2'b01;
	else forward_d = 2'b00;
end

endmodule

