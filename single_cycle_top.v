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


wire[31:0] pc_top,RD_instr , RD1_top, imm_extend_top ,ALU_control_top , ALU_result ,read_data ,pcplus4;
wire reg_write;
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
    .A2(),
    .A3(inn[11:7]),
    .WD3(read_data),
    .WE3(),
    .clk(clk),
    .rst(rst ),
    .RD1(),
    .RD2()
);

sign_extend sign_extend (
   
    .inn(RD_instr),
    .imm_extend(imm_extend_top)
);

ALU ALU (
     .A(RD1_top),
     .B(imm_extend_top),
     .ALUcontrol(ALU_control_top),.result(),.Z(),.N(),.V(),.C()
);

Control_Unit_Top control_unit_top (
    .Op(RD_instr[6:0]),
    .RegWrite(reg_write),
     .ImmSrc(), .ALUSrc(), .MemWrite(), .ResultSrc(), .Branch(), .funct3(RD_instr[14:12]), .funct7(), .ALUControl(ALU_control_top));

data_mem data_mem (
    .A(ALU_result),
    .WD(),
    .RD(read_data),
    .clk(clk),
    .rst(rst),
    .WE()
);
endmodule