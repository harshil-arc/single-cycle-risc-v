module sign_extend (
    inn,imm_extend
);

inout [31:0] inn;
output [31:0]imm_extend;

assign imm_extend =(inn[31]) ?{20{1'b1,inn[31:20]}}:
                    {20{1'b1,inn[31:20]}};
    
endmodule