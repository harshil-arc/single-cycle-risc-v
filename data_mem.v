`ifndef DATA_MEM_V
`define DATA_MEM_V

module data_mem (
    A,WD,RD,clk,rst,WE
);
input [31:0] A,WD;
input clk,rst,WE;
output [31:0] RD;

reg [31:0] data_mem [1023:0];

// 

assign RD = (WE == 1'b0) ? data_mem[A] : 32'h00000000;

always @(posedge clk) begin
    if(WE)begin
        data_mem[A] <= WD;
    end
end

endmodule

`endif