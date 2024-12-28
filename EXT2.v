module signext2(
	input [15:0] a,
	input s1,
	input en,
	output reg [15:0] y);

	always @(*) begin
		if (en) begin
			if (s1)
				y = {{8{a[7]}}, a[7:0]};
			else 
				y = {{8{1'b0}}, a[7:0]};
		end else begin
			y = a[15:0];
		end
	end
endmodule