`timescale 10ns / 1ns


/// @brief the pc controller
module PC(
		input wire[31: 0] branchPC,
		input wire[31: 0] Jaddr,
		input wire[31: 0] R1,
		input wire jal,
		input wire eq,
		input wire bne,
		input wire beq,
        input wire jmp,
		input wire jr,
        input wire reset,				//rst
        input wire clock,				//clk
        input wire run,
        output wire[31:0] nextPC,
        output reg[31: 0] pc,
        output reg[15: 0] unconditionalJump,			//无条件分支
        output reg[15: 0] totalCycle,					//总周期数
        output reg[15: 0] conditionalSuccessfulJump 	//条件分支成功数目
    );
	wire [31: 0] stage1;
	wire [31: 0] stage2;
	wire [31: 0] stage3;
	wire branch;

    initial begin
        pc=32'h00003000;
    end
	assign nextPC = pc + 4;
	assign branch = ((eq&&beq) || ((!eq)&&bne));
	
    always @(posedge clock) begin
    //    branch = ((eq&&beq) || ((!eq)&&bne));
		if(reset) begin
		    pc <= 32'h00003000;
			totalCycle <= 16'h0000;
			unconditionalJump <= 16'h0000;
			conditionalSuccessfulJump <= 16'h0000;
		end 
        else if (~reset) begin
            if(run) begin
                pc <= stage3;
                totalCycle <= totalCycle + 1;
                unconditionalJump <= unconditionalJump + (jal || jmp || jr);
                conditionalSuccessfulJump <= conditionalSuccessfulJump + ((eq&&beq) || ((!eq)&&bne));
			end
			else begin
			;
			end
        end 
		else begin
		     ;
			//totalCycle <= totalCycle;
            //unconditionalJump <= unconditionalJump;
            //conditionalSuccessfulJump <= conditionalSuccessfulJump;
		end
    end
    
    mux2_1_32bit UA(.out1(stage1), .a(nextPC), .b(branchPC), .sel(branch));
    
    mux2_1_32bit B(.out1(stage2), .a(stage1), .b(Jaddr), .sel(jmp));
    mux2_1_32bit C(.out1(stage3), .a(stage2), .b(R1), .sel(jr));
endmodule

module testPC(input clk, output reg [31:0] pc);
    initial begin
    pc=0;
    end
    always @(clk) begin
    pc = pc+4;
    end
endmodule
