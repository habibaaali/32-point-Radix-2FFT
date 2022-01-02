/*
rst_n start current_state    next_state sel En1 En2 En3 En4
1       x      x              s0        00   0   0   0   0
0       0      S0             s0        00   0   0   0   0     
0       1      s0             s1        00   1   0   0   0 
0       x      s1             s2        01   0   1   0   0 
0       x      s2             s3        10   0   0   1   0 
0       x      s3             s4        11   0   0   0   1 
0       x      s4             s0        00   0   0   0   0 

*/
module controller(
input clk_50,
input start,
input rst_n,
output reg En1,
output reg En2,
output reg En3,
output reg En4,
output reg [1:0] sel 
);

parameter s0=3'b000;
parameter s1=3'b001;
parameter s2=3'b010;
parameter s3=3'b011;
parameter s4=3'b100;
reg [2:0] current_state;
reg [2:0] next_state;


always@ (posedge clk_50 or negedge rst_n)
    begin
        if (!rst_n)
            current_state <= s0;
        else
            current_state <= next_state;
    end
always @ (*)
    begin
        case(current_state)
        s0: begin
                 if (start)
                 begin
                     next_state=s1;
                 end
                 else
                      next_state=s0;
             end
        s1: next_state=s2;
        s2: next_state=s3;
        s3: next_state=s4;
        s4: next_state=s0;
        default: next_state=s0;
        endcase
    end



always @ (current_state)
    begin
        case(current_state)
        s0: begin
                sel=00;
                En1=0;
                En2=0;
                En3=0;
                En4=0;
            end
        s1: begin
                sel=00;
                En1=1;
                En2=0;
                En3=0;
                En4=0;
            end
        s2: begin
                sel=01;
                En1=0;
                En2=1;
                En3=0;
                En4=0;
            end
        s3: begin
                sel=10;
                En1=0;
                En2=0;
                En3=1;
                En4=0;
            end
        s4: begin
                sel=11;
                En1=0;
                En2=0;
                En3=0;
                En4=1;
            end
        default: begin
                sel=00;
                En1=0;
                En2=0;
                En3=0;
                En4=0;
            end
        endcase
    end




endmodule
