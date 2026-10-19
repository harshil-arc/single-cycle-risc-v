module ALU (
    A,B,ALUcontrol,result,Z,N,V,C
);
input[31:0] A;
input [31:0] B;
input [2:0] ALUcontrol;
output [31:0] result ;
output Z,N,V,C;

//wires

wire [31:0] A_and_B;
wire [31:0] A_or_B;
wire [31:0] not_B;

wire[31:0] mux_1;
wire [31:0] sum;
wire [31:0] mux_2;
wire Cout;
wire [31:0] slt ;
    //logic designing

assign A_and_B = A & B;
assign A_or_B = A|B;
assign not_B = ~B;


//TERNARY OP

assign mux_1 =  (ALUcontrol[0]== 1'b0) ? B : not_B;

//add and sub

assign {Cout,sum} =  A+ mux_1 + ALUcontrol[0];

//asign zero extension
assign slt = {31'b000000000000000000000000000000,sum[31]};

//4 to 1 mux 

assign mux_2 = (ALUcontrol[2:0] == 3'b000) ? sum :
                (ALUcontrol[2:0] == 3'b001) ? sum :
                (ALUcontrol[2:0] == 3'b010) ? A_and_B :
                (ALUcontrol[2:0] == 3'b011) ? A_or_B :
                (ALUcontrol[2:0] == 3'b101) ? slt : 32'h00000000    ;
                 
                
assign result = mux_2;

//assigning flags Z,N,V,C

assign Z =  &(~result);
assign N = result[31];;
assign V= Cout & (ALUcontrol[1] );
assign C = ~(ALUcontrol[1]) &  (A[31]^ sum[31]) & (~(ALUcontrol[0] ^ A[31] ^ B[31]) );



endmodule