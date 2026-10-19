`ifndef MAIN_DECODER_V
`define MAIN_DECODER_V

// Keep all your existing main_decoder module code here




module main_decoder (
    op,zero,Memwrite,Regwrite,ALUsrc,IMMsrc,ALUop
);


//input and output
input zero;
input [6:0] op;
output result,Memwrite,ALUsrc,Regwrite;
output [1:0] IMMsrc , ALUop;

//interium wire
wire branch;
// asssigning 
assign Regwrite = ((op == 7'b0000011) | (op == 7'b0110011) )? 1'b1 :1'b0;
assign Memwrite = (op == 7'b0100011) ? 1'b1 : 1'b0;
assign Resultsrc = (op == 7'b0000011) ? 1'b1 : 1'b0 ;
assign ALUsrc = ((op == 7'b0000011) |  (op == 7'b1000011)) ? 1'b1 : 1'b0;
assign branch = (op == 7'b1100011) ? 1'b1 :1'b0 ;
assign IMMsrc = (op == 7'b0100011) ? 2'b01 : (op == 7'b1100011) ? 2'b10 :2'b00 ;
assign ALUop = (op == 7'b0110011) ? 2'b10 : (op == 7'b1100011) ? 2'b01 :2'b00;

endmodule

`endif 