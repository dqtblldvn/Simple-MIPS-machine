module IF_ID_reg(IF_ID_Write,PCaddin,clk,PCaddout,rst,ins5_0in,ins5_0out,ins31_26in,ins31_26out,ins25_21in,ins25_21out,ins20_16in,ins20_16out,
ins15_11in,ins15_11out,ins25_0in,ins25_0out,ins10_6in,ins10_6out,ins15_0in,ins15_0out,flush,ins_26in,ins_26out,BRAL);
input [31:0]PCaddin;
input [5:0] ins5_0in,ins31_26in;
input [4:0] ins25_21in,ins20_16in,ins15_11in,ins10_6in;
input [25:0] ins25_0in;
input [15:0] ins15_0in;
output reg [5:0] ins31_26out,ins5_0out;
output reg [4:0] ins25_21out,ins20_16out,ins15_11out,ins10_6out;
output reg [25:0] ins25_0out;
output reg [15:0] ins15_0out;
input IF_ID_Write,clk,rst,flush,ins_26in,BRAL;
output reg [31:0] PCaddout;
output reg ins_26out;


always @(posedge clk) begin
if ((rst)|(flush)|(BRAL)) begin
PCaddout=32'h00000000;
ins5_0out=6'b000000;
ins31_26out=6'b000000;
ins25_21out=5'b00000;
ins20_16out=5'b00000;
ins15_11out=5'b00000;
ins10_6out=5'b00000;
ins25_0out=26'b00000000000000000000000000;
ins15_0out=16'b0000000000000000;
ins_26out=0;
end
else
if (IF_ID_Write) begin
PCaddout=PCaddin;
ins5_0out=ins5_0in;
ins31_26out=ins31_26in;
ins25_21out=ins25_21in;
ins20_16out=ins20_16in;
ins15_11out=ins15_11in;
ins10_6out=ins10_6in;
ins25_0out=ins25_0in;
ins15_0out=ins15_0in;
ins_26out=ins_26in;
end
end

endmodule

