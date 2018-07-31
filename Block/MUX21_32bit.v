module MUX21_32bit(in0,in1,ctrl,out);
parameter Nob=32; 
input [Nob-1:0] in0;
input [Nob-1:0] in1;
input ctrl;
output reg [Nob-1:0] out;

always @(ctrl or in0 or in1)
begin
out=(ctrl)?in1:in0;
end

endmodule
