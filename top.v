
module top#(
	//Parameterized values
	parameter number_bits=22, // 1 sign >> 9 int (3ovr +7 data)>> 11 fraction 
	parameter weight_bits=12, //for weight
	parameter ADC_bits= 8,
	//weight values
    parameter w1=24'b011111111111000000000000, //  e^0  >>  1+0j (1 sign + 11 faction_real) + (1 sign +11 faction_img)
    parameter w2=24'b011111011000100110001111, //  exp(-2*pi*j*1/32) >> 0.9807-0.1950j
    parameter w3=24'b011101100100101100010000,//  exp(-2*pi*j*2/32)  >>0.9238-0.3826j
    parameter w4=24'b011010100111110001110010,  //exp(-2*pi*j*3/32)  >>0.8314-0.5555j
    parameter w5=24'b010110101000110110101000,  //exp(-2*pi*j*4/32)  >>0.7071-0.7071j
    parameter w6=24'b010001110010111010100111,  //exp(-2*pi*j*5/32)  >>0.5555-0.8314j
    parameter w7=24'b001100010000111101100100,  //exp(-2*pi*j*6/32)  >>0.3826-0.9238j
    parameter w8=24'b000110001111111111011000,  //exp(-2*pi*j*7/32)  >>0.1950-0.9807j
    parameter w9=24'b000000000000111111111111,  //exp(-2*pi*j*8/32)  >>0-1j
    parameter w10=24'b100110001111111111011000,  //exp(-2*pi*j*9/32)  >>-0.1950-0.9807j
    parameter w11=24'b101100010000111101100100,  //exp(-2*pi*j*10/32)  >>-0.3826-0.9238j
    parameter w12=24'b110001110010111010100111,  //exp(-2*pi*j*11/32)  >>-0.5555-0.8314j
    parameter w13=24'b110110101000110110101000,  //exp(-2*pi*j*12/32)  >>-0.7071-0.7071j
    parameter w14=24'b111010100111110001110010,  //exp(-2*pi*j*13/32)  >>-0.8314-0.5555j
    parameter w15=24'b111101100100101100010000, // exp(-2*pi*j*14/32)  >>-0.9238-0.3826j
    parameter w16=24'b111111011000100110001111 //  exp(-2*pi*j*15/32) >> -0.9807-0.1950j
	) 
(
input [ADC_bits-1:0]  data_in1  , //32 reg each width 8 bits >> 8 for real  >>intger and real data only
input [ADC_bits-1:0]  data_in2, 
input [ADC_bits-1:0]  data_in3, 
input [ADC_bits-1:0]  data_in4, 
input [ADC_bits-1:0]  data_in5, 
input [ADC_bits-1:0]  data_in6, 
input [ADC_bits-1:0]  data_in7, 
input [ADC_bits-1:0]  data_in8, 
input [ADC_bits-1:0]  data_in9, 
input [ADC_bits-1:0]  data_in10, 
input [ADC_bits-1:0]  data_in11, 
input [ADC_bits-1:0]  data_in12, 
input [ADC_bits-1:0]  data_in13, 
input [ADC_bits-1:0]  data_in14, 
input [ADC_bits-1:0]  data_in15, 
input [ADC_bits-1:0]  data_in16, 
input [ADC_bits-1:0]  data_in17, 
input [ADC_bits-1:0]  data_in18, 
input [ADC_bits-1:0]  data_in19, 
input [ADC_bits-1:0]  data_in20, 
input [ADC_bits-1:0]  data_in21, 
input [ADC_bits-1:0]  data_in22, 
input [ADC_bits-1:0]  data_in23, 
input [ADC_bits-1:0]  data_in24, 
input [ADC_bits-1:0]  data_in25, 
input [ADC_bits-1:0]  data_in26, 
input [ADC_bits-1:0]  data_in27, 
input [ADC_bits-1:0]  data_in28, 
input [ADC_bits-1:0]  data_in29, 
input [ADC_bits-1:0]  data_in30, 
input [ADC_bits-1:0]  data_in31, 
input [ADC_bits-1:0]  data_in32, 
input clk_50,
input clk_10,
input rst_n,
input start,
output  [2*number_bits-1:0] out1,
output  [2*number_bits-1:0] out2, 
output  [2*number_bits-1:0] out3, 
output  [2*number_bits-1:0] out4, 
output  [2*number_bits-1:0] out5, 
output  [2*number_bits-1:0] out6, 
output  [2*number_bits-1:0] out7, 
output  [2*number_bits-1:0] out8, 
output  [2*number_bits-1:0] out9, 
output  [2*number_bits-1:0] out10, 
output  [2*number_bits-1:0] out11, 
output  [2*number_bits-1:0] out12, 
output  [2*number_bits-1:0] out13, 
output  [2*number_bits-1:0] out14, 
output  [2*number_bits-1:0] out15, 
output  [2*number_bits-1:0] out16, 
output  [2*number_bits-1:0] out17, 
output  [2*number_bits-1:0] out18, 
output  [2*number_bits-1:0] out19, 
output  [2*number_bits-1:0] out20, 
output  [2*number_bits-1:0] out21, 
output  [2*number_bits-1:0] out22, 
output  [2*number_bits-1:0] out23, 
output  [2*number_bits-1:0] out24, 
output  [2*number_bits-1:0] out25, 
output  [2*number_bits-1:0] out26, 
output  [2*number_bits-1:0] out27, 
output  [2*number_bits-1:0] out28, 
output  [2*number_bits-1:0] out29, 
output  [2*number_bits-1:0] out30, 
output  [2*number_bits-1:0] out31, 
output  [2*number_bits-1:0] out32
 );
//controller wiers
wire [1:0] selection_line ;
wire  En1 ;
wire  En2 ;
wire  En3 ;
wire  En4 ; 


//output of reverse 
wire  [ADC_bits-1:0] data_out1;
wire  [ADC_bits-1:0] data_out2; 
wire  [ADC_bits-1:0] data_out3; 
wire  [ADC_bits-1:0] data_out4; 
wire  [ADC_bits-1:0] data_out5; 
wire  [ADC_bits-1:0] data_out6; 
wire  [ADC_bits-1:0] data_out7; 
wire  [ADC_bits-1:0] data_out8; 
wire  [ADC_bits-1:0] data_out9; 
wire  [ADC_bits-1:0] data_out10; 
wire  [ADC_bits-1:0] data_out11; 
wire  [ADC_bits-1:0] data_out12; 
wire  [ADC_bits-1:0] data_out13; 
wire  [ADC_bits-1:0] data_out14; 
wire  [ADC_bits-1:0] data_out15; 
wire  [ADC_bits-1:0] data_out16; 
wire  [ADC_bits-1:0] data_out17; 
wire  [ADC_bits-1:0] data_out18; 
wire  [ADC_bits-1:0] data_out19; 
wire  [ADC_bits-1:0] data_out20; 
wire  [ADC_bits-1:0] data_out21; 
wire  [ADC_bits-1:0] data_out22; 
wire  [ADC_bits-1:0] data_out23; 
wire  [ADC_bits-1:0] data_out24; 
wire  [ADC_bits-1:0] data_out25; 
wire  [ADC_bits-1:0] data_out26; 
wire  [ADC_bits-1:0] data_out27; 
wire  [ADC_bits-1:0] data_out28; 
wire  [ADC_bits-1:0] data_out29; 
wire  [ADC_bits-1:0] data_out30; 
wire  [ADC_bits-1:0] data_out31; 
wire  [ADC_bits-1:0] data_out32;
// input to stage one after adding fraction bits to output of reverse
wire  [2*number_bits-1:0] stage1_input1;
wire  [2*number_bits-1:0] stage1_input2; 
wire  [2*number_bits-1:0] stage1_input3; 
wire  [2*number_bits-1:0] stage1_input4; 
wire  [2*number_bits-1:0] stage1_input5; 
wire  [2*number_bits-1:0] stage1_input6; 
wire  [2*number_bits-1:0] stage1_input7; 
wire  [2*number_bits-1:0] stage1_input8; 
wire  [2*number_bits-1:0] stage1_input9; 
wire  [2*number_bits-1:0] stage1_input10; 
wire  [2*number_bits-1:0] stage1_input11; 
wire  [2*number_bits-1:0] stage1_input12; 
wire  [2*number_bits-1:0] stage1_input13; 
wire  [2*number_bits-1:0] stage1_input14; 
wire  [2*number_bits-1:0] stage1_input15; 
wire  [2*number_bits-1:0] stage1_input16; 
wire  [2*number_bits-1:0] stage1_input17; 
wire  [2*number_bits-1:0] stage1_input18; 
wire  [2*number_bits-1:0] stage1_input19; 
wire  [2*number_bits-1:0] stage1_input20; 
wire  [2*number_bits-1:0] stage1_input21; 
wire  [2*number_bits-1:0] stage1_input22; 
wire  [2*number_bits-1:0] stage1_input23; 
wire  [2*number_bits-1:0] stage1_input24; 
wire  [2*number_bits-1:0] stage1_input25; 
wire  [2*number_bits-1:0] stage1_input26; 
wire  [2*number_bits-1:0] stage1_input27; 
wire  [2*number_bits-1:0] stage1_input28; 
wire  [2*number_bits-1:0] stage1_input29; 
wire  [2*number_bits-1:0] stage1_input30; 
wire  [2*number_bits-1:0] stage1_input31; 
wire  [2*number_bits-1:0] stage1_input32;
//output from stage 1 
wire  [2*number_bits-1:0] stage1_output1;
wire  [2*number_bits-1:0] stage1_output2; 
wire  [2*number_bits-1:0] stage1_output3; 
wire  [2*number_bits-1:0] stage1_output4; 
wire  [2*number_bits-1:0] stage1_output5; 
wire  [2*number_bits-1:0] stage1_output6; 
wire  [2*number_bits-1:0] stage1_output7; 
wire  [2*number_bits-1:0] stage1_output8; 
wire  [2*number_bits-1:0] stage1_output9; 
wire  [2*number_bits-1:0] stage1_output10; 
wire  [2*number_bits-1:0] stage1_output11; 
wire  [2*number_bits-1:0] stage1_output12; 
wire  [2*number_bits-1:0] stage1_output13; 
wire  [2*number_bits-1:0] stage1_output14; 
wire  [2*number_bits-1:0] stage1_output15; 
wire  [2*number_bits-1:0] stage1_output16; 
wire  [2*number_bits-1:0] stage1_output17; 
wire  [2*number_bits-1:0] stage1_output18; 
wire  [2*number_bits-1:0] stage1_output19; 
wire  [2*number_bits-1:0] stage1_output20; 
wire  [2*number_bits-1:0] stage1_output21; 
wire  [2*number_bits-1:0] stage1_output22; 
wire  [2*number_bits-1:0] stage1_output23; 
wire  [2*number_bits-1:0] stage1_output24; 
wire  [2*number_bits-1:0] stage1_output25; 
wire  [2*number_bits-1:0] stage1_output26; 
wire  [2*number_bits-1:0] stage1_output27; 
wire  [2*number_bits-1:0] stage1_output28; 
wire  [2*number_bits-1:0] stage1_output29; 
wire  [2*number_bits-1:0] stage1_output30; 
wire  [2*number_bits-1:0] stage1_output31; 
wire  [2*number_bits-1:0] stage1_output32;
// input to stage 2(output from reg_32)
wire  [2*number_bits-1:0] stage2_input1;
wire  [2*number_bits-1:0] stage2_input2; 
wire  [2*number_bits-1:0] stage2_input3; 
wire  [2*number_bits-1:0] stage2_input4; 
wire  [2*number_bits-1:0] stage2_input5; 
wire  [2*number_bits-1:0] stage2_input6; 
wire  [2*number_bits-1:0] stage2_input7; 
wire  [2*number_bits-1:0] stage2_input8; 
wire  [2*number_bits-1:0] stage2_input9; 
wire  [2*number_bits-1:0] stage2_input10; 
wire  [2*number_bits-1:0] stage2_input11; 
wire  [2*number_bits-1:0] stage2_input12; 
wire  [2*number_bits-1:0] stage2_input13; 
wire  [2*number_bits-1:0] stage2_input14; 
wire  [2*number_bits-1:0] stage2_input15; 
wire  [2*number_bits-1:0] stage2_input16; 
wire  [2*number_bits-1:0] stage2_input17; 
wire  [2*number_bits-1:0] stage2_input18; 
wire  [2*number_bits-1:0] stage2_input19; 
wire  [2*number_bits-1:0] stage2_input20; 
wire  [2*number_bits-1:0] stage2_input21; 
wire  [2*number_bits-1:0] stage2_input22; 
wire  [2*number_bits-1:0] stage2_input23; 
wire  [2*number_bits-1:0] stage2_input24; 
wire  [2*number_bits-1:0] stage2_input25; 
wire  [2*number_bits-1:0] stage2_input26; 
wire  [2*number_bits-1:0] stage2_input27; 
wire  [2*number_bits-1:0] stage2_input28; 
wire  [2*number_bits-1:0] stage2_input29; 
wire  [2*number_bits-1:0] stage2_input30; 
wire  [2*number_bits-1:0] stage2_input31; 
wire  [2*number_bits-1:0] stage2_input32;
//output from stage 2 
wire  [2*number_bits-1:0] stage2_output1;
wire  [2*number_bits-1:0] stage2_output2; 
wire  [2*number_bits-1:0] stage2_output3; 
wire  [2*number_bits-1:0] stage2_output4; 
wire  [2*number_bits-1:0] stage2_output5; 
wire  [2*number_bits-1:0] stage2_output6; 
wire  [2*number_bits-1:0] stage2_output7; 
wire  [2*number_bits-1:0] stage2_output8; 
wire  [2*number_bits-1:0] stage2_output9; 
wire  [2*number_bits-1:0] stage2_output10; 
wire  [2*number_bits-1:0] stage2_output11; 
wire  [2*number_bits-1:0] stage2_output12; 
wire  [2*number_bits-1:0] stage2_output13; 
wire  [2*number_bits-1:0] stage2_output14; 
wire  [2*number_bits-1:0] stage2_output15; 
wire  [2*number_bits-1:0] stage2_output16; 
wire  [2*number_bits-1:0] stage2_output17; 
wire  [2*number_bits-1:0] stage2_output18; 
wire  [2*number_bits-1:0] stage2_output19; 
wire  [2*number_bits-1:0] stage2_output20; 
wire  [2*number_bits-1:0] stage2_output21; 
wire  [2*number_bits-1:0] stage2_output22; 
wire  [2*number_bits-1:0] stage2_output23; 
wire  [2*number_bits-1:0] stage2_output24; 
wire  [2*number_bits-1:0] stage2_output25; 
wire  [2*number_bits-1:0] stage2_output26; 
wire  [2*number_bits-1:0] stage2_output27; 
wire  [2*number_bits-1:0] stage2_output28; 
wire  [2*number_bits-1:0] stage2_output29; 
wire  [2*number_bits-1:0] stage2_output30; 
wire  [2*number_bits-1:0] stage2_output31; 
wire  [2*number_bits-1:0] stage2_output32;
//input to stage 3
wire  [2*number_bits-1:0] stage3_input1;
wire  [2*number_bits-1:0] stage3_input2; 
wire  [2*number_bits-1:0] stage3_input3; 
wire  [2*number_bits-1:0] stage3_input4; 
wire  [2*number_bits-1:0] stage3_input5; 
wire  [2*number_bits-1:0] stage3_input6; 
wire  [2*number_bits-1:0] stage3_input7; 
wire  [2*number_bits-1:0] stage3_input8; 
wire  [2*number_bits-1:0] stage3_input9; 
wire  [2*number_bits-1:0] stage3_input10; 
wire  [2*number_bits-1:0] stage3_input11; 
wire  [2*number_bits-1:0] stage3_input12; 
wire  [2*number_bits-1:0] stage3_input13; 
wire  [2*number_bits-1:0] stage3_input14; 
wire  [2*number_bits-1:0] stage3_input15; 
wire  [2*number_bits-1:0] stage3_input16; 
wire  [2*number_bits-1:0] stage3_input17; 
wire  [2*number_bits-1:0] stage3_input18; 
wire  [2*number_bits-1:0] stage3_input19; 
wire  [2*number_bits-1:0] stage3_input20; 
wire  [2*number_bits-1:0] stage3_input21; 
wire  [2*number_bits-1:0] stage3_input22; 
wire  [2*number_bits-1:0] stage3_input23; 
wire  [2*number_bits-1:0] stage3_input24; 
wire  [2*number_bits-1:0] stage3_input25; 
wire  [2*number_bits-1:0] stage3_input26; 
wire  [2*number_bits-1:0] stage3_input27; 
wire  [2*number_bits-1:0] stage3_input28; 
wire  [2*number_bits-1:0] stage3_input29; 
wire  [2*number_bits-1:0] stage3_input30; 
wire  [2*number_bits-1:0] stage3_input31; 
wire  [2*number_bits-1:0] stage3_input32;
//output from stage 3 
wire  [2*number_bits-1:0] stage3_output1;
wire  [2*number_bits-1:0] stage3_output2; 
wire  [2*number_bits-1:0] stage3_output3; 
wire  [2*number_bits-1:0] stage3_output4; 
wire  [2*number_bits-1:0] stage3_output5; 
wire  [2*number_bits-1:0] stage3_output6; 
wire  [2*number_bits-1:0] stage3_output7; 
wire  [2*number_bits-1:0] stage3_output8; 
wire  [2*number_bits-1:0] stage3_output9; 
wire  [2*number_bits-1:0] stage3_output10; 
wire  [2*number_bits-1:0] stage3_output11; 
wire  [2*number_bits-1:0] stage3_output12; 
wire  [2*number_bits-1:0] stage3_output13; 
wire  [2*number_bits-1:0] stage3_output14; 
wire  [2*number_bits-1:0] stage3_output15; 
wire  [2*number_bits-1:0] stage3_output16; 
wire  [2*number_bits-1:0] stage3_output17; 
wire  [2*number_bits-1:0] stage3_output18; 
wire  [2*number_bits-1:0] stage3_output19; 
wire  [2*number_bits-1:0] stage3_output20; 
wire  [2*number_bits-1:0] stage3_output21; 
wire  [2*number_bits-1:0] stage3_output22; 
wire  [2*number_bits-1:0] stage3_output23; 
wire  [2*number_bits-1:0] stage3_output24; 
wire  [2*number_bits-1:0] stage3_output25; 
wire  [2*number_bits-1:0] stage3_output26; 
wire  [2*number_bits-1:0] stage3_output27; 
wire  [2*number_bits-1:0] stage3_output28; 
wire  [2*number_bits-1:0] stage3_output29; 
wire  [2*number_bits-1:0] stage3_output30; 
wire  [2*number_bits-1:0] stage3_output31; 
wire  [2*number_bits-1:0] stage3_output32;
//input to stage 4
wire  [2*number_bits-1:0] stage4_input1;
wire  [2*number_bits-1:0] stage4_input2; 
wire  [2*number_bits-1:0] stage4_input3; 
wire  [2*number_bits-1:0] stage4_input4; 
wire  [2*number_bits-1:0] stage4_input5; 
wire  [2*number_bits-1:0] stage4_input6; 
wire  [2*number_bits-1:0] stage4_input7; 
wire  [2*number_bits-1:0] stage4_input8; 
wire  [2*number_bits-1:0] stage4_input9; 
wire  [2*number_bits-1:0] stage4_input10; 
wire  [2*number_bits-1:0] stage4_input11; 
wire  [2*number_bits-1:0] stage4_input12; 
wire  [2*number_bits-1:0] stage4_input13; 
wire  [2*number_bits-1:0] stage4_input14; 
wire  [2*number_bits-1:0] stage4_input15; 
wire  [2*number_bits-1:0] stage4_input16; 
wire  [2*number_bits-1:0] stage4_input17; 
wire  [2*number_bits-1:0] stage4_input18; 
wire  [2*number_bits-1:0] stage4_input19; 
wire  [2*number_bits-1:0] stage4_input20; 
wire  [2*number_bits-1:0] stage4_input21; 
wire  [2*number_bits-1:0] stage4_input22; 
wire  [2*number_bits-1:0] stage4_input23; 
wire  [2*number_bits-1:0] stage4_input24; 
wire  [2*number_bits-1:0] stage4_input25; 
wire  [2*number_bits-1:0] stage4_input26; 
wire  [2*number_bits-1:0] stage4_input27; 
wire  [2*number_bits-1:0] stage4_input28; 
wire  [2*number_bits-1:0] stage4_input29; 
wire  [2*number_bits-1:0] stage4_input30; 
wire  [2*number_bits-1:0] stage4_input31; 
wire  [2*number_bits-1:0] stage4_input32;
//output from stage 4 and input to stage 5
wire  [2*number_bits-1:0] stage4_output1;
wire  [2*number_bits-1:0] stage4_output2; 
wire  [2*number_bits-1:0] stage4_output3; 
wire  [2*number_bits-1:0] stage4_output4; 
wire  [2*number_bits-1:0] stage4_output5; 
wire  [2*number_bits-1:0] stage4_output6; 
wire  [2*number_bits-1:0] stage4_output7; 
wire  [2*number_bits-1:0] stage4_output8; 
wire  [2*number_bits-1:0] stage4_output9; 
wire  [2*number_bits-1:0] stage4_output10; 
wire  [2*number_bits-1:0] stage4_output11; 
wire  [2*number_bits-1:0] stage4_output12; 
wire  [2*number_bits-1:0] stage4_output13; 
wire  [2*number_bits-1:0] stage4_output14; 
wire  [2*number_bits-1:0] stage4_output15; 
wire  [2*number_bits-1:0] stage4_output16; 
wire  [2*number_bits-1:0] stage4_output17; 
wire  [2*number_bits-1:0] stage4_output18; 
wire  [2*number_bits-1:0] stage4_output19; 
wire  [2*number_bits-1:0] stage4_output20; 
wire  [2*number_bits-1:0] stage4_output21; 
wire  [2*number_bits-1:0] stage4_output22; 
wire  [2*number_bits-1:0] stage4_output23; 
wire  [2*number_bits-1:0] stage4_output24; 
wire  [2*number_bits-1:0] stage4_output25; 
wire  [2*number_bits-1:0] stage4_output26; 
wire  [2*number_bits-1:0] stage4_output27; 
wire  [2*number_bits-1:0] stage4_output28; 
wire  [2*number_bits-1:0] stage4_output29; 
wire  [2*number_bits-1:0] stage4_output30; 
wire  [2*number_bits-1:0] stage4_output31; 
wire  [2*number_bits-1:0] stage4_output32;
//input to stage 5
wire  [2*number_bits-1:0] stage5_input1;
wire  [2*number_bits-1:0] stage5_input2; 
wire  [2*number_bits-1:0] stage5_input3; 
wire  [2*number_bits-1:0] stage5_input4; 
wire  [2*number_bits-1:0] stage5_input5; 
wire  [2*number_bits-1:0] stage5_input6; 
wire  [2*number_bits-1:0] stage5_input7; 
wire  [2*number_bits-1:0] stage5_input8; 
wire  [2*number_bits-1:0] stage5_input9; 
wire  [2*number_bits-1:0] stage5_input10; 
wire  [2*number_bits-1:0] stage5_input11; 
wire  [2*number_bits-1:0] stage5_input12; 
wire  [2*number_bits-1:0] stage5_input13; 
wire  [2*number_bits-1:0] stage5_input14; 
wire  [2*number_bits-1:0] stage5_input15; 
wire  [2*number_bits-1:0] stage5_input16; 
wire  [2*number_bits-1:0] stage5_input17; 
wire  [2*number_bits-1:0] stage5_input18; 
wire  [2*number_bits-1:0] stage5_input19; 
wire  [2*number_bits-1:0] stage5_input20; 
wire  [2*number_bits-1:0] stage5_input21; 
wire  [2*number_bits-1:0] stage5_input22; 
wire  [2*number_bits-1:0] stage5_input23; 
wire  [2*number_bits-1:0] stage5_input24; 
wire  [2*number_bits-1:0] stage5_input25; 
wire  [2*number_bits-1:0] stage5_input26; 
wire  [2*number_bits-1:0] stage5_input27; 
wire  [2*number_bits-1:0] stage5_input28; 
wire  [2*number_bits-1:0] stage5_input29; 
wire  [2*number_bits-1:0] stage5_input30; 
wire  [2*number_bits-1:0] stage5_input31; 
wire  [2*number_bits-1:0] stage5_input32;
//stage 5 output
wire  [2*number_bits-1:0] stage5_output1;
wire  [2*number_bits-1:0] stage5_output2; 
wire  [2*number_bits-1:0] stage5_output3; 
wire  [2*number_bits-1:0] stage5_output4; 
wire  [2*number_bits-1:0] stage5_output5; 
wire  [2*number_bits-1:0] stage5_output6; 
wire  [2*number_bits-1:0] stage5_output7; 
wire  [2*number_bits-1:0] stage5_output8; 
wire  [2*number_bits-1:0] stage5_output9; 
wire  [2*number_bits-1:0] stage5_output10; 
wire  [2*number_bits-1:0] stage5_output11; 
wire  [2*number_bits-1:0] stage5_output12; 
wire  [2*number_bits-1:0] stage5_output13; 
wire  [2*number_bits-1:0] stage5_output14; 
wire  [2*number_bits-1:0] stage5_output15; 
wire  [2*number_bits-1:0] stage5_output16; 
wire  [2*number_bits-1:0] stage5_output17; 
wire  [2*number_bits-1:0] stage5_output18; 
wire  [2*number_bits-1:0] stage5_output19; 
wire  [2*number_bits-1:0] stage5_output20; 
wire  [2*number_bits-1:0] stage5_output21; 
wire  [2*number_bits-1:0] stage5_output22; 
wire  [2*number_bits-1:0] stage5_output23; 
wire  [2*number_bits-1:0] stage5_output24; 
wire  [2*number_bits-1:0] stage5_output25; 
wire  [2*number_bits-1:0] stage5_output26; 
wire  [2*number_bits-1:0] stage5_output27; 
wire  [2*number_bits-1:0] stage5_output28; 
wire  [2*number_bits-1:0] stage5_output29; 
wire  [2*number_bits-1:0] stage5_output30; 
wire  [2*number_bits-1:0] stage5_output31; 
wire  [2*number_bits-1:0] stage5_output32;

 //reverrse bits take 32 inputs everry one is 16 bits 8 real + 8 img
reverse_bit #( .ADC_bits(8)) R (.data_in_real1(data_in1),.data_in_real2(data_in2),.data_in_real3(data_in3),.data_in_real4(data_in4),
                                .data_in_real5(data_in5),.data_in_real6(data_in6),.data_in_real7(data_in7),.data_in_real8(data_in8),
                                .data_in_real9(data_in9),.data_in_real10(data_in10),.data_in_real11(data_in11),.data_in_real12(data_in12),
                                .data_in_real13(data_in13),.data_in_real14(data_in14),.data_in_real15(data_in15),.data_in_real16(data_in16),
                                .data_in_real17(data_in17),.data_in_real18(data_in18),.data_in_real19(data_in19),.data_in_real20(data_in20),
                                .data_in_real21(data_in21),.data_in_real22(data_in22),.data_in_real23(data_in23),.data_in_real24(data_in24),
                                .data_in_real25(data_in25),.data_in_real26(data_in26),.data_in_real27(data_in27),.data_in_real28(data_in28),
                                .data_in_real29(data_in29),.data_in_real30(data_in30),.data_in_real31(data_in31),.data_in_real32(data_in32),
                                //out
                                .data_out_real1(data_out1),.data_out_real2(data_out2),.data_out_real3(data_out3),.data_out_real4(data_out4),
                                .data_out_real5(data_out5),.data_out_real6(data_out6),.data_out_real7(data_out7),.data_out_real8(data_out8),
                                .data_out_real9(data_out9),.data_out_real10(data_out10),.data_out_real11(data_out11),.data_out_real12(data_out12),
                                .data_out_real13(data_out13),.data_out_real14(data_out14),.data_out_real15(data_out15),.data_out_real16(data_out16),
                                .data_out_real17(data_out17),.data_out_real18(data_out18),.data_out_real19(data_out19),.data_out_real20(data_out20),
                                .data_out_real21(data_out21),.data_out_real22(data_out22),.data_out_real23(data_out23),.data_out_real24(data_out24),
                                .data_out_real25(data_out25),.data_out_real26(data_out26),.data_out_real27(data_out27),.data_out_real28(data_out28),
                                .data_out_real29(data_out29),.data_out_real30(data_out30),.data_out_real31(data_out31),.data_out_real32(data_out32) 
                                ); 
                                 
/*add 11 fraction bits to real and  11 fraction bits to img
 [1bit >sign of real & 3'b000 overflow & 7 bit real_integer & 11'b000000000 real_fraction] +
 [1bit >sign of img & 3'b000 overflow & 7 bit img_integer & 11'b000000000 img_fraction]  >> first we put them 22 zeros*/ 

assign stage1_input1 = {data_out1[2*ADC_bits-1],3'b000,data_out1[2*ADC_bits-2:ADC_bits],11'b00000000000,22'b000000000000000000000};  
assign stage1_input2 = {data_out2[2*ADC_bits-1],3'b000,data_out2[2*ADC_bits-2:ADC_bits],11'b00000000000,22'b000000000000000000000};  
assign stage1_input3 = {data_out3[2*ADC_bits-1],3'b000,data_out3[2*ADC_bits-2:ADC_bits],11'b00000000000,22'b000000000000000000000};   
assign stage1_input4 = {data_out4[2*ADC_bits-1],3'b000,data_out4[2*ADC_bits-2:ADC_bits],11'b00000000000,22'b000000000000000000000}; 
assign stage1_input5 = {data_out5[2*ADC_bits-1],3'b000,data_out5[2*ADC_bits-2:ADC_bits],11'b00000000000,22'b000000000000000000000};  
assign stage1_input6 = {data_out6[2*ADC_bits-1],3'b000,data_out6[2*ADC_bits-2:ADC_bits],11'b00000000000,22'b000000000000000000000}; 
assign stage1_input7 = {data_out7[2*ADC_bits-1],3'b000,data_out7[2*ADC_bits-2:ADC_bits],11'b00000000000,22'b000000000000000000000}; 
assign stage1_input8 = {data_out8[2*ADC_bits-1],3'b000,data_out8[2*ADC_bits-2:ADC_bits],11'b00000000000,22'b000000000000000000000}; 
assign stage1_input9 = {data_out9[2*ADC_bits-1],3'b000,data_out9[2*ADC_bits-2:ADC_bits],11'b00000000000,22'b000000000000000000000}; 
assign stage1_input10= {data_out10[2*ADC_bits-1],3'b000,data_out10[2*ADC_bits-2:ADC_bits],11'b00000000000,22'b000000000000000000000}; 
assign stage1_input11= {data_out11[2*ADC_bits-1],3'b000,data_out11[2*ADC_bits-2:ADC_bits],11'b00000000000,22'b000000000000000000000}; 
assign stage1_input12= {data_out12[2*ADC_bits-1],3'b000,data_out12[2*ADC_bits-2:ADC_bits],11'b00000000000,22'b000000000000000000000}; 
assign stage1_input13= {data_out13[2*ADC_bits-1],3'b000,data_out13[2*ADC_bits-2:ADC_bits],11'b00000000000,22'b000000000000000000000}; 
assign stage1_input14= {data_out14[2*ADC_bits-1],3'b000,data_out14[2*ADC_bits-2:ADC_bits],11'b00000000000,22'b000000000000000000000}; 
assign stage1_input15= {data_out15[2*ADC_bits-1],3'b000,data_out15[2*ADC_bits-2:ADC_bits],11'b00000000000,22'b000000000000000000000}; 
assign stage1_input16= {data_out16[2*ADC_bits-1],3'b000,data_out16[2*ADC_bits-2:ADC_bits],11'b00000000000,22'b000000000000000000000};  
assign stage1_input17= {data_out17[2*ADC_bits-1],3'b000,data_out17[2*ADC_bits-2:ADC_bits],11'b00000000000,22'b000000000000000000000};  
assign stage1_input18= {data_out18[2*ADC_bits-1],3'b000,data_out18[2*ADC_bits-2:ADC_bits],11'b00000000000,22'b000000000000000000000};   
assign stage1_input19= {data_out19[2*ADC_bits-1],3'b000,data_out19[2*ADC_bits-2:ADC_bits],11'b00000000000,22'b000000000000000000000}; 
assign stage1_input20= {data_out20[2*ADC_bits-1],3'b000,data_out20[2*ADC_bits-2:ADC_bits],11'b00000000000,22'b000000000000000000000};  
assign stage1_input21= {data_out21[2*ADC_bits-1],3'b000,data_out21[2*ADC_bits-2:ADC_bits],11'b00000000000,22'b000000000000000000000}; 
assign stage1_input22= {data_out22[2*ADC_bits-1],3'b000,data_out22[2*ADC_bits-2:ADC_bits],11'b00000000000,22'b000000000000000000000}; 
assign stage1_input23= {data_out23[2*ADC_bits-1],3'b000,data_out23[2*ADC_bits-2:ADC_bits],11'b00000000000,22'b000000000000000000000}; 
assign stage1_input24= {data_out24[2*ADC_bits-1],3'b000,data_out24[2*ADC_bits-2:ADC_bits],11'b00000000000,22'b000000000000000000000}; 
assign stage1_input25= {data_out25[2*ADC_bits-1],3'b000,data_out25[2*ADC_bits-2:ADC_bits],11'b00000000000,22'b000000000000000000000}; 
assign stage1_input26= {data_out26[2*ADC_bits-1],3'b000,data_out26[2*ADC_bits-2:ADC_bits],11'b00000000000,22'b000000000000000000000}; 
assign stage1_input27= {data_out27[2*ADC_bits-1],3'b000,data_out27[2*ADC_bits-2:ADC_bits],11'b00000000000,22'b000000000000000000000}; 
assign stage1_input28= {data_out28[2*ADC_bits-1],3'b000,data_out28[2*ADC_bits-2:ADC_bits],11'b00000000000,22'b000000000000000000000}; 
assign stage1_input29= {data_out29[2*ADC_bits-1],3'b000,data_out29[2*ADC_bits-2:ADC_bits],11'b00000000000,22'b000000000000000000000}; 
assign stage1_input30= {data_out30[2*ADC_bits-1],3'b000,data_out30[2*ADC_bits-2:ADC_bits],11'b00000000000,22'b000000000000000000000};
assign stage1_input31= {data_out31[2*ADC_bits-1],3'b000,data_out31[2*ADC_bits-2:ADC_bits],11'b00000000000,22'b000000000000000000000}; 
assign stage1_input32= {data_out32[2*ADC_bits-1],3'b000,data_out32[2*ADC_bits-2:ADC_bits],11'b00000000000,22'b000000000000000000000}; 

//contrroller 
controller C (.start(start),.rst_n(rst_n),.clk_50(clk_50),.En1(En1),.En2(En2),.En3(En3),.En4(En4),.sel(selection_line));
// stage one >> here the weight is same for all butterfly = w1
 stage S1 (.data_in1(stage1_input1),.data_in2(stage1_input3),.data_in3(stage1_input5),.data_in4(stage1_input7),          //mux 1 in butterfly1 take 1 2 3 4
           .data_in5(stage1_input2),.data_in6(stage1_input4),.data_in7(stage1_input6),.data_in8(stage1_input8),          //mux 2 in butterfly1 take 5 6 7 8
           .w1(w1),.w2(w1),.w3(w1),.w4(w1),                                                                              //mux 3 in butterfly1  for weight
           .data_in9(stage1_input9),.data_in10(stage1_input11),.data_in11(stage1_input13),.data_in12(stage1_input15),    //mux 1 in butterfly2 take 9  10 11 12
           .data_in13(stage1_input10),.data_in14(stage1_input12),.data_in15(stage1_input14),.data_in16(stage1_input16),  //mux 2 in butterfly2 take 13 14 15 16
           .w5(w1),.w6(w1),.w7(w1),.w8(w1),                                                                              //mux 3 in butterfly2 for weight
           .data_in17(stage1_input17),.data_in18(stage1_input19),.data_in19(stage1_input21),.data_in20(stage1_input23),  //mux 1 in butterfly3 take 17 18 19 20
           .data_in21(stage1_input18),.data_in22(stage1_input20),.data_in23(stage1_input22),.data_in24(stage1_input24),  //mux 2 in butterfly3 take 21 22 23 24
           .w9(w1),.w10(w1),.w11(w1),.w12(w1),                                                                                   //mux 3 in butterfly3 fo weight
           .data_in25(stage1_input25),.data_in26(stage1_input27),.data_in27(stage1_input29),.data_in28(stage1_input31),  //mux 1 in butterfly4 take 25 26 27 28
           .data_in29(stage1_input26),.data_in30(stage1_input28),.data_in31(stage1_input30),.data_in32(stage1_input32),  //mux 2 in butterfly4 take 29 30 31 32
           .w13(w1),.w14(w1),.w15(w1),.w16(w1),                                                                  //mux 3 in butterfly4 for weight
           .rst_n(rst_n),.clk_50(clk_50),.En1(En1),.En2(En2),.En3(En3),.En4(En4),.sel(selection_line),
           .data_out1(stage1_output1),.data_out2(stage1_output2),.data_out3(stage1_output3),.data_out4(stage1_output4),
           .data_out5(stage1_output5),.data_out6(stage1_output6),.data_out7(stage1_output7),.data_out8(stage1_output8),
           .data_out9(stage1_output9),.data_out10(stage1_output10),.data_out11(stage1_output11),.data_out12(stage1_output12),
           .data_out13(stage1_output13),.data_out14(stage1_output14),.data_out15(stage1_output15),.data_out16(stage1_output16),
           .data_out17(stage1_output17),.data_out18(stage1_output18),.data_out19(stage1_output19),.data_out20(stage1_output20),
           .data_out21(stage1_output21),.data_out22(stage1_output22),.data_out23(stage1_output23),.data_out24(stage1_output24),
           .data_out25(stage1_output25),.data_out26(stage1_output26),.data_out27(stage1_output27),.data_out28(stage1_output28),
           .data_out29(stage1_output29),.data_out30(stage1_output30),.data_out31(stage1_output31),.data_out32(stage1_output32));

// take output of stage 1 put in  big register (woork at clk_10)
reg_32 R1 (.data_in1(stage1_output1),.data_in2(stage1_output2),.data_in3(stage1_output3),.data_in4(stage1_output4),         
           .data_in5(stage1_output5),.data_in6(stage1_output6),.data_in7(stage1_output7),.data_in8(stage1_output8),                                                                          
           .data_in9(stage1_output9),.data_in10(stage1_output10),.data_in11(stage1_output11),.data_in12(stage1_output12),    
           .data_in13(stage1_output13),.data_in14(stage1_output14),.data_in15(stage1_output15),.data_in16(stage1_output16),                                                                                
           .data_in17(stage1_output17),.data_in18(stage1_output18),.data_in19(stage1_output19),.data_in20(stage1_output20),                                                                                
           .data_in21(stage1_output21),.data_in22(stage1_output22),.data_in23(stage1_output23),.data_in24(stage1_output24), 
           .data_in25(stage1_output25),.data_in26(stage1_output26),.data_in27(stage1_output27),.data_in28(stage1_output28),
           .data_in29(stage1_output29),.data_in30(stage1_output30),.data_in31(stage1_output31),.data_in32(stage1_output32),
           .clk_10(clk_10) ,.rst_n(rst_n),
           .data_out1(stage2_input1),.data_out2(stage2_input2),.data_out3(stage2_input3),.data_out4(stage2_input4),
           .data_out5(stage2_input5),.data_out6(stage2_input6),.data_out7(stage2_input7),.data_out8(stage2_input8),
           .data_out9(stage2_input9),.data_out10(stage2_input10),.data_out11(stage2_input11),.data_out12(stage2_input12),
           .data_out13(stage2_input13),.data_out14(stage2_input14),.data_out15(stage2_input15),.data_out16(stage2_input16),
           .data_out17(stage2_input17),.data_out18(stage2_input18),.data_out19(stage2_input19),.data_out20(stage2_input20),
           .data_out21(stage2_input21),.data_out22(stage2_input22),.data_out23(stage2_input23),.data_out24(stage2_input24),
           .data_out25(stage2_input25),.data_out26(stage2_input26),.data_out27(stage2_input27),.data_out28(stage2_input28),
           .data_out29(stage2_input29),.data_out30(stage2_input30),.data_out31(stage2_input31),.data_out32(stage2_input32));

//stage 2
 stage S2 (.data_in1(stage2_input1),.data_in2(stage2_input2),.data_in3(stage2_input5),.data_in4(stage2_input6),          //mux 1 in butterfly1 take 1 2 5 6
           .data_in5(stage2_input3),.data_in6(stage2_input4),.data_in7(stage2_input7),.data_in8(stage2_input8),          //mux 2 in butterfly1 take 3 4 7 8
           .w1(w1),.w2(w9),.w3(w1),.w4(w9),                                                                              //mux 3 in butterfly1  for weight w1 w9 w1 w9
           .data_in9(stage2_input9),.data_in10(stage2_input10),.data_in11(stage2_input13),.data_in12(stage2_input14),    //mux 1 in butterfly2 take 9  10 13 14
           .data_in13(stage2_input11),.data_in14(stage2_input12),.data_in15(stage2_input15),.data_in16(stage2_input16),  //mux 2 in butterfly2 take 11 12 15 16
           .w5(w1),.w6(w9),.w7(w1),.w8(w9),                                                                              //mux 3 in butterfly2 for weight w1 w9 w1 w9
           .data_in17(stage2_input17),.data_in18(stage2_input18),.data_in19(stage2_input21),.data_in20(stage2_input22),  //mux 1 in butterfly3 take 17 18 21 22
           .data_in21(stage2_input19),.data_in22(stage2_input20),.data_in23(stage2_input23),.data_in24(stage2_input24),  //mux 2 in butterfly3 take 19 20 23 24
           .w9(w1),.w10(w9),.w11(w1),.w12(w9),                                                                           //mux 3 in butterfly3 fo weight w1 w9 w1 w9
           .data_in25(stage2_input25),.data_in26(stage2_input26),.data_in27(stage2_input29),.data_in28(stage2_input30),  //mux 1 in butterfly4 take 25 26 29 30
           .data_in29(stage2_input27),.data_in30(stage2_input28),.data_in31(stage2_input31),.data_in32(stage2_input32),  //mux 2 in butterfly4 take 27 28 31 32
           .w13(w1),.w14(w9),.w15(w1),.w16(w9),                                                                          //mux 3 in butterfly4 for weight w1 w9 w1 w9
           .rst_n(rst_n),.clk_50(clk_50),.En1(En1),.En2(En2),.En3(En3),.En4(En4),.sel(selection_line),
           .data_out1(stage2_output1),.data_out2(stage2_output3),.data_out3(stage2_output2),.data_out4(stage2_output4),
           .data_out5(stage2_output5),.data_out6(stage2_output7),.data_out7(stage2_output6),.data_out8(stage2_output8),
           .data_out9(stage2_output9),.data_out10(stage2_output11),.data_out11(stage2_output10),.data_out12(stage2_output12),
           .data_out13(stage2_output13),.data_out14(stage2_output15),.data_out15(stage2_output14),.data_out16(stage2_output16),
           .data_out17(stage2_output17),.data_out18(stage2_output19),.data_out19(stage2_output18),.data_out20(stage2_output20),
           .data_out21(stage2_output21),.data_out22(stage2_output23),.data_out23(stage2_output22),.data_out24(stage2_output24),
           .data_out25(stage2_output25),.data_out26(stage2_output27),.data_out27(stage2_output26),.data_out28(stage2_output28),
           .data_out29(stage2_output29),.data_out30(stage2_output31),.data_out31(stage2_output30),.data_out32(stage2_output32));
// take output of stage 2 put in  big register (woork at clk_10)
reg_32 R2 (.data_in1(stage2_output1),.data_in2(stage2_output2),.data_in3(stage2_output3),.data_in4(stage2_output4),         
           .data_in5(stage2_output5),.data_in6(stage2_output6),.data_in7(stage2_output7),.data_in8(stage2_output8),                                                                          
           .data_in9(stage2_output9),.data_in10(stage2_output10),.data_in11(stage2_output11),.data_in12(stage2_output12),    
           .data_in13(stage2_output13),.data_in14(stage2_output14),.data_in15(stage2_output15),.data_in16(stage2_output16),                                                                              
           .data_in17(stage2_output17),.data_in18(stage2_output18),.data_in19(stage2_output19),.data_in20(stage2_output20),                                                                               
           .data_in21(stage2_output21),.data_in22(stage2_output22),.data_in23(stage2_output23),.data_in24(stage2_output24), 
           .data_in25(stage2_output25),.data_in26(stage2_output26),.data_in27(stage2_output27),.data_in28(stage2_output28),
           .data_in29(stage2_output29),.data_in30(stage2_output30),.data_in31(stage2_output31),.data_in32(stage2_output32),
           .clk_10(clk_10) ,.rst_n(rst_n),
           .data_out1(stage3_input1),.data_out2(stage3_input2),.data_out3(stage3_input3),.data_out4(stage3_input4),
           .data_out5(stage3_input5),.data_out6(stage3_input6),.data_out7(stage3_input7),.data_out8(stage3_input8),
           .data_out9(stage3_input9),.data_out10(stage3_input10),.data_out11(stage3_input11),.data_out12(stage3_input12),
           .data_out13(stage3_input13),.data_out14(stage3_input14),.data_out15(stage3_input15),.data_out16(stage3_input16),
           .data_out17(stage3_input17),.data_out18(stage3_input18),.data_out19(stage3_input19),.data_out20(stage3_input20),
           .data_out21(stage3_input21),.data_out22(stage3_input22),.data_out23(stage3_input23),.data_out24(stage3_input24),
           .data_out25(stage3_input25),.data_out26(stage3_input26),.data_out27(stage3_input27),.data_out28(stage3_input28),
           .data_out29(stage3_input29),.data_out30(stage3_input30),.data_out31(stage3_input31),.data_out32(stage3_input32));


//stage 3
 stage S3 (.data_in1(stage3_input1),.data_in2(stage3_input2),.data_in3(stage3_input3),.data_in4(stage3_input4),           //mux 1 in butterfly1 take 1 2 3 4
           .data_in5(stage3_input5),.data_in6(stage3_input6),.data_in7(stage3_input7),.data_in8(stage3_input8),           //mux 2 in butterfly1 take 5 6 7 8
           .w1(w1),.w2(w5),.w3(w9),.w4(w13),                                                                              //mux 3 in butterfly1  for weight w1 w5 w9 w13
           .data_in9(stage3_input9),.data_in10(stage3_input10),.data_in11(stage3_input11),.data_in12(stage3_input12),     //mux 1 in butterfly2 take 9  10 11 12
           .data_in13(stage3_input13),.data_in14(stage3_input14),.data_in15(stage3_input15),.data_in16(stage3_input16),   //mux 2 in butterfly2 take 13 14 15 16
           .w5(w1),.w6(w5),.w7(w9),.w8(w13),                                                                              //mux 3 in butterfly2 for weight w1 w5 w9 w13
           .data_in17(stage3_input17),.data_in18(stage3_input18),.data_in19(stage3_input19),.data_in20(stage3_input20),   //mux 1 in butterfly3 take 17 18 19 20
           .data_in21(stage3_input21),.data_in22(stage3_input22),.data_in23(stage3_input23),.data_in24(stage3_input24),   //mux 2 in butterfly3 take 21 22 23 24
           .w9(w1),.w10(w5),.w11(w9),.w12(w13),                                                                           //mux 3 in butterfly3 fo weight w1 w5 w9 w13
           .data_in25(stage3_input25),.data_in26(stage3_input26),.data_in27(stage3_input27),.data_in28(stage3_input28),   //mux 1 in butterfly4 take 25 26 27 28
           .data_in29(stage3_input29),.data_in30(stage3_input30),.data_in31(stage3_input31),.data_in32(stage3_input32),   //mux 2 in butterfly4 take 29 30 31 32
           .w13(w1),.w14(w5),.w15(w9),.w16(w13),                                                                          //mux 3 in butterfly4 for weight w1 w5 w9 w13
           .rst_n(rst_n),.clk_50(clk_50),.En1(En1),.En2(En2),.En3(En3),.En4(En4),.sel(selection_line),
           .data_out1(stage3_output1),.data_out2(stage3_output5),.data_out3(stage3_output2),.data_out4(stage3_output6),
           .data_out5(stage3_output3),.data_out6(stage3_output7),.data_out7(stage3_output4),.data_out8(stage3_output8),
           .data_out9(stage3_output9),.data_out10(stage3_output13),.data_out11(stage3_output10),.data_out12(stage3_output14),
           .data_out13(stage3_output11),.data_out14(stage3_output15),.data_out15(stage3_output12),.data_out16(stage3_output16),
           .data_out17(stage3_output17),.data_out18(stage3_output21),.data_out19(stage3_output18),.data_out20(stage3_output22),
           .data_out21(stage3_output19),.data_out22(stage3_output23),.data_out23(stage3_output20),.data_out24(stage3_output24),
           .data_out25(stage3_output25),.data_out26(stage3_output29),.data_out27(stage3_output26),.data_out28(stage3_output30),
           .data_out29(stage3_output27),.data_out30(stage3_output31),.data_out31(stage3_output28),.data_out32(stage3_output32));
// take output of stage 3 put in  big register (woork at clk_10)
reg_32 R3 (.data_in1(stage3_output1),.data_in2(stage3_output2),.data_in3(stage3_output3),.data_in4(stage3_output4),         
           .data_in5(stage3_output5),.data_in6(stage3_output6),.data_in7(stage3_output7),.data_in8(stage3_output8),                                                                          
           .data_in9(stage3_output9),.data_in10(stage3_output10),.data_in11(stage3_output11),.data_in12(stage3_output12),    
           .data_in13(stage3_output13),.data_in14(stage3_output14),.data_in15(stage3_output15),.data_in16(stage3_output16),                                                                                
           .data_in17(stage3_output17),.data_in18(stage3_output18),.data_in19(stage3_output19),.data_in20(stage3_output20),                                                                                
           .data_in21(stage3_output21),.data_in22(stage3_output22),.data_in23(stage3_output23),.data_in24(stage3_output24), 
           .data_in25(stage3_output25),.data_in26(stage3_output26),.data_in27(stage3_output27),.data_in28(stage3_output28),
           .data_in29(stage3_output29),.data_in30(stage3_output30),.data_in31(stage3_output31),.data_in32(stage3_output32),
           .clk_10(clk_10) ,.rst_n(rst_n),
           .data_out1(stage4_input1),.data_out2(stage4_input2),.data_out3(stage4_input3),.data_out4(stage4_input4),
           .data_out5(stage4_input5),.data_out6(stage4_input6),.data_out7(stage4_input7),.data_out8(stage4_input8),
           .data_out9(stage4_input9),.data_out10(stage4_input10),.data_out11(stage4_input11),.data_out12(stage4_input12),
           .data_out13(stage4_input13),.data_out14(stage4_input14),.data_out15(stage4_input15),.data_out16(stage4_input16),
           .data_out17(stage4_input17),.data_out18(stage4_input18),.data_out19(stage4_input19),.data_out20(stage4_input20),
           .data_out21(stage4_input21),.data_out22(stage4_input22),.data_out23(stage4_input23),.data_out24(stage4_input24),
           .data_out25(stage4_input25),.data_out26(stage4_input26),.data_out27(stage4_input27),.data_out28(stage4_input28),
           .data_out29(stage4_input29),.data_out30(stage4_input30),.data_out31(stage4_input31),.data_out32(stage4_input32));
  //stage 4         
 stage S4 (.data_in1(stage4_input1),.data_in2(stage4_input2),.data_in3(stage4_input3),.data_in4(stage4_input4),           //mux 1 in butterfly1 take 1 2 3 4
           .data_in5(stage4_input9),.data_in6(stage4_input10),.data_in7(stage4_input11),.data_in8(stage4_input12),           //mux 2 in butterfly1 take 9 10 11 12
           .w1(w1),.w2(w3),.w3(w5),.w4(w7),                                                                              //mux 3 in butterfly1  for weight w1 w3 w5 w7
           .data_in9(stage4_input5),.data_in10(stage4_input6),.data_in11(stage4_input7),.data_in12(stage4_input8),     //mux 1 in butterfly2 take 5 6 7 8
           .data_in13(stage4_input13),.data_in14(stage4_input14),.data_in15(stage4_input15),.data_in16(stage4_input16),   //mux 2 in butterfly2 take 13 14 15 16
           .w5(w9),.w6(w11),.w7(w13),.w8(w15),                                                                              //mux 3 in butterfly2 for weight w9 w11 w13 w15
           .data_in17(stage4_input17),.data_in18(stage4_input18),.data_in19(stage4_input19),.data_in20(stage4_input20),   //mux 1 in butterfly3 take 17 18 19 20
           .data_in21(stage4_input25),.data_in22(stage4_input26),.data_in23(stage4_input27),.data_in24(stage4_input28),   //mux 2 in butterfly3 take 25 26 27 28
           .w9(w1),.w10(w3),.w11(w5),.w12(w7),                                                                           //mux 3 in butterfly3 fo weight w1 w3 w5 w7
           .data_in25(stage4_input21),.data_in26(stage4_input22),.data_in27(stage4_input23),.data_in28(stage4_input24),   //mux 1 in butterfly4 take 21 22 23 24
           .data_in29(stage4_input29),.data_in30(stage4_input30),.data_in31(stage4_input31),.data_in32(stage4_input32),   //mux 2 in butterfly4 take 29 30 31 32
           .w13(w9),.w14(w11),.w15(w13),.w16(w15),                                                                          //mux 3 in butterfly4 for weight w9 w11 w13 w15
           .rst_n(rst_n),.clk_50(clk_50),.En1(En1),.En2(En2),.En3(En3),.En4(En4),.sel(selection_line),
           .data_out1(stage4_output1),.data_out2(stage4_output9),.data_out3(stage4_output2),.data_out4(stage4_output10),
           .data_out5(stage4_output3),.data_out6(stage4_output11),.data_out7(stage4_output4),.data_out8(stage4_output12),
           .data_out9(stage4_output5),.data_out10(stage4_output13),.data_out11(stage4_output6),.data_out12(stage4_output14),
           .data_out13(stage4_output7),.data_out14(stage4_output15),.data_out15(stage4_output8),.data_out16(stage4_output16),
           .data_out17(stage4_output17),.data_out18(stage4_output25),.data_out19(stage4_output18),.data_out20(stage4_output26),
           .data_out21(stage4_output19),.data_out22(stage4_output27),.data_out23(stage4_output20),.data_out24(stage4_output28),
           .data_out25(stage4_output21),.data_out26(stage4_output29),.data_out27(stage4_output22),.data_out28(stage4_output30),
           .data_out29(stage4_output23),.data_out30(stage4_output31),.data_out31(stage4_output24),.data_out32(stage4_output32));

// take output of stage 3 put in  big register (woork at clk_10)
reg_32 R4 (.data_in1(stage4_output1),.data_in2(stage4_output2),.data_in3(stage4_output3),.data_in4(stage4_output4),         
           .data_in5(stage4_output5),.data_in6(stage4_output6),.data_in7(stage4_output7),.data_in8(stage4_output8),                                                                          
           .data_in9(stage4_output9),.data_in10(stage4_output10),.data_in11(stage4_output11),.data_in12(stage4_output12),    
           .data_in13(stage4_output13),.data_in14(stage4_output14),.data_in15(stage4_output15),.data_in16(stage4_output16),                                                                                
           .data_in17(stage4_output17),.data_in18(stage4_output18),.data_in19(stage4_output19),.data_in20(stage4_output20),                                                                                
           .data_in21(stage4_output21),.data_in22(stage4_output22),.data_in23(stage4_output23),.data_in24(stage4_output24), 
           .data_in25(stage4_output25),.data_in26(stage4_output26),.data_in27(stage4_output27),.data_in28(stage4_output28),
           .data_in29(stage4_output29),.data_in30(stage4_output30),.data_in31(stage4_output31),.data_in32(stage4_output32),
           .clk_10(clk_10) ,.rst_n(rst_n),
           .data_out1(stage5_input1),.data_out2(stage5_input2),.data_out3(stage5_input3),.data_out4(stage5_input4),
           .data_out5(stage5_input5),.data_out6(stage5_input6),.data_out7(stage5_input7),.data_out8(stage5_input8),
           .data_out9(stage5_input9),.data_out10(stage5_input10),.data_out11(stage5_input11),.data_out12(stage5_input12),
           .data_out13(stage5_input13),.data_out14(stage5_input14),.data_out15(stage5_input15),.data_out16(stage5_input16),
           .data_out17(stage5_input17),.data_out18(stage5_input18),.data_out19(stage5_input19),.data_out20(stage5_input20),
           .data_out21(stage5_input21),.data_out22(stage5_input22),.data_out23(stage5_input23),.data_out24(stage5_input24),
           .data_out25(stage5_input25),.data_out26(stage5_input26),.data_out27(stage5_input27),.data_out28(stage5_input28),
           .data_out29(stage5_input29),.data_out30(stage5_input30),.data_out31(stage5_input31),.data_out32(stage5_input32));
//stage5
 stage S5 (.data_in1(stage5_input1),.data_in2(stage5_input2),.data_in3(stage5_input3),.data_in4(stage5_input4),           //mux 1 in butterfly1 take 1 2 3 4
           .data_in5(stage5_input17),.data_in6(stage5_input18),.data_in7(stage5_input19),.data_in8(stage5_input20),           //mux 2 in butterfly1 take 17 18 19 20
           .w1(w1),.w2(w2),.w3(w3),.w4(w4),                                                                              //mux 3 in butterfly1  for weight w1 w2 w3 w4
           .data_in9(stage5_input5),.data_in10(stage5_input6),.data_in11(stage5_input7),.data_in12(stage5_input8),     //mux 1 in butterfly2 take 5 6 7 8
           .data_in13(stage5_input21),.data_in14(stage5_input22),.data_in15(stage5_input23),.data_in16(stage5_input24),   //mux 2 in butterfly2 take 21 22 23 24
           .w5(w5),.w6(w6),.w7(w7),.w8(w8),                                                                              //mux 3 in butterfly2 for weight w5 w6 w7 w8
           .data_in17(stage5_input9),.data_in18(stage5_input10),.data_in19(stage5_input11),.data_in20(stage5_input12),   //mux 1 in butterfly3 take 9 10 11 12
           .data_in21(stage5_input25),.data_in22(stage5_input26),.data_in23(stage5_input27),.data_in24(stage5_input28),   //mux 2 in butterfly3 take 25 26 27 28
           .w9(w9),.w10(w10),.w11(w11),.w12(w12),                                                                           //mux 3 in butterfly3 fo weight w9 w10 w11 w12
           .data_in25(stage5_input13),.data_in26(stage5_input14),.data_in27(stage5_input15),.data_in28(stage5_input16),   //mux 1 in butterfly4 take 13 14 15 16
           .data_in29(stage5_input29),.data_in30(stage5_input30),.data_in31(stage5_input31),.data_in32(stage5_input32),   //mux 2 in butterfly4 take 29 30 31 32
           .w13(w13),.w14(w14),.w15(w15),.w16(w16),                                                                          //mux 3 in butterfly4 for weight w13 w14 w15 w16
           .rst_n(rst_n),.clk_50(clk_50),.En1(En1),.En2(En2),.En3(En3),.En4(En4),.sel(selection_line),
           .data_out1(stage5_output1),.data_out2(stage5_output17),.data_out3(stage5_output2),.data_out4(stage5_output18),
           .data_out5(stage5_output3),.data_out6(stage5_output19),.data_out7(stage5_output4),.data_out8(stage5_output20),
           .data_out9(stage5_output5),.data_out10(stage5_output21),.data_out11(stage5_output6),.data_out12(stage5_output22),
           .data_out13(stage5_output7),.data_out14(stage5_output23),.data_out15(stage5_output8),.data_out16(stage5_output24),
           .data_out17(stage5_output9),.data_out18(stage5_output25),.data_out19(stage5_output10),.data_out20(stage5_output26),
           .data_out21(stage5_output11),.data_out22(stage5_output27),.data_out23(stage5_output12),.data_out24(stage5_output28),
           .data_out25(stage5_output13),.data_out26(stage5_output29),.data_out27(stage5_output14),.data_out28(stage5_output30),
           .data_out29(stage5_output15),.data_out30(stage5_output31),.data_out31(stage5_output16),.data_out32(stage5_output32));

// take output of stage 3 put in  big register (woork at clk_10)
reg_32 R5 (.data_in1(stage5_output1),.data_in2(stage5_output2),.data_in3(stage5_output3),.data_in4(stage5_output4),         
           .data_in5(stage5_output5),.data_in6(stage5_output6),.data_in7(stage5_output7),.data_in8(stage5_output8),                                                                          
           .data_in9(stage5_output9),.data_in10(stage5_output10),.data_in11(stage5_output11),.data_in12(stage5_output12),    
           .data_in13(stage5_output13),.data_in14(stage5_output14),.data_in15(stage5_output15),.data_in16(stage5_output16),                                                                                
           .data_in17(stage5_output17),.data_in18(stage5_output18),.data_in19(stage5_output19),.data_in20(stage5_output20),                                                                                
           .data_in21(stage5_output21),.data_in22(stage5_output22),.data_in23(stage5_output23),.data_in24(stage5_output24), 
           .data_in25(stage5_output25),.data_in26(stage5_output26),.data_in27(stage5_output27),.data_in28(stage5_output28),
           .data_in29(stage5_output29),.data_in30(stage5_output30),.data_in31(stage5_output31),.data_in32(stage5_output32),
           .clk_10(clk_10) ,.rst_n(rst_n),
           .data_out1(out1),.data_out2(out2),.data_out3(out3),.data_out4(out4),
           .data_out5(out5),.data_out6(out6),.data_out7(out7),.data_out8(out8),
           .data_out9(out9),.data_out10(out10),.data_out11(out11),.data_out12(out12),
           .data_out13(out13),.data_out14(out14),.data_out15(out15),.data_out16(out16),
           .data_out17(out17),.data_out18(out18),.data_out19(out19),.data_out20(out20),
           .data_out21(out21),.data_out22(out22),.data_out23(out23),.data_out24(out24),
           .data_out25(out25),.data_out26(out26),.data_out27(out27),.data_out28(out28),
           .data_out29(out29),.data_out30(out30),.data_out31(out31),.data_out32(out32));



endmodule
