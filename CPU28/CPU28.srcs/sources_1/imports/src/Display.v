`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/02/19 08:31:25
// Design Name: 
// Module Name: Display_model
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


module Display(
	input wire clk,
	input wire mod_opt,						//为1表示显示周期
	input wire[31:0] LEDdata,					//显示数据
	(* DONT_TOUCH = "1" *) input wire[15:0] totalCycle,				//总周期数
	(* DONT_TOUCH = "1" *) input wire[15:0] unconditionalJump,			//无条件分政
	(* DONT_TOUCH = "1" *) input wire[15:0] conditionalSuccessfulJump,//条件分支成功数目
	output reg [7:0] seg,		
	output reg [7:0] an			
    );
	reg [3:0]    data;
	reg [15:0]	cnt_scan;
	
	always@(posedge clk)		//计数器计敿
		begin
			cnt_scan <= cnt_scan+1;
		end
	
	always@(
	    cnt_scan,
	    mod_opt,
	    conditionalSuccessfulJump,
	    unconditionalJump,
	    totalCycle,
        LEDdata
    )begin		//点亮数码箿
		if(mod_opt == 1)	begin
			case(cnt_scan[15:13])
			3'b000:begin 
					data = conditionalSuccessfulJump[3:0];
					an = 8'b11111110;
					end
			3'b001:begin 
					data = conditionalSuccessfulJump[7:4];
					an = 8'b11111101;
					end
			3'b010:begin
					data = conditionalSuccessfulJump[11:8];
					an = 8'b11111011;
					end
			3'b011:begin
					data = unconditionalJump[3:0];
					an = 8'b11110111;
					end
			3'b100:begin
					data = unconditionalJump[7:4];
					an = 8'b11101111;
					end
			3'b101:begin
					data = totalCycle[3:0];
					an = 8'b11011111;
					end
			3'b110:begin
					data = totalCycle[7:4];
					an = 8'b10111111;
					end
			3'b111:begin
					data = totalCycle[11:8];
					an = 8'b01111111;
					end
			default:begin
					data = totalCycle[11:8];
					an = 8'b11111111;
					end
			endcase
		end
		else begin
			case(cnt_scan[15:13])
			3'b000:begin 
					data = LEDdata[3:0];
					an = 8'b11111110;
					end
			3'b001:begin 
					data = LEDdata[7:4];
					an = 8'b11111101;
					end
			3'b010:begin
					data = LEDdata[11:8];
					an = 8'b11111011;
					end
			3'b011:begin
					data = LEDdata[15:12];
					an = 8'b11110111;
					end
			3'b100:begin
					data = LEDdata[19:16];
					an = 8'b11101111;
					end
			3'b101:begin
					data = LEDdata[23:20];
					an = 8'b11011111;
					end
			3'b110:begin
					data = LEDdata[27:24];
					an = 8'b10111111;
					end
			3'b111:begin
					data = LEDdata[31:28];
					an = 8'b01111111;
					end
			default:begin
					data = LEDdata[31:28];
					an = 8'b11111111;
					end
			endcase
		end
		
		case(data[3:0])
                4'h0: seg = 8'b000_0001_1;
                4'h1: seg = 8'b100_1111_1;
                4'h2: seg = 8'b001_0010_1;
                4'h3: seg = 8'b000_0110_1;
                4'h4: seg = 8'b100_1100_1;
                4'h5: seg = 8'b010_0100_1;
                4'h6: seg = 8'b010_0000_1;
                4'h7: seg = 8'b000_1111_1;
                4'h8: seg = 8'b000_0000_1;
                4'h9: seg = 8'b000_1100_1;
                4'ha: seg = 8'b000_1000_1;
                4'hb: seg = 8'b110_0000_1;
                4'hc: seg = 8'b011_0001_1;
                4'hd: seg = 8'b100_0010_1;
                4'he: seg = 8'b011_0000_1;
                4'hf: seg = 8'b011_1000_1;
                default: seg = 8'b111_1111_1;
        endcase
	end
endmodule