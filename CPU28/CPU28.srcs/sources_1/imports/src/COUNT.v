`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/02/19 18:43:53
// Design Name: 
// Module Name: COUNT
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


module COUNT(
    input wire reset,
    input wire clk,
    input wire run,
    input wire branch,
    input wire JMP,
    output reg[15: 0] totalCycle = 0,                    //总周期数
    output reg[15: 0] unconditionalJump = 0,            //无条件分支
    output reg[15: 0] conditionalSuccessfulJump = 0     //条件分支成功数目
    );
    always @(posedge clk) begin
        if(reset) begin
            totalCycle <= 0;
            unconditionalJump <= 0;
            conditionalSuccessfulJump <= 0;
        end 
        else if (run && ~reset) begin
            totalCycle <= totalCycle + 1;
            unconditionalJump <= unconditionalJump + JMP;
            conditionalSuccessfulJump <= conditionalSuccessfulJump + branch;
        end 
        else begin
            totalCycle <= totalCycle;
            unconditionalJump <= unconditionalJump;
            conditionalSuccessfulJump <= conditionalSuccessfulJump;
        end
    end
    
endmodule
