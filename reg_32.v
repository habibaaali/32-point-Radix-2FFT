

module reg_32#(parameter number_bits=22)
(
input [2*number_bits-1:0]  data_in1  , //32 reg each width 42 bits 22 real and 22 img
input [2*number_bits-1:0]  data_in2, 
input [2*number_bits-1:0]  data_in3, 
input [2*number_bits-1:0]  data_in4, 
input [2*number_bits-1:0]  data_in5, 
input [2*number_bits-1:0]  data_in6, 
input [2*number_bits-1:0]  data_in7, 
input [2*number_bits-1:0]  data_in8, 
input [2*number_bits-1:0]  data_in9, 
input [2*number_bits-1:0]  data_in10, 
input [2*number_bits-1:0]  data_in11, 
input [2*number_bits-1:0]  data_in12, 
input [2*number_bits-1:0]  data_in13, 
input [2*number_bits-1:0]  data_in14, 
input [2*number_bits-1:0]  data_in15, 
input [2*number_bits-1:0]  data_in16, 
input [2*number_bits-1:0]  data_in17, 
input [2*number_bits-1:0]  data_in18, 
input [2*number_bits-1:0]  data_in19, 
input [2*number_bits-1:0]  data_in20, 
input [2*number_bits-1:0]  data_in21, 
input [2*number_bits-1:0]  data_in22, 
input [2*number_bits-1:0]  data_in23, 
input [2*number_bits-1:0]  data_in24, 
input [2*number_bits-1:0]  data_in25, 
input [2*number_bits-1:0]  data_in26, 
input [2*number_bits-1:0]  data_in27, 
input [2*number_bits-1:0]  data_in28, 
input [2*number_bits-1:0]  data_in29, 
input [2*number_bits-1:0]  data_in30, 
input [2*number_bits-1:0]  data_in31, 
input [2*number_bits-1:0]  data_in32, 
input clk_10,
input rst_n,
output reg [2*number_bits-1:0] data_out1, 
output reg [2*number_bits-1:0] data_out2, 
output reg [2*number_bits-1:0] data_out3, 
output reg [2*number_bits-1:0] data_out4, 
output reg [2*number_bits-1:0] data_out5, 
output reg [2*number_bits-1:0] data_out6, 
output reg [2*number_bits-1:0] data_out7, 
output reg [2*number_bits-1:0] data_out8, 
output reg [2*number_bits-1:0] data_out9, 
output reg [2*number_bits-1:0] data_out10, 
output reg [2*number_bits-1:0] data_out11, 
output reg [2*number_bits-1:0] data_out12, 
output reg [2*number_bits-1:0] data_out13, 
output reg [2*number_bits-1:0] data_out14, 
output reg [2*number_bits-1:0] data_out15, 
output reg [2*number_bits-1:0] data_out16, 
output reg [2*number_bits-1:0] data_out17, 
output reg [2*number_bits-1:0] data_out18, 
output reg [2*number_bits-1:0] data_out19, 
output reg [2*number_bits-1:0] data_out20, 
output reg [2*number_bits-1:0] data_out21, 
output reg [2*number_bits-1:0] data_out22, 
output reg [2*number_bits-1:0] data_out23, 
output reg [2*number_bits-1:0] data_out24, 
output reg [2*number_bits-1:0] data_out25, 
output reg [2*number_bits-1:0] data_out26, 
output reg [2*number_bits-1:0] data_out27, 
output reg [2*number_bits-1:0] data_out28, 
output reg [2*number_bits-1:0] data_out29, 
output reg [2*number_bits-1:0] data_out30, 
output reg [2*number_bits-1:0] data_out31, 
output reg [2*number_bits-1:0] data_out32
);



always @(posedge clk_10 or negedge rst_n)
    begin
        if (!rst_n)
        begin
            data_out1<=0;
            data_out2<=0;
            data_out3<=0;
            data_out4<=0;
            data_out5<=0;
            data_out6<=0;
            data_out7<=0;
            data_out8<=0;
            data_out9<=0;
            data_out10<=0;
            data_out11<=0;
            data_out12<=0;
            data_out13<=0;
            data_out14<=0;
            data_out15<=0;
            data_out16<=0;
            data_out17<=0;
            data_out18<=0;
            data_out19<=0;
            data_out20<=0;
            data_out21<=0;
            data_out22<=0;
            data_out23<=0;
            data_out24<=0;
            data_out25<=0;
            data_out26<=0;
            data_out27<=0;
            data_out28<=0;
            data_out29<=0;
            data_out30<=0;
            data_out31<=0;
            data_out32<=0;
         end
            else 
            begin
                data_out1 <=data_in1;
                data_out2 <=data_in2;
                data_out3 <=data_in3;
                data_out4 <=data_in4;
                data_out5 <=data_in5;
                data_out6 <=data_in6;
                data_out7 <=data_in7;
                data_out8 <=data_in8;
                data_out9 <=data_in9;
                data_out10<=data_in10;
                data_out11<=data_in11;
                data_out12<=data_in12;
                data_out13<=data_in13;
                data_out14<=data_in14;
                data_out15<=data_in15;
                data_out16<=data_in16;
                data_out17<=data_in17;
                data_out18<=data_in18;
                data_out19<=data_in19;
                data_out20<=data_in20;
                data_out21<=data_in21;
                data_out22<=data_in22;
                data_out23<=data_in23;
                data_out24<=data_in24;
                data_out25<=data_in25;
                data_out26<=data_in26;
                data_out27<=data_in27;
                data_out28<=data_in28;
                data_out29<=data_in29;
                data_out30<=data_in30;
                data_out31<=data_in31;
                data_out32<=data_in32;
            end
    
    end

endmodule
