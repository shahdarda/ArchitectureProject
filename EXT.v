module signext(
	input [11:0] a,
	input [1:0] s1,
	input s2,
	output reg [15:0] y);

	always @(*) begin
		if (s1 == 2'b01) begin
			if (s2)
				y = {{11{a[4]}}, a[4:0]};
			else 
				y = {{11{1'b0}}, a[4:0]};
		end else begin
			y = {{8{a[7]}}, a[7:0]};
		end
	end
endmodule