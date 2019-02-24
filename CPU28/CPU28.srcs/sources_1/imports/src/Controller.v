`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/02/19 09:52:21
// Design Name: 
// Module Name: Controller
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


module Controller(
    input wire[5:0] op,
    input wire[5:0] func,
    output wire[3:0] ALU_OP,
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
    reg[18:0] result;
    
    ALU_Controller alu_contr(
        .op(op), .func(func), .ALU_OP(ALU_OP)
    );
    Sig_Gen sig_gen(
        .op(op), .func(func),
        .MemToReg(MemToReg), .MemWrite(MemWrite), .AluSrcB(AluSrcB), .RegWrite(RegWrite), 
        .Syscall(Syscall), .SignExt(SignExt), .RegDst(RegDst), .Beq(Beq), .Bne(Bne),
        .JR(JR), .JMP(JMP), .JAL(JAL), .SRLV(SRLV), .LBU(LBU), .BGTZ(BGTZ)
        );
    
    
    /*
    assign ALU_OP = result[18:15];
    assign MemToReg = result[14];
    assign MemWrite = result[13];
    assign AluSrcB = result[12];
    assign RegWrite = result[11];
    assign Syscall = result[10];
    assign SignExt = result[9];
    assign RegDst = result[8];
    assign Beq = result[7];
    assign Bne = result[6];
    assign JR = result[5];
    assign JMP = result[4];
    assign JAL = result[3];
    assign SRLV = result[2];
    assign LHU = result[1];
    assign BGTZ = result[0];
    
    always @(op,func) begin
        if(op) begin
            case(op)
            6'b000010: result = 19'b0000_0000000_00_010_000; // j
            6'b000011: result = 19'b0000_0001000_00_011_000; // jal
            6'b000100: result = 19'b0000_0000000_10_000_000; // beq  
            6'b000101: result = 19'b0000_0000000_01_000_000; // bne
            6'b001000: result = 19'b0101_0011010_00_000_000; // addi
            6'b001100: result = 19'b0111_0011000_00_000_000; // andi
            6'b001001: result = 19'b0101_0011010_00_000_000; // addiu
            6'b001010: result = 19'b1011_0011010_00_000_000; // slti
            6'b001101: result = 19'b1000_0011000_00_000_000; // ori  
            6'b100011: result = 19'b0101_1011010_00_000_000; // lw
            6'b101011: result = 19'b0101_0110010_00_000_000; // sw  
            6'b001011: result = 19'b1100_0011000_00_000_000; //sltiu
            6'b100101: result = 19'b0101_1011010_00_000_010; //lhu
            6'b000111: result = 19'b1011_0000000_00_000_001; //bgtz
            default  : result = 19'b0000_0000000_00_000_000;  
            endcase
        end
        else begin
            case (func)  
            6'b000000: result = 19'b0000_0001001_00_000_000; // sll
            6'b000011: result = 19'b0001_0001001_00_000_000; // sra  
            6'b000010: result = 19'b0010_0001001_00_000_000; // srl  
            6'b100000: result = 19'b0101_0001001_00_000_000; // add  
            6'b100001: result = 19'b0101_0001001_00_000_000; // addu
            6'b100010: result = 19'b0110_0001001_00_000_000; // sub 
            6'b100100: result = 19'b0111_0001001_00_000_000; // and  
            6'b100101: result = 19'b1000_0001001_00_000_000; // or  
            6'b100111: result = 19'b1010_0001001_00_000_000; // nor  
            6'b101010: result = 19'b1011_0001001_00_000_000; // slt  
            6'b101011: result = 19'b1100_0001001_00_000_000; // sltu
            6'b001000: result = 19'b0000_0000000_00_110_000; // jr 
            6'b001100: result = 19'b0000_0000100_00_000_000; // syscall
            6'b000110: result = 19'b0010_0001001_00_000_100; // srlv
            default  : result = 19'b0000_0000000_00_000_000; 
            endcase
        end
    end
    */
endmodule
