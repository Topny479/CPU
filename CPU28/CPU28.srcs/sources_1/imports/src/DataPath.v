`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/02/19 09:30:22
// Design Name: 
// Module Name: DataPath
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

module DataPath(
        input clk100Mhz,
        input rst,
        input GO,
        input mod_opt,
        //output wire [15: 0] totalCycle,output wire [15: 0] unconditionalJump,output wire [15: 0] conditionalSuccessfulJump,
        //output wire[31:0] PC, output wire[31:0] instr,
        output wire [7:0] seg,		
        output wire [7:0] an,
        input wire f_sw
    );
    
    /*/////////////////////接口定义*********************/
    
    //CLK
    wire clk1hz;
    //IM
    wire[31:0] instr;   //指令
    //Controller
    wire[4:0] rs;
    wire[4:0] rt;
    wire[4:0] rd;
    wire [4:0]shamt;
    wire[5:0] OP;
    wire[5:0] Func;
    //Signal
    wire MemToReg;
    wire Memwrite;
    wire AluSrcB;
    wire RegWrite;
    wire Syscall;
    wire SignExt;
    wire RegDst;
    wire Beq;
    wire Bne;
    wire JR;
    wire JMP;
    wire JAL;
    wire SRLV;
    wire LBU;
    wire BGTZ;
    wire[3:0] AluOP;
    //PC
    wire[31: 0] branchPC;
    wire[31: 0] Jaddr;
    wire[31:0] nextPC;
    wire[31:0] PC;
    wire eq34;
    wire run;
    wire branch;
    //COUNT
    wire [15: 0] totalCycle;                    //总周期数
    wire [15: 0] unconditionalJump;             //无条件分支
    wire [15: 0] conditionalSuccessfulJump;     //条件分支成功数目
    //DISPLAY
    wire DisplayEn;
    wire [31:0] DisplayData;
    wire [31:0] LEDdata;
    //Reg
    wire [4:0] R1_in;
    wire [31:0] R1_out;
    wire [4:0] R2_in;
    wire [31:0] R2_out;
    //ALU
    wire Equal;
    wire les;
    wire [1:0]Bytesel;
    wire [31:0]Result1;
    wire [31:0]Result2;
    //RAM
    wire[9:0]Ram_addr;
    wire [31:0]Ram_out;
    //MUX
    wire [7:0] Byte; 
    wire [31:0] SignExt_MUXout;
    wire [31:0] AluSrcB_MUXout;
    wire [4:0] RegDst_MUXout;
    wire [4:0] W_MUXout;
    wire [31:0] Reg_Din_MUXout;
    wire [31:0] LBU_Din_MUXout;
    wire [31:0] ByteEx;
    wire [4:0] Shamt_MUXout;
    wire [31:0] Half_MUXout;
    wire [31:0] LBU_MUXout;
    wire [31:0] MemToReg_MUXout;
    /*********************接口定义////////////////*/

    //分频
    //assign clk1hz = clk100Mhz;
    CLK clk(
    .clk_in(clk100Mhz),
    .clk_out(clk1hz),
    .f_sw(f_sw)
    );
    
    //**********IM数据通路部分************
    Rom IM(
        .address(PC),
        .result(instr)
    );
     //**********IM数据通路部分************
    
    //**********控制器数据通路部分************
        //指令分线
        assign rs = instr[25:21];
        assign rt = instr[20:16];
        assign rd = instr[15:11];
        assign shamt = instr[10:6];
        assign OP = instr[31:26];
        assign Func = instr[5:0];
        
        Controller controller(
                .op(OP), .func(Func), .ALU_OP(AluOP),
                .MemToReg(MemToReg), .MemWrite(Memwrite), .AluSrcB(AluSrcB), .RegWrite(RegWrite), 
                .Syscall(Syscall), .SignExt(SignExt), .RegDst(RegDst), .Beq(Beq), .Bne(Bne),
                .JR(JR), .JMP(JMP), .JAL(JAL), .SRLV(SRLV), .LBU(LBU), .BGTZ(BGTZ)
                );
    //**********控制器数据通路部分结束************ 
    
    
    //**********PC数据通路部分************
        mux2_1_32bit SignExt_MUXoutMUX(
            .a({16'h0000 , instr[15:0]}),
            .b({{16{instr[15]}} , instr[15:0]}), //符号扩展
            .out1(SignExt_MUXout),
            .sel(SignExt)
        );
        
        assign branchPC = nextPC + ( ({{16{instr[15]}} , instr[15:0]}) << 2 );
        assign Jaddr = {nextPC[31:28], instr[25:0], 2'b00};
    
        assign eq34 = (R1_out == 32'h00000022);
        assign run = GO || ~Syscall || eq34;
        assign branch = (Bne & ~Equal) | (Beq & Equal) | (BGTZ & (~Equal & ~les));
        assign ByteEx = {24'b00000000, Byte};
    
        PC pc(
            .branchPC(branchPC),
            .Jaddr(Jaddr),
            .R1_out(R1_out),
            .reset(rst),
            .clock(clk1hz),
            .run(run),
            .branch(branch),
            .JR(JR),
            .JMP(JMP),
            .nextPC(nextPC),
            .PC(PC)
        );
        //**********PC数据通路部分结束************
    
        //**********COUNT数据通路部分************
        COUNT count(
            .reset(rst),
            .clk(clk1hz),
            .run(run),
            .branch(branch),
            .JMP(JMP),
            .totalCycle(totalCycle),                         //总周期数
            .unconditionalJump(unconditionalJump),           //无条件分支
            .conditionalSuccessfulJump(conditionalSuccessfulJump)    //条件分支成功数目
        );
        //**********COUNT数据通路部分结束************
        
        //**********DISPLAY数据通路部分************
        assign DisplayEn = eq34 & Syscall;
        assign DisplayData = R2_out;
        
        LEDdata_Store Ld_str(
            .rst(rst),
            .clk(clk1hz),
            .DisplayEn(DisplayEn),
            .DisplayData(DisplayData),
            .LEDdata(LEDdata)
        );
        
        Display display(
            .clk(clk100Mhz),
            .mod_opt(mod_opt),
            .LEDdata(LEDdata),
            .totalCycle(totalCycle),
            .unconditionalJump(unconditionalJump),
            .conditionalSuccessfulJump(conditionalSuccessfulJump),
            .seg(seg),
            .an(an)
        );
        //**********DISPLAY数据通路部分结束************
        
        //**********Reg数据通路部分***********
        //选择得到R1# / R2#  
        mux2_1_5bit R1addr_MUX (
        .a(rs),
        .b(5'h02),
        .out1(R1_in),
        .sel(Syscall)
        );
        mux2_1_5bit R2addr_MUX (
        .a(rt),
        .b(5'h04),
        .out1(R2_in),
        .sel(Syscall)
        );
        //选择得到rt/rd
        mux2_1_5bit RegDst_MUX (
        .a(rt),
        .b(rd),
        .out1(RegDst_MUXout),
        .sel(RegDst)
        );
        //选择得到W#
        mux2_1_5bit Waddr_MUX (
        .a(RegDst_MUXout),
        .b(5'h1f),
        .out1(W_MUXout),
        .sel(JAL)
        );
        
        //选择得到Reg_Din
        mux2_1_32bit Reg_Din_MUX (
        .a(MemToReg_MUXout),
        .b(nextPC),
        .out1(Reg_Din_MUXout),
        .sel(JAL)
        );
        
        mux2_1_32bit LBU_Din_MUX (
        .a(Reg_Din_MUXout),
        .b(ByteEx),
        .out1(LBU_Din_MUXout),
        .sel(LBU)
        );        
        
        //将上述选择得到的信号输入到Reg
        RegFile regFile(
        .clk(clk1hz),
        .writeData(LBU_Din_MUXout),
        .writeEnable(RegWrite),
        .regWrite(W_MUXout),
        .regA(R1_in),
        .regB(R2_in),
        .resultA(R1_out),
        .resultB(R2_out)
        );
        //**********Reg数据通路部分结束************
    
    
        //**********ALU/DM数据通路部分************
        //选择SrcB
        mux2_1_32bit AluSrcB_MUX(
            .a(R2_out),
            .b(SignExt_MUXout),
            .out1(AluSrcB_MUXout),
            .sel(AluSrcB)
        );
        //选择shamt
        mux2_1_5bit Shamt_MUX(
            .a(shamt),
            .b(R1_out[4:0]),
            .out1(Shamt_MUXout),
            .sel(SRLV)
        );
        ALU alu(
            .x(R1_out),
            .y(AluSrcB_MUXout),
            .alu_op(AluOP),
            .shamt(Shamt_MUXout),
            .equal(Equal),
            .result1(Result1),
            .result2(Result2)
        );
        //DM
        assign Ram_addr = Result1[11:2];
        assign Bytesel = Result1[1:0];
        assign les = Result1[0];
        RAM dataMem(
            .clk(clk1hz),
            .reset(rst),
            .store(Memwrite),
            //.ld(~Memwrite),
            .address(Ram_addr),
            .dataIn(R2_out),
            .dataOut(Ram_out)
        );
        //MemToReg
        mux2_1_32bit  Half_MUX(
            .a({16'h0000 , Ram_out[15:0]}),
            .b({16'h0000 , Ram_out[31:16]}),
            .out1(Half_MUXout),
            .sel(Result1[1])
        );
        
        mux4_1_8bit  Byte_MUX(
            .a(MemToReg_MUXout[7:0]),
            .b(MemToReg_MUXout[15:8]),
            .c(MemToReg_MUXout[23:16]),
            .d(MemToReg_MUXout[31:24]),
            .out1(Byte),
            .sel(Bytesel)
        );
        
        mux2_1_32bit MemToReg_MUX(
            .a(Result1),
            .b(Ram_out),
            .out1(MemToReg_MUXout),
            .sel(MemToReg)
        );
        //**********ALU/DM数据通路部分结束************
endmodule
