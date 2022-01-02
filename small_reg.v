


module small_reg#(parameter number_bits=22)
(
input [2*number_bits-1:0] data_in,
input clk_50,
input rst_n,
input en,
output reg [2*number_bits-1:0] data_out
);
always @ (posedge clk_50 or negedge rst_n)
    begin
        if (!rst_n)
        data_out <= 0;
        else if (en)
        data_out<= data_in;
    end 
endmodule
