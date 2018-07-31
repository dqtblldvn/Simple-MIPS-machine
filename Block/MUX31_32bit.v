module MUX31_32bit(in0,in1,in2,ctrl,out);
parameter Nob=32; 
input [Nob-1:0] in0;
input [Nob-1:0] in1;
input [Nob-1:0] in2;
input [1:0] ctrl;
output reg [Nob-1:0] out;

always @(ctrl or in0 or in1 or in2)
begin
case (ctrl)
2'b00: out=in0;
2'b01: out=in1;
2'b10: out=in2;
endcase
end

endmodule
