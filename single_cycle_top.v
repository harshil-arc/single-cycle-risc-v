`ifndef SINGLE_CYCLE_TOP_V
`define SINGLE_CYCLE_TOP_V

`include "ALU_decoder.v"
`include "main_decoder.v"
`include "p_c.v"
`include "instruct_mem.v"
`include "register_files.v"
`include "sign_extend.v"
`include "ALU.v"
`include "control_unit_top.v"
`include "data_mem.v"
`include "pc_adder.v"

module single_cycle_top (
    clk,rst
);

input clk,rst;

wire [31:0] pc_top, RD_instr, RD1_top, RD2_top, imm_extend_top, ALU_result, read_data, pcplus4;
wire [31:0] SrcB, Result;
wire [2:0]  ALU_control_top;
wire [1:0]  imm_src;
wire        reg_write, alu_src, mem_write, result_src, branch;
wire        zero, negative, overflow, carry;

pc pc (
    .clk(clk),
    .rst(rst),
    .pc(pc_top),
    .pc_next(pcplus4)
);

pc_adder pc_adder (
    .a(pc_top),
    .b(32'd4),
    .c(pcplus4)
);

instr_mem instr_mem (
    .rst(rst),
    .A(pc_top),
    .RD(RD_instr)
);

reg_files register_files (
    .A1(RD_instr[19:15]),
    .A2(RD_instr[24:20]),
    .A3(RD_instr[11:7]),
    .WD3(Result),
    .WE3(reg_write),
    .clk(clk),
    .rst(rst),
    .RD1(RD1_top),
    .RD2(RD2_top)
);

sign_extend sign_extend (
    .inn(RD_instr),
    .imm_extend(imm_extend_top)
);

assign SrcB = (alu_src) ? imm_extend_top : RD2_top;

ALU ALU (
    .A(RD1_top),
    .B(SrcB),
    .ALUcontrol(ALU_control_top),
    .result(ALU_result),
    .Z(zero),
    .N(negative),
    .V(overflow),
    .C(carry)
);

Control_Unit_Top control_unit_top (
    .Op(RD_instr[6:0]),
    .RegWrite(reg_write),
    .ImmSrc(imm_src),
    .ALUSrc(alu_src),
    .MemWrite(mem_write),
    .ResultSrc(result_src),
    .Branch(branch),
    .funct3(RD_instr[14:12]),
    .funct7(RD_instr[31:25]),
    .ALUControl(ALU_control_top)
);

data_mem data_mem (
    .A(ALU_result),
    .WD(RD2_top),
    .RD(read_data),
    .clk(clk),
    .rst(rst),
    .WE(mem_write)
);

assign Result = (result_src) ? read_data : ALU_result;

endmodule

`endif