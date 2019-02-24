`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/02/18 19:48:05
// Design Name: 
// Module Name: ALU
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


module ALU(
    input wire[31:0] x,
    input wire[31:0] y,
    input wire[3:0] alu_op,
    input wire[4:0] shamt,
    output reg[31:0] result1 = 0,
    output reg[31:0] result2 = 0,
    output wire equal
    );
    
    assign equal = (x == y);
    
    always @(x, y, shamt, alu_op) begin
        case(alu_op)
            4'd0: begin
                result1 = y << shamt;
                end
            4'd1: begin
                result1 = y[31] ? ((~(32'hffff_ffff >> shamt)) | (y >> shamt)) : (y >> shamt);
                end
            4'd2: begin
                result1 = y >> shamt;
                end
            4'd3: begin
                result1 = x * y;
                end
            4'd4: begin
                result1 = x / y;
                end
            4'd5: begin
                result1 = x + y;
                end
            4'd6: begin
                result1 = x - y;
                end
            4'd7: begin
                result1 = x & y;
                end
            4'd8: begin
                result1 = x | y;
                end
            4'd9: begin
                result1 = x ^ y;
                end
            4'd10: begin
                result1 = ~(x | y);
                end
            4'd11: begin
                result1 = {31'd0, ($signed(x) < $signed(y))};
                end
            4'd12: begin
                result1 = {31'd0, (x < y)};
                end
            default: begin
                result1 = 0;
                end
        endcase
    end
    
endmodule
