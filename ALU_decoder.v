`ifndef ALU_DECODER_V
`define ALU_DECODER_V

// Keep all your existing ALU_decoder module code here



module ALU_decoder (
    op5,funct3,funct7,ALUop,ALUcontrol
);

//input and output

input op5 , funct7;
input[2:0] funct3;
output [2:0] ALUcontrol;


// interium wire

wire [1:0] concatination;

//assigning

assign concatination = {op5, funct7};
 

assign ALUcontrol = (ALUop == 2'b00)? 3'b000 :
                    (ALUop == 2'b01)? 3'b001 :
                    (ALUop == 2'b10) & (funct3 == 3'b010) ? 3'b101 :
                    (ALUop == 2'b10) & (funct3 == 3'b110) ? 3'b011 :
                    (ALUop == 2'b10) & (funct3 == 3'b111) ? 3'b010 :
                    (ALUop == 2'b10) & (funct3 == 3'b000 ) & (concatination == 2'b11) ? 3'b001 : 
                    (ALUop == 2'b10) & (funct3 == 3'b000 ) & (concatination != 2'b11) ? 3'b000 : 3'b000 ;
endmodule


`endif