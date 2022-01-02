module butterfly#(
	//Parameterized values
	parameter number_bits=22, // 1 sign >> 9 int (3ovr +7 data)>> 11 fraction 
	parameter weight_bits=12 //for weight
	) 
(
input [2*number_bits-1:0] in1,
input [2*number_bits-1:0] in2,
input [2*number_bits-1:0] in3,
input [2*number_bits-1:0] in4,
input [2*number_bits-1:0] in5,
input [2*number_bits-1:0] in6,
input [2*number_bits-1:0] in7,
input [2*number_bits-1:0] in8,
input [2*weight_bits-1:0] w1,
input [2*weight_bits-1:0] w2,
input [2*weight_bits-1:0] w3,
input [2*weight_bits-1:0] w4,
input [1:0]  sel,
input en1, 
input en2,
input en3,
input en4,
input clk_50,
input rst_n,
output [2*number_bits-1:0] out1,
output [2*number_bits-1:0] out2,
output [2*number_bits-1:0] out3,
output [2*number_bits-1:0] out4,
output [2*number_bits-1:0] out5,
output [2*number_bits-1:0] out6,
output [2*number_bits-1:0] out7,
output [2*number_bits-1:0] out8
    );
    
    
    wire [2*number_bits-1:0] in1_mac; //real+img
    wire [2*number_bits-1:0] in2_mac;
    wire [2*weight_bits-1:0] weight_mac; 
    wire [2*number_bits-1:0] out1_mac; // to concatenate real + img outed from mac for +
    wire [2*number_bits-1:0] out2_mac; // to concatenate real + img outed from mac for -
    
 //*************************************** 3 MUX for data and weight first 4 inputs for M1 and second is for M 2***********************************************************   
    mux4_1 M1 (.input1(in1),.input2(in2),.input3(in3),.input4(in4),.sel(sel),.mux_out(in1_mac));
    mux4_1 M2 (.input1(in5),.input2(in6),.input3(in7),.input4(in8),.sel(sel),.mux_out(in2_mac));
    mux4_1 #(.number_bits(weight_bits)) M3 (.input1(w1),.input2(w2),.input3(w3),.input4(w4),.sel(sel),.mux_out(weight_mac));
   
   
   
   

    mac    m    (.x_real(in2_mac[2*number_bits-1:number_bits]),.x_img (in2_mac[number_bits-1:0]),
                 .y_real(in1_mac[2*number_bits-1:number_bits]),.y_img(in1_mac[number_bits-1:0]),
                 .w_real(weight_mac [2*weight_bits-1:weight_bits]),.w_img(weight_mac[weight_bits-1:0]),
                 .out1_real(out1_mac[2*number_bits-1:number_bits]),.out1_img(out1_mac[number_bits-1:0]), // for +w
                 .out2_real(out2_mac[2*number_bits-1:number_bits]),.out2_img(out2_mac[number_bits-1:0])); //for -w
               
               
               
               
               
    //8 small reg to store out of  mac
    small_reg r1_pos(.data_in(out1_mac),.clk_50(clk_50),.rst_n(rst_n),.en(en1),.data_out(out1)); //+w
    small_reg r1_neg(.data_in(out2_mac),.clk_50(clk_50),.rst_n(rst_n),.en(en1),.data_out(out2)); //-w
    
    small_reg r2_pos(.data_in(out1_mac),.clk_50(clk_50),.rst_n(rst_n),.en(en2),.data_out(out3));
    small_reg r2_neg(.data_in(out2_mac),.clk_50(clk_50),.rst_n(rst_n),.en(en2),.data_out(out4));
    
    small_reg r3_pos(.data_in(out1_mac),.clk_50(clk_50),.rst_n(rst_n),.en(en3),.data_out(out5));
    small_reg r3_neg(.data_in(out2_mac),.clk_50(clk_50),.rst_n(rst_n),.en(en3),.data_out(out6));
    
    small_reg r4_pos(.data_in(out1_mac),.clk_50(clk_50),.rst_n(rst_n),.en(en4),.data_out(out7));
    small_reg r4_neg(.data_in(out2_mac),.clk_50(clk_50),.rst_n(rst_n),.en(en4),.data_out(out8));
    
    
    
    
    
    
endmodule
