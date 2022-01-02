

module adder_subtractor#(parameter number_bits=22,
	                     parameter N=32,
	                     parameter Q=8)
(
input flag,
input [number_bits-1:0]din_1,
input [number_bits-1:0]din_2,
output reg [number_bits-1:0]dout
);
reg [number_bits-1:0] num2; // to convert - to +
reg [number_bits-1:0] in1; // for biggest number
reg [number_bits-1:0] in2; // for small number

always@(*)
    begin
     //**************** if i want to sub so i should change the sign of second number to coonvert - to + ****************
        if(flag)
           num2={~din_2[number_bits-1],din_2[number_bits-2:0]};
        else
           num2={din_2[number_bits-1],din_2[number_bits-2:0]};
     //************************************************************************************************
     //************************ put the bigggest number in in1 *************************
         if (din_1[number_bits-2:0] > num2[number_bits-2:0] )
            begin
                in1=din_1;
                in2=num2;
            end
         else
             begin
                in1=num2;
                in2=din_1;
             end
      //************************************************************************************************   
      
      //************************   ask about sign of two numbere if 00 11 10 10  **********************   
          if (in1[number_bits-1] ^ in2[number_bits-1] )
              begin
                // if two numbers have diff signs (10 or 01) so in1-in2
                dout[number_bits-2:0]= in1[number_bits-2:0]-in2[number_bits-2:0];
              end
          else
              begin
               // if two numbers have the same sign  (11 or 00)so in1+in2
                dout[number_bits-2:0]= in1[number_bits-2:0]+in2[number_bits-2:0];
                
              end
     //************************************************************************************************  
      
    //************************  to prevent that  (-0 or +0) as i should have only (+0)  ****************         
          if (dout[number_bits-2:0]==0)
               dout[number_bits-1]=0;
          else
               dout[number_bits-1]=in1[number_bits-1]; // tkae sign oof biggest number
     //************************************************************************************************        
    end
endmodule
