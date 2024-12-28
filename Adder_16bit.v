module full_adder (
	input [15:0]a,b,
	input cin,
    output [15:0]sum,
	output carry
);

	assign {carry,sum} = a + b + cin;


endmodule