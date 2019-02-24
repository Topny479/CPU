`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/02/19 10:14:03
// Design Name: 
// Module Name: ALU_Controller
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


module ALU_Controller(
    input wire[5:0] op,
    input wire[5:0] func,
    output wire[3:0] ALU_OP
    );
    
    wire OP5,OP4,OP3,OP2,OP1,OP0;
    wire F5,F4,F3,F2,F1,F0;
    wire S3,S2,S1,S0;
    
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
    assign ALU_OP = {S3,S2,S1,S0};
    
    assign S3=~OP5&~OP4&~OP3&~OP2&~OP1&~OP0&F5&~F4&~F3&F2&~F1&F0 | ~OP5&~OP4&~OP3&~OP2&~OP1&~OP0&F5&~F4&~F3&F2&F1&F0 | ~OP5&~OP4&~OP3&~OP2&~OP1&~OP0&F5&~F4&F3&~F2&F1&~F0 | ~OP5&~OP4&~OP3&~OP2&~OP1&~OP0&F5&~F4&F3&~F2&F1&F0 | ~OP5&~OP4&OP3&~OP2&OP1&~OP0 | ~OP5&~OP4&OP3&OP2&~OP1&OP0 | ~OP5&~OP4&OP3&~OP2&OP1&OP0 | ~OP5&~OP4&~OP3&OP2&OP1&OP0 | ~OP5&~OP4&~OP3&~OP2&~OP1&~OP0&F5&~F4&~F3&F2&F1&~F0 | ~OP5&~OP4&~OP3&OP2&OP1&OP0;
    assign S2=~OP5&~OP4&~OP3&~OP2&~OP1&~OP0&F5&~F4&~F3&~F2&~F1&~F0 | ~OP5&~OP4&~OP3&~OP2&~OP1&~OP0&F5&~F4&~F3&~F2&~F1&F0 | ~OP5&~OP4&~OP3&~OP2&~OP1&~OP0&F5&~F4&~F3&~F2&F1&~F0 | ~OP5&~OP4&~OP3&~OP2&~OP1&~OP0&F5&~F4&~F3&F2&~F1&~F0 | ~OP5&~OP4&~OP3&~OP2&~OP1&~OP0&F5&~F4&F3&~F2&F1&F0 | ~OP5&~OP4&OP3&~OP2&~OP1&~OP0 | ~OP5&~OP4&OP3&OP2&~OP1&~OP0 | ~OP5&~OP4&OP3&~OP2&~OP1&OP0 | OP5&~OP4&~OP3&~OP2&OP1&OP0 | OP5&~OP4&OP3&~OP2&OP1&OP0 | ~OP5&~OP4&OP3&~OP2&OP1&OP0 | OP5&~OP4&~OP3&OP2&~OP1&OP0 | OP5&~OP4&~OP3&OP2&~OP1&~OP0;
    assign S1=~OP5&~OP4&~OP3&~OP2&~OP1&~OP0&~F5&~F4&~F3&~F2&F1&~F0 | ~OP5&~OP4&~OP3&~OP2&~OP1&~OP0&F5&~F4&~F3&~F2&F1&~F0 | ~OP5&~OP4&~OP3&~OP2&~OP1&~OP0&F5&~F4&~F3&F2&~F1&~F0 | ~OP5&~OP4&~OP3&~OP2&~OP1&~OP0&F5&~F4&~F3&F2&F1&F0 | ~OP5&~OP4&~OP3&~OP2&~OP1&~OP0&F5&~F4&F3&~F2&F1&~F0 | ~OP5&~OP4&OP3&OP2&~OP1&~OP0 | ~OP5&~OP4&OP3&~OP2&OP1&~OP0 | ~OP5&~OP4&~OP3&~OP2&~OP1&~OP0&~F5&~F4&~F3&F2&F1&~F0 | ~OP5&~OP4&~OP3&OP2&OP1&OP0 | ~OP5&~OP4&~OP3&~OP2&~OP1&~OP0&~F5&~F4&~F3&F2&F1&~F0 | ~OP5&~OP4&~OP3&OP2&OP1&OP0;
    assign S0=~OP5&~OP4&~OP3&~OP2&~OP1&~OP0&~F5&~F4&~F3&~F2&F1&F0 | ~OP5&~OP4&~OP3&~OP2&~OP1&~OP0&F5&~F4&~F3&~F2&~F1&~F0 | ~OP5&~OP4&~OP3&~OP2&~OP1&~OP0&F5&~F4&~F3&~F2&~F1&F0 | ~OP5&~OP4&~OP3&~OP2&~OP1&~OP0&F5&~F4&~F3&F2&~F1&~F0 | ~OP5&~OP4&~OP3&~OP2&~OP1&~OP0&F5&~F4&F3&~F2&F1&~F0 | ~OP5&~OP4&OP3&~OP2&~OP1&~OP0 | ~OP5&~OP4&OP3&OP2&~OP1&~OP0 | ~OP5&~OP4&OP3&~OP2&~OP1&OP0 | ~OP5&~OP4&OP3&~OP2&OP1&~OP0 | OP5&~OP4&~OP3&~OP2&OP1&OP0 | OP5&~OP4&OP3&~OP2&OP1&OP0 | OP5&~OP4&~OP3&OP2&~OP1&OP0 | ~OP5&~OP4&~OP3&OP2&OP1&OP0|~OP5&~OP4&~OP3&~OP2&~OP1&~OP0&F5&~F4&~F3&F2&F1&~F0|OP5&~OP4&~OP3&OP2&~OP1&~OP0|~OP5&~OP4&~OP3&OP2&OP1&OP0;

endmodule
