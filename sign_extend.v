`ifndef SIGN_EXTEND_V
`define SIGN_EXTEND_V

module sign_extend (
    inn,imm_extend
);

input [31:0] inn;
output [31:0] imm_extend;

assign imm_extend = {{20{inn[31]}}, inn[31:20]};
    
endmodule

`endif