`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/02/19 10:39:50
// Design Name: 
// Module Name: Sig_Gen
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Sig_Gen(
    input wire[5:0] op,
    input wire[5:0] func,
    output wire MemToReg,
    output wire MemWrite,
    output wire AluSrcB,
    output wire RegWrite,
    output wire Syscall,
    output wire SignExt,
    output wire RegDst,
    output wire Beq,
    output wire Bne,
    output wire JR,
    output wire JMP,
    output wire JAL,
    output wire SRLV,
    output wire LBU,
    output wire BGTZ
    );
    wire OP5,OP4,OP3,OP2,OP1,OP0;
    wire F5,F4,F3,F2,F1,F0;
    assign OP5 = op[5];
    assign OP4 = op[4];
    assign OP3 = op[3];
    assign OP2 = op[2];
    assign OP1 = op[1];
    assign OP0 = op[0];
    assign F5 = func[5];
    assign F4 = func[4];
    assign F3 = func[3];
    assign F2 = func[2];
    assign F1 = func[1];
    assign F0 = func[0];
    
    assign MemToReg=OP5&~OP4&~OP3&~OP2&OP1&OP0 | OP5&~OP4&~OP3&OP2&~OP1&OP0 | OP5&~OP4&~OP3&OP2&~OP1&~OP0;
    assign MemWrite=OP5&~OP4&OP3&~OP2&OP1&OP0;
    assign AluSrcB=~OP5&~OP4&OP3&~OP2&~OP1&~OP0 | ~OP5&~OP4&OP3&OP2&~OP1&~OP0 | ~OP5&~OP4&OP3&~OP2&~OP1&OP0 | ~OP5&~OP4&OP3&~OP2&OP1&~OP0 | ~OP5&~OP4&OP3&OP2&~OP1&OP0 | OP5&~OP4&~OP3&~OP2&OP1&OP0 | OP5&~OP4&OP3&~OP2&OP1&OP0 | ~OP5&~OP4&OP3&~OP2&OP1&OP0 | OP5&~OP4&~OP3&OP2&~OP1&OP0 | OP5&~OP4&~OP3&OP2&~OP1&~OP0;
    assign RegWrite=~OP5&~OP4&~OP3&~OP2&~OP1&~OP0&~F5&~F4&~F3&~F2&~F1&~F0 | ~OP5&~OP4&~OP3&~OP2&~OP1&~OP0&~F5&~F4&~F3&~F2&F1&F0 | ~OP5&~OP4&~OP3&~OP2&~OP1&~OP0&~F5&~F4&~F3&~F2&F1&~F0 | ~OP5&~OP4&~OP3&~OP2&~OP1&~OP0&F5&~F4&~F3&~F2&~F1&~F0 | ~OP5&~OP4&~OP3&~OP2&~OP1&~OP0&F5&~F4&~F3&~F2&~F1&F0 | ~OP5&~OP4&~OP3&~OP2&~OP1&~OP0&F5&~F4&~F3&~F2&F1&~F0 | ~OP5&~OP4&~OP3&~OP2&~OP1&~OP0&F5&~F4&~F3&F2&~F1&~F0 | ~OP5&~OP4&~OP3&~OP2&~OP1&~OP0&F5&~F4&~F3&F2&~F1&F0 | ~OP5&~OP4&~OP3&~OP2&~OP1&~OP0&F5&~F4&~F3&F2&F1&F0 | ~OP5&~OP4&~OP3&~OP2&~OP1&~OP0&F5&~F4&F3&~F2&F1&~F0 | ~OP5&~OP4&~OP3&~OP2&~OP1&~OP0&F5&~F4&F3&~F2&F1&F0 | ~OP5&~OP4&~OP3&~OP2&OP1&OP0 | ~OP5&~OP4&OP3&~OP2&~OP1&~OP0 | ~OP5&~OP4&OP3&OP2&~OP1&~OP0 | ~OP5&~OP4&OP3&~OP2&~OP1&OP0 | ~OP5&~OP4&OP3&~OP2&OP1&~OP0 | ~OP5&~OP4&OP3&OP2&~OP1&OP0 | OP5&~OP4&~OP3&~OP2&OP1&OP0 | ~OP5&~OP4&~OP3&~OP2&~OP1&~OP0&~F5&~F4&~F3&F2&F1&~F0 | ~OP5&~OP4&OP3&~OP2&OP1&OP0 | OP5&~OP4&~OP3&OP2&~OP1&OP0 | OP5&~OP4&~OP3&OP2&~OP1&~OP0 | ~OP5&~OP4&~OP3&~OP2&~OP1&~OP0&~F5&~F4&~F3&F2&F1&~F0 | ~OP5&~OP4&~OP3&~OP2&~OP1&~OP0&F5&~F4&~F3&F2&F1&~F0;
    assign Syscall=~OP5&~OP4&~OP3&~OP2&~OP1&~OP0&~F5&~F4&F3&F2&~F1&~F0;
    assign SignExt=~OP5&~OP4&OP3&~OP2&~OP1&~OP0 | ~OP5&~OP4&OP3&~OP2&~OP1&OP0 | ~OP5&~OP4&OP3&~OP2&OP1&~OP0 | OP5&~OP4&~OP3&~OP2&OP1&OP0 | OP5&~OP4&OP3&~OP2&OP1&OP0 | OP5&~OP4&~OP3&OP2&~OP1&OP0 | ~OP5&~OP4&OP3&~OP2&OP1&OP0 | OP5&~OP4&~OP3&OP2&~OP1&~OP0;
    assign RegDst=~OP5&~OP4&~OP3&~OP2&~OP1&~OP0&~F5&~F4&~F3&~F2&~F1&~F0 | ~OP5&~OP4&~OP3&~OP2&~OP1&~OP0&~F5&~F4&~F3&~F2&F1&F0 | ~OP5&~OP4&~OP3&~OP2&~OP1&~OP0&~F5&~F4&~F3&~F2&F1&~F0 | ~OP5&~OP4&~OP3&~OP2&~OP1&~OP0&F5&~F4&~F3&~F2&~F1&~F0 | ~OP5&~OP4&~OP3&~OP2&~OP1&~OP0&F5&~F4&~F3&~F2&~F1&F0 | ~OP5&~OP4&~OP3&~OP2&~OP1&~OP0&F5&~F4&~F3&~F2&F1&~F0 | ~OP5&~OP4&~OP3&~OP2&~OP1&~OP0&F5&~F4&~F3&F2&~F1&~F0 | ~OP5&~OP4&~OP3&~OP2&~OP1&~OP0&F5&~F4&~F3&F2&~F1&F0 | ~OP5&~OP4&~OP3&~OP2&~OP1&~OP0&F5&~F4&~F3&F2&F1&F0 | ~OP5&~OP4&~OP3&~OP2&~OP1&~OP0&F5&~F4&F3&~F2&F1&~F0 | ~OP5&~OP4&~OP3&~OP2&~OP1&~OP0&F5&~F4&F3&~F2&F1&F0 | ~OP5&~OP4&~OP3&~OP2&~OP1&~OP0&~F5&~F4&~F3&F2&F1&~F0|~OP5&~OP4&~OP3&~OP2&~OP1&~OP0&~F5&~F4&~F3&F2&F1&~F0|~OP5&~OP4&~OP3&~OP2&~OP1&~OP0&F5&~F4&~F3&F2&F1&~F0;
    assign Beq=~OP5&~OP4&~OP3&OP2&~OP1&~OP0;
    assign Bne=~OP5&~OP4&~OP3&OP2&~OP1&OP0;
    assign JR=~OP5&~OP4&~OP3&~OP2&~OP1&~OP0&~F5&~F4&F3&~F2&~F1&~F0;
    assign JMP=~OP5&~OP4&~OP3&~OP2&~OP1&~OP0&~F5&~F4&F3&~F2&~F1&~F0 | ~OP5&~OP4&~OP3&~OP2&OP1&~OP0 | ~OP5&~OP4&~OP3&~OP2&OP1&OP0;
    assign JAL=~OP5&~OP4&~OP3&~OP2&OP1&OP0;
    assign SRLV=~OP5&~OP4&~OP3&~OP2&~OP1&~OP0&~F5&~F4&~F3&F2&F1&~F0;
    assign LBU=OP5&~OP4&~OP3&OP2&~OP1&~OP0;
    assign BGTZ=~OP5&~OP4&~OP3&OP2&OP1&OP0;
    
endmodule
