`ifndef INSTRUCT_MEM_V
`define INSTRUCT_MEM_V

module instr_mem (A,rst,RD);
input [31:0] A;
input rst;
output [31:0] RD; 

//creation of memory
reg [31:0] mem [1023:0]; 

assign RD = (rst == 1'b0) ? 32'h00000000 : mem[A];
endmodule

`endif