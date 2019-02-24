`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/02/19 11:26:57
// Design Name: 
// Module Name: PC
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


module PC(
    input wire[31: 0] branchPC,
    input wire[31: 0] Jaddr,
    input wire[31: 0] R1_out,
    input wire reset,
    input wire clock,
    input wire run,
    input wire branch,
    input wire JR,
    input wire JMP,
    output wire[31:0] nextPC,
    output reg[31: 0] PC
    );

    wire [31:0] Branch_MUXout;
    wire [31:0] JR_MUXout;
    wire [31:0] JMP_MUXout;

    initial begin
        PC = 32'h00003000;
    end
    assign nextPC = PC + 4;
    
    always @(posedge clock) begin   //clk,rst,run
        if(reset) begin
            PC <= 32'h00003000;
        end 
        else if (run && ~reset) begin
            PC <= JMP_MUXout;
        end
    end
    
    mux2_1_32bit Branch_MUX(
        .a(nextPC),
        .b(branchPC),
        .out1(Branch_MUXout),
        .sel(branch)
    );
    
    mux2_1_32bit JR_MUX(
        .a(Jaddr),
        .b(R1_out),
        .out1(JR_MUXout),
        .sel(JR)
    );
    
    mux2_1_32bit JMP_MUX(
        .a(Branch_MUXout),
        .b(JR_MUXout),
        .out1(JMP_MUXout),
        .sel(JMP)
    );
 
endmodule
