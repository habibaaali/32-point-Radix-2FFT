module demux1_4#(parameter number_bits=16)
(
input [number_bits-1:0] in,
input [1:0] sel,
output reg  [number_bits-1:0] out1,
output reg [number_bits-1:0] out2,
output reg [number_bits-1:0] out3,
output reg [number_bits-1:0] out4);

always @(*)
begin
out1=0;
out2=0;
out3=0;
out4=0;
     case (sel)
     2'b00: out1=in;
     2'b01: out2=in;
     2'b10:out3=in;
     default: out4=in;
    endcase
end


    
endmodule
