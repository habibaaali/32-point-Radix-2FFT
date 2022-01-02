
//mac module work on real and img individuall 

module mac#(
	//Parameterized values
	parameter number_bits=22, // 1 sign >> 9 int (3ovr +7 data)>> 11 fraction 
	parameter Q=12, //for weight
	parameter add=1'b0, // flag to add 2 numers
	parameter sub=1'b1 // flag to sub 2 numers
	)
(
input   [number_bits-1:0]  x_real,
input   [number_bits-1:0]  x_img,
input   [number_bits-1:0]  y_real,
input   [number_bits-1:0]  y_img,
input   [Q-1:0]  w_real,
input   [Q-1:0]  w_img,
output  [number_bits-1:0]  out1_real,
output  [number_bits-1:0]  out1_img, //for+
output  [number_bits-1:0]  out2_real,
output  [number_bits-1:0]  out2_img//for-
 );
 wire   [number_bits-1:0] real_real;
 wire   [number_bits-1:0] real_img;
 wire   [number_bits-1:0] img_img;
 wire   [number_bits-1:0] img_real;
 wire   [number_bits-1:0] out_img;
 wire   [number_bits-1:0] out_real;
  /*
  out=y (+ ,-)G     G =w*x  >>>>  complex num has real and img parts  >>   Greal= wr*xr-wi*xi  &&  Gimg=wr*xi+wi*xr  
  
out_real=y_real + G_real  &&    out_real=y_real - G_real  
out_img=y_img + G_img     &&    out_img=y_img   - G_img 
  
  */
  //************************************* G= w*x*************************
multi32  m1(.num(x_real),.weight(w_real),.out(real_real)); //wr*xr
multi32  m2(.num(x_real),.weight(w_img),.out(real_img)); //wi*xi
multi32  m3(.num(x_img),.weight (w_real),.out(img_real));//wr*xi
multi32  m4(.num(x_img),.weight (w_img),.out(img_img)); //wi*xr  

//**********************************   get G   *********************************************
adder_subtractor A1 (.din_1(real_real),.din_2(img_img),.flag(sub),.dout(out_real)); //Greal= wr*xr-wi*xi
adder_subtractor A2 (.din_1(real_img),.din_2(img_real),.flag(add),.dout(out_img)); //Gimg=wr*xi+wi*xr  

//********************************** out =y+G  (y+wx)*********************************************
adder_subtractor A3 (.din_1(y_real),.din_2(out_real),.flag(add),.dout(out1_real));  //out_real=y_real + G_real
adder_subtractor A4 (.din_1(y_img),.din_2(out_img),.flag(add),.dout(out1_img));    //out_img=y_img + G_img  

//********************************** out =y-G (y-wx)*********************************************
adder_subtractor A5 (.din_1(y_real),.din_2(out_real),.flag(sub),.dout(out2_real));
adder_subtractor A6 (.din_1(y_img),.din_2(out_img),.flag(sub),.dout(out2_img)); 
endmodule
