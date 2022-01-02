module multi32 #(parameter number_bits=22, // 1 bit sign +9 int ( 3 ovr + 7 data)+ 11 fraction
                 parameter weight_bits=12   // [1 bit sign + 11 data] (fraction)
	            )
(

  input  wire [number_bits-1:0]  num,          // 21-bit  input  data
  input  wire [weight_bits-1:0]  weight,      // 8-bit   input  data weight +1 bit sign
  output reg  [number_bits-1:0]   out        // 21-bit output data
  );

  wire        flag;                           // determine the sign of the product
  wire [number_bits+weight_bits-1-1:0] mul;
  wire [number_bits-1-1:0]cut_data;            //20 bits for data without sign
  reg  [number_bits+weight_bits-1-1:0] result_of_product; // 20bits *11 bits  =30data +1 ovr = 31 bits >>>> product without sign

//**************************** multiplication (weight and num without sign) ****************************
  always @ ( * ) begin
    case ( weight [weight_bits-1-1:0] )
      11'b00000000000: result_of_product = 31'b0;
      11'b11111011000: result_of_product = ( num[number_bits-2:0] << 3 ) +( num[number_bits-2:0] << 4 )+( num[number_bits-2:0] << 6 )+( num[number_bits-2:0] << 7 )+ ( num[number_bits-2:0] << 8 ) + ( num[number_bits-2:0] << 9 ) + ( num[number_bits-2:0] << 10 ); //0.9807
      11'b11101100100: result_of_product = ( num[number_bits-2:0] << 2 ) + ( num[number_bits-2:0] <<5 ) + ( num[number_bits-2:0] << 6 ) + ( num[number_bits-2:0] << 8 )+( num[number_bits-2:0] << 9 )+ ( num[number_bits-2:0] << 10 ); //0.9238
      11'b11010100111: result_of_product = ( num[number_bits-2:0] << 0 ) + ( num[number_bits-2:0] << 1 ) + ( num[number_bits-2:0] << 2 )  + ( num[number_bits-2:0] << 5 ) + ( num[number_bits-2:0] << 7 )+ ( num[number_bits-2:0] << 9 )+ ( num[number_bits-2:0] << 10 ); //0.8314
      11'b10110101000: result_of_product = ( num[number_bits-2:0] << 3 ) + ( num[number_bits-2:0] << 5 ) + ( num[number_bits-2:0] << 7 )  + ( num[number_bits-2:0] << 8 ) + ( num[number_bits-2:0] << 10 );//0.7071  
      11'b10001110010: result_of_product = ( num[number_bits-2:0] << 1 ) + ( num[number_bits-2:0] << 4 )+( num[number_bits-2:0] << 5 )+( num[number_bits-2:0] << 6 )+ ( num[number_bits-2:0] << 10 );//0.5555
      11'b01100010000: result_of_product = ( num[number_bits-2:0] << 4 ) + ( num[number_bits-2:0] << 8 )+( num[number_bits-2:0] << 9 );//0.3826
      11'b00110001111: result_of_product = ( num[number_bits-2:0] << 0 ) + ( num[number_bits-2:0] << 1 )+( num[number_bits-2:0] << 2 )+ ( num[number_bits-2:0] << 3 )+ ( num[number_bits-2:0] <<7 )+ ( num[number_bits-2:0] << 8 );//0.1950
      11'b11111111111: result_of_product = ( num[number_bits-2:0] << 11 ) ;// this will persent -1 and 1 as 1 11111111
      default: result_of_product= 31'b0;
    endcase
  end
//**********************************************************************************************************************************
//******************************* Determine the sign of the product. **************************************************************
  assign  flag  = num[number_bits-1] ^ weight[weight_bits-1];  
//******************************* result of product is reg and. **************************************************************               
  assign cut_data = result_of_product[30:weight_bits-1];  //[(number_bits-1) +(weight_bits-1)]- 1(sign) =30
//**********************************************************************************************************************************
  
 //if weight is 0 and num is -ve i want out to be +0 not -0 
  always@(*)
    begin
        if(result_of_product==0)
          out= 0;
        else
          out= {flag,cut_data} ;
    end
  
endmodule