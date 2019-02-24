`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/02/19 09:17:30
// Design Name: 
// Module Name: PC_sim
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


module PC_sim();
    reg[31: 0] branchPC;
    reg[31: 0] Jaddr;
    reg[31: 0] R1;
    reg jal;
    reg eq;
    reg bne;
    reg beq;
    reg jmp;
    reg jr;
    reg reset;				//rst
    reg clock = 0;				//clk
    reg run;
    wire branch;
    
    reg [31: 0] nextPC;
    wire [31: 0] pc;
    wire [15: 0] totalCycle;					//总周期数
    wire [15: 0] unconditionalJump;			//无条件分支
    wire [15: 0] conditionalSuccessfulJump; 	//条件分支成功数目
    Pc testpc(.branchPC(branchPC), .Jaddr(Jaddr), .R1(R1),
            .jal(jal), .eq(eq), .bne(bne),
            .beq(beq), .jmp(jmp), .jr(jr), .reset(reset),
            .clock(clock), .run(run), .unconditionalJump(unconditionalJump),
            .totalCycle(totalCycle), 
            .conditionalSuccessfulJump(conditionalSuccessfulJump),.pc(pc)
        );

    always #5 clock = ~clock;
    initial begin
        reset = 1;
        nextPC = 0;
        R1 = 16;
        branchPC = 8;
        jal = 0;
        eq = 0;
        bne = 0;
        beq = 0;
        jmp = 0;
        jr = 0;
        clock = 0;                //clk
        run = 1;
        Jaddr = 32'h0c25;
        #50 reset = 0;
        #50 jmp = 1;
        #10 jmp = 0;
        
        #50 eq = 1;
        beq = 1;
        #10 eq = 0;
        beq = 0; 
        
        #50 jr = 1;
        #10 jr = 0;
        
        #50 run = 0;
        #50 reset = 1;
        #10 reset = 0;
        
    end

endmodule
