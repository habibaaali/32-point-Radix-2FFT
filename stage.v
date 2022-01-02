

module stage#(
	//Parameterized values
	parameter number_bits=22, // 1 sign >> 9 int (3ovr +7 data)>> 11 fraction 
	parameter weight_bits=12 //for weight
	) 
(
input [2*number_bits-1:0]  data_in1  , //32 reg each width 34 bits
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
input clk_50,
input rst_n,
input [2*weight_bits-1:0] w1,
input [2*weight_bits-1:0] w2,
input [2*weight_bits-1:0] w3,
input [2*weight_bits-1:0] w4,
input [2*weight_bits-1:0] w5,
input [2*weight_bits-1:0] w6,
input [2*weight_bits-1:0] w7,
input [2*weight_bits-1:0] w8,
input [2*weight_bits-1:0] w9,
input [2*weight_bits-1:0] w10,
input [2*weight_bits-1:0] w11,
input [2*weight_bits-1:0] w12,
input [2*weight_bits-1:0] w13,
input [2*weight_bits-1:0] w14,
input [2*weight_bits-1:0] w15,
input [2*weight_bits-1:0] w16,
input [1:0]  sel,
input En1, 
input En2,
input En3,
input En4,

output  [2*number_bits-1:0] data_out1, 
output  [2*number_bits-1:0] data_out2, 
output  [2*number_bits-1:0] data_out3, 
output  [2*number_bits-1:0] data_out4, 
output  [2*number_bits-1:0] data_out5, 
output  [2*number_bits-1:0] data_out6, 
output  [2*number_bits-1:0] data_out7, 
output  [2*number_bits-1:0] data_out8, 
output  [2*number_bits-1:0] data_out9, 
output  [2*number_bits-1:0] data_out10, 
output  [2*number_bits-1:0] data_out11, 
output  [2*number_bits-1:0] data_out12, 
output  [2*number_bits-1:0] data_out13, 
output  [2*number_bits-1:0] data_out14, 
output  [2*number_bits-1:0] data_out15, 
output  [2*number_bits-1:0] data_out16, 
output  [2*number_bits-1:0] data_out17, 
output  [2*number_bits-1:0] data_out18, 
output  [2*number_bits-1:0] data_out19, 
output  [2*number_bits-1:0] data_out20, 
output  [2*number_bits-1:0] data_out21, 
output  [2*number_bits-1:0] data_out22, 
output  [2*number_bits-1:0] data_out23, 
output  [2*number_bits-1:0] data_out24, 
output  [2*number_bits-1:0] data_out25, 
output  [2*number_bits-1:0] data_out26, 
output  [2*number_bits-1:0] data_out27, 
output  [2*number_bits-1:0] data_out28, 
output  [2*number_bits-1:0] data_out29, 
output  [2*number_bits-1:0] data_out30, 
output  [2*number_bits-1:0] data_out31, 
output  [2*number_bits-1:0] data_out32
 );
 
 //4 butterfly for one stage 
 
 butterfly B1 (.in1(data_in1),.in2(data_in2),.in3(data_in3),.in4(data_in4),
               .in5(data_in5),.in6(data_in6),.in7(data_in7),.in8(data_in8),
               .w1(w1),.w2(w2),.w3(w3),.w4(w4),
               .en1(En1),.en2(En2),.en3(En3),.en4(En4),
               .clk_50(clk_50),.rst_n(rst_n),.sel(sel),
               .out1(data_out1) ,.out2(data_out2) ,.out3(data_out3) ,.out4(data_out4),
               .out5(data_out5) ,.out6(data_out6),.out7(data_out7)  ,.out8(data_out8));
 
 
  
 butterfly B2 (.in1(data_in9),.in2(data_in10),.in3(data_in11),.in4(data_in12),
               .in5(data_in13),.in6(data_in14),.in7(data_in15),.in8(data_in16),
               .w1(w5),.w2(w6),.w3(w7),.w4(w8),
               .en1(En1),.en2(En2),.en3(En3),.en4(En4),
               .clk_50(clk_50),.rst_n(rst_n),.sel(sel),
               .out1(data_out9) ,.out2(data_out10) ,.out3(data_out11) ,.out4(data_out12),
               .out5(data_out13) ,.out6(data_out14),.out7(data_out15)  ,.out8(data_out16));
 
 
  
 butterfly B3 (.in1(data_in17),.in2(data_in18),.in3(data_in19),.in4(data_in20),
               .in5(data_in21),.in6(data_in22),.in7(data_in23),.in8(data_in24),
               .w1(w9),.w2(w10),.w3(w11),.w4(w12),
               .en1(En1),.en2(En2),.en3(En3),.en4(En4),
               .clk_50(clk_50),.rst_n(rst_n),.sel(sel),
               .out1(data_out17) ,.out2(data_out18) ,.out3(data_out19) ,.out4(data_out20),
               .out5(data_out21) ,.out6(data_out22),.out7(data_out23)  ,.out8(data_out24));
               
                
 butterfly B4 (.in1(data_in25),.in2(data_in26),.in3(data_in27),.in4(data_in28),
               .in5(data_in29),.in6(data_in30),.in7(data_in31),.in8(data_in32),
               .w1(w13),.w2(w14),.w3(w15),.w4(w16),
               .en1(En1),.en2(En2),.en3(En3),.en4(En4),
               .clk_50(clk_50),.rst_n(rst_n),.sel(sel),
               .out1(data_out25) ,.out2(data_out26) ,.out3(data_out27) ,.out4(data_out28),
               .out5(data_out29) ,.out6(data_out30),.out7(data_out31)  ,.out8(data_out32));
 
 
 
 
 
endmodule
