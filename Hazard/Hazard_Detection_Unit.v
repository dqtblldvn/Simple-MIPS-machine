module Hazard_Detection_Unit(PCload,IF_ID_Write,ID_EX_Rt,IF_ID_Rt,ControlLoad,ID_EX_MemRead,IF_ID_Rs,rst,BRAL);
input [4:0] ID_EX_Rt,IF_ID_Rt,IF_ID_Rs;
input ID_EX_MemRead,rst,BRAL;
output reg PCload, IF_ID_Write, ControlLoad;


always @(ID_EX_Rt or IF_ID_Rt or IF_ID_Rs or ID_EX_MemRead or BRAL)
begin
 
if ((ID_EX_MemRead) && ((ID_EX_Rt==IF_ID_Rt)|(ID_EX_Rt==IF_ID_Rs)))
begin
	PCload=0; 
	IF_ID_Write=0;
	ControlLoad=0;
end
else if (BRAL)
begin
	PCload=0; 
	IF_ID_Write=0;
	ControlLoad=1;
end
else
begin 
	PCload=1; 
	IF_ID_Write=1;
	ControlLoad=1;
end
end

always @(posedge rst)
begin
	PCload=1;
	IF_ID_Write=1;
	ControlLoad=1;
end

endmodule
