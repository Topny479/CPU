`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/02/19 15:53:46
// Design Name: 
// Module Name: CLK
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


module CLK(
    input wire clk_in,
    output wire clk_out,
    input wire f_sw
    );
    ClockDivider clk_div(.clock(clk_in), .clockOut(clk_out), .f_sw(f_sw));
    //wire clk_temp;
    //ClockDivider fir_div(.clock(clk_in), .clockOut(clk_temp));
    //ClockDivider sec_div(.clock(clk_temp), .clockOut(clk_out));
endmodule
