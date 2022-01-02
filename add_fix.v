
module add_fixed #(
	//Parameterized values
	parameter N = 20,
	parameter Q=11
	)
	(
    input [N-1:0] a,
    input [N-1:0] b,
    output [N-1:0] c
    );

reg [N-1:0] res;
reg [N-1:0]   test;

assign c = res;

always @(a,b) begin
	// both negative or both positive
	if(a[N-1] == b[N-1]) begin
	    test= a[N-2:0] + b[N-2:0];					//	Since they have the same sign, absolute magnitude increases
		if(test[N-1:Q]>=9'b011111111)
            begin
            res[N-2:Q]=8'b11111111;
            res[Q-1:0]=0;
            end
		else
            res[N-2:0] = a[N-2:0] + b[N-2:0];		//		So we just add the two numbers
        res[N-1] = a[N-1];							//		and set the sign appropriately...  Doesn't matter which one we use, 
                                                                //		they both have the same sign
															//	Do the sign last, on the off-chance there was an overflow...  
		end												//		Not doing any error checking on this...
	//	one of them is negative...
	else if(a[N-1] == 0 && b[N-1] == 1) begin		//	subtract a-b
		if( a[N-2:0] > b[N-2:0] ) begin
		    test= a[N-2:0] - b[N-2:0];
            if(test[N-1:Q]>=9'b011111111)
               begin
                res[N-2:Q]=8'b11111111;
                res[Q-1:0]=0;
              end
            else					//	if a is greater than b,
			res[N-2:0] = a[N-2:0] - b[N-2:0];			//		then just subtract b from a
			res[N-1] = 0;										//		and manually set the sign to positive
			end
		else begin
		    test= b[N-2:0] - a[N-2:0];
            if(test[N-1:Q]>=9'b011111111)
               begin
                res[N-2:Q]=8'b11111111;
                res[Q-1:0]=0;
               end
            else												//	if a is less than b,
			res[N-2:0] = b[N-2:0] - a[N-2:0];			//		we'll actually subtract a from b to avoid a 2's complement answer
			if (res[N-2:0] == 0)
				res[N-1] = 0;										//		I don't like negative zero....
			else
				res[N-1] = 1;										//		and manually set the sign to negative
			end
		end
	else begin												//	subtract b-a (a negative, b positive)
		if( a[N-2:0] > b[N-2:0] ) begin	
		    test= a[N-2:0] - b[N-2:0];
            if(test[N-1:Q]>=9'b011111111)
               begin
                res[N-2:Q]=8'b11111111;
                res[Q-1:0]=0;
               end
            else				//	if a is greater than b,
			res[N-2:0] = a[N-2:0] - b[N-2:0];			//		we'll actually subtract b from a to avoid a 2's complement answer
			if (res[N-2:0] == 0)
				res[N-1] = 0;										//		I don't like negative zero....
			else
				res[N-1] = 1;										//		and manually set the sign to negative
			end
		else begin
		    test = b[N-2:0] - a[N-2:0];
            if(test[N-1:Q]>=9'b011111111)
              begin
                res[N-2:Q]=8'b11111111;
                res[Q-1:0]=0;
              end
            else												//	if a is less than b,
			res[N-2:0] = b[N-2:0] - a[N-2:0];			//		then just subtract a from b
			res[N-1] = 0;										//		and manually set the sign to positive
			end
		end
	end
endmodule