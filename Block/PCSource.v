module PCSource (Branch, Zero, BNE, PCSrc);
input Branch, Zero, BNE;
output PCSrc;

assign PCSrc=(Branch&Zero)|(BNE&(~Zero));

endmodule
 
