//ģ�����е�_xbit����λ��Ϊx
//��·ѡ�������������Ϊ "ѡ���ź�_MUXout" ������RegDst�ź�ѡ���ѡ���������ΪRegDst_MUXout
module mux2_1_1bit(out1, a, b, sel);
    output  reg out1;
    input  a, b;
    input sel;
always @(sel or a or b)
begin
    case (sel)
        1'b0 :  out1 = a;
        1'b1 :  out1 = b;
    endcase
end
endmodule

module mux2_1_5bit(out1, a, b, sel);
    output  reg [4:0] out1;
    input       [4:0] a, b;
    input       sel;
always @(sel or a or b)
begin
    case (sel)
        1'b0 :  out1 = a;
        1'b1 :  out1 = b;
    endcase
end
endmodule

module mux2_1_32bit(out1, a, b, sel);
    output  reg [31:0] out1;
    input       [31:0] a, b;
    input       sel;
always @(sel or a or b)
begin
    case (sel)
        1'b0 :  out1 = a;
        1'b1 :  out1 = b;
    endcase
end
endmodule

module mux2_1_16bit(out1, a, b, sel);
    output  reg [15:0] out1;
    input       [15:0] a, b;
    input       sel;
always @(sel or a or b)
begin
    case (sel)
        1'b0 :  out1 = a;
        1'b1 :  out1 = b;
    endcase
end
endmodule