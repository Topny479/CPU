`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/02/20 09:14:52
// Design Name: 
// Module Name: LEDdata_Store
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


module LEDdata_Store(
    input wire rst,
    input wire clk,
    input wire DisplayEn,
    input wire[31:0] DisplayData,
    output reg[31:0] LEDdata
    );
    always @(posedge clk) begin
        if(rst) begin
            LEDdata <= 0;
        end
        if(DisplayEn) begin
            LEDdata <= DisplayData;
        end
    end
endmodule
