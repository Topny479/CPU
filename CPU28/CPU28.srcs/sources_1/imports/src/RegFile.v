`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/02/18 20:27:36
// Design Name: 
// Module Name: RegFile
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


module RegFile(
    input wire clk,
    input wire[31: 0] writeData,
    input wire writeEnable,
    input wire[4: 0] regWrite,
    input wire[4: 0] regA,
    input wire[4: 0] regB,
    output wire[31: 0] resultA,
    output wire[31: 0] resultB
    );
    reg[31: 0] regfile[31: 0];
    
    integer i;
    initial begin
        for(i = 0; i < 32; i = i + 1) begin
            regfile[i] = 0;
        end
    end
    
    always @ (posedge clk) begin    //posedge
        if (writeEnable && regWrite != 0) begin
            regfile[regWrite] <= writeData;
        end
    end
    
    assign resultA = (regA == 0) ? 0 : regfile[regA];
    assign resultB = (regB == 0) ? 0 : regfile[regB];
endmodule
