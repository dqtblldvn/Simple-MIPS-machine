module ImmediateExtend(imm_in,ZorS,imm_out,imm_sl2);
input [15:0] imm_in;
input ZorS;
output reg [31:0] imm_out;
output reg [17:0] imm_sl2;

always @(imm_in)
begin
	case(ZorS)
	0: imm_out={16'b0000000000000000,imm_in};
	1: begin
		imm_out={imm_in,16'b0000000000000000};
		imm_out=imm_out>>>16;
	end
	endcase
	imm_sl2={imm_in,2'b00};
end

endmodule

