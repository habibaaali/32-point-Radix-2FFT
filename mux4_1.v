

module mux4_1 #(parameter number_bits=22) 

(
input [2*number_bits-1:0] input1,
input [2*number_bits-1:0] input2,
input [2*number_bits-1:0] input3,
input [2*number_bits-1:0] input4,
input [1:0] sel,
output   reg [2*number_bits-1:0] mux_out);

always @(*)
begin
     case (sel)
     2'b00: mux_out=input1;
     2'b01: mux_out=input2;
     2'b10:mux_out=input3;
     default: mux_out=input4;
    endcase
end
endmodule
