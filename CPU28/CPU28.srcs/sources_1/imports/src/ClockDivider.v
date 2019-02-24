`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/02/19 15:56:07
// Design Name: 
// Module Name: ClockDivider
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


module ClockDivider #(
    parameter DIVIDE = 1000000
    )(
    input wire clock,
    input wire f_sw,
    output reg clockOut = 0
    );
    reg[31: 0] counter = 0;

    always @(posedge clock) begin
        case(f_sw)
            1'b1: clockOut <= ~clockOut;
            1'b0: begin
                if(counter == DIVIDE) begin
                    clockOut <= ~clockOut;
                    counter <= 0;
                end else begin
                    counter <= counter + 1;
                end
            end
        endcase
    end
endmodule
