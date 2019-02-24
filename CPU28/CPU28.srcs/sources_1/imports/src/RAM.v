`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/02/19 11:03:53
// Design Name: 
// Module Name: RAM
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


module RAM(
    input wire clk,
    input wire reset,
    input wire store,
    input wire [9: 0] address,
    input wire [31: 0] dataIn,
    output wire [31: 0] dataOut
    );
    parameter RAM_SIZE = 256;
    reg [31: 0] ram[RAM_SIZE-1: 0];
    assign dataOut = ram[address];
    
    integer i;
    initial begin
        for(i = 0; i < RAM_SIZE; i = i+1) begin
            ram[i] <= 0;
        end
    end
    reg [31:0] counter;
    always @(posedge clk) begin
        if (store) begin
            ram[address] <= dataIn;
        end
        if(reset) begin 
            for(counter = 0; counter < RAM_SIZE; counter = counter + 1) begin
                ram[counter] <= 0;
            end
        end
    end
endmodule
