
// take 32 inputs  >>num =8 real+8 img >>int data only
module reverse_bit#(
	parameter ADC_bits= 8)
(
input  [ADC_bits-1:0]  data_in_real1,
input  [ADC_bits-1:0]  data_in_real2,
input  [ADC_bits-1:0]  data_in_real3,
input  [ADC_bits-1:0]  data_in_real4,
input  [ADC_bits-1:0]  data_in_real5,
input  [ADC_bits-1:0]  data_in_real6,
input  [ADC_bits-1:0]  data_in_real7,
input  [ADC_bits-1:0]  data_in_real8,
input  [ADC_bits-1:0]  data_in_real9,
input  [ADC_bits-1:0]  data_in_real10,
input  [ADC_bits-1:0]  data_in_real11,
input  [ADC_bits-1:0]  data_in_real12,
input  [ADC_bits-1:0]  data_in_real13,
input  [ADC_bits-1:0]  data_in_real14,
input  [ADC_bits-1:0]  data_in_real15,
input  [ADC_bits-1:0]  data_in_real16,
input  [ADC_bits-1:0]  data_in_real17,
input  [ADC_bits-1:0]  data_in_real18,
input  [ADC_bits-1:0]  data_in_real19,
input  [ADC_bits-1:0]  data_in_real20,
input  [ADC_bits-1:0]  data_in_real21,
input  [ADC_bits-1:0]  data_in_real22,
input  [ADC_bits-1:0]  data_in_real23,
input  [ADC_bits-1:0]  data_in_real24,
input  [ADC_bits-1:0]  data_in_real25,
input  [ADC_bits-1:0]  data_in_real26,
input  [ADC_bits-1:0]  data_in_real27,
input  [ADC_bits-1:0]  data_in_real28,
input  [ADC_bits-1:0]  data_in_real29,
input  [ADC_bits-1:0]  data_in_real30,
input  [ADC_bits-1:0]  data_in_real31,
input  [ADC_bits-1:0]  data_in_real32,


output reg [ADC_bits-1:0]  data_out_real1,
output reg [ADC_bits-1:0]  data_out_real2,
output reg [ADC_bits-1:0]  data_out_real3,
output reg [ADC_bits-1:0]  data_out_real4,
output reg [ADC_bits-1:0]  data_out_real5,
output reg [ADC_bits-1:0]  data_out_real6,
output reg [ADC_bits-1:0]  data_out_real7,
output reg [ADC_bits-1:0]  data_out_real8,
output reg [ADC_bits-1:0]  data_out_real9,
output reg [ADC_bits-1:0]  data_out_real10,
output reg [ADC_bits-1:0]  data_out_real11,
output reg [ADC_bits-1:0]  data_out_real12,
output reg [ADC_bits-1:0]  data_out_real13,
output reg [ADC_bits-1:0]  data_out_real14,
output reg [ADC_bits-1:0]  data_out_real15,
output reg [ADC_bits-1:0]  data_out_real16,
output reg [ADC_bits-1:0]  data_out_real17,
output reg [ADC_bits-1:0]  data_out_real18,
output reg [ADC_bits-1:0]  data_out_real19,
output reg [ADC_bits-1:0]  data_out_real20,
output reg [ADC_bits-1:0]  data_out_real21,
output reg [ADC_bits-1:0]  data_out_real22,
output reg [ADC_bits-1:0]  data_out_real23,
output reg [ADC_bits-1:0]  data_out_real24,
output reg [ADC_bits-1:0]  data_out_real25,
output reg [ADC_bits-1:0]  data_out_real26,
output reg [ADC_bits-1:0]  data_out_real27,
output reg [ADC_bits-1:0]  data_out_real28,
output reg [ADC_bits-1:0]  data_out_real29,
output reg [ADC_bits-1:0]  data_out_real30,
output reg [ADC_bits-1:0]  data_out_real31,
output reg [ADC_bits-1:0]  data_out_real32
);

always @(*)
    begin
          data_out_real1=data_in_real1;
          data_out_real2=data_in_real17;
          data_out_real3=data_in_real9;
          data_out_real4=data_in_real25;
          data_out_real5=data_in_real5;
          data_out_real6=data_in_real21;
          data_out_real7=data_in_real13;
          data_out_real8=data_in_real29;
          data_out_real9=data_in_real3;
          data_out_real10=data_in_real19;
          data_out_real11=data_in_real11;
          data_out_real12=data_in_real27;
          data_out_real13=data_in_real7;
          data_out_real14=data_in_real23;
          data_out_real15=data_in_real15;
          data_out_real16=data_in_real31;
          data_out_real17=data_in_real2;
          data_out_real18=data_in_real18;
          data_out_real19=data_in_real10;
          data_out_real20=data_in_real26;
          data_out_real21=data_in_real6;
          data_out_real22=data_in_real22;
          data_out_real23=data_in_real14;
          data_out_real24=data_in_real30;
          data_out_real25=data_in_real4;
          data_out_real26=data_in_real20;
          data_out_real27=data_in_real12;
          data_out_real28=data_in_real28;
          data_out_real29=data_in_real8;
          data_out_real30=data_in_real24;
          data_out_real31=data_in_real16;
          data_out_real32=data_in_real32;
    end

endmodule
    

