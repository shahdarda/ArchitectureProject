module alu(
    input [15:0] A, B,
    input [1:0] F,
	input EN,
    output reg [15:0] Y,
    output reg Zero, negative, overflow
);

    reg signed [15:0] signed_A, signed_B, signed_Y;

    always @(*) begin  
		if (EN) begin
		
        case (F)
            2'b00: Y = A & B; // AND
            2'b01: Y = A + B; // ADD
            2'b10: Y = A - B; // SUB
            2'b11: Y = B - A; // SUBINV
            default: Y = 16'b0; // default to 0, should not happen
        endcase	  
	end
    end

    assign Zero = (Y == 16'b0);
    assign negative = Y[15];
	 
	
    // Overflow detection logic
    always @(*) begin
        signed_A = A;
        signed_B = B;
        signed_Y = Y; 
		if (EN) begin

        if (F == 2'b01) // ADD
            overflow = (signed_A > 0 && signed_B > 0 && signed_Y < 0) || (signed_A < 0 && signed_B < 0 && signed_Y > 0);
        else if (F == 2'b10) // SUB
            overflow = (signed_A > 0 && signed_B < 0 && signed_Y < 0) || (signed_A < 0 && signed_B > 0 && signed_Y > 0);
        else if (F == 2'b11) // SUBINV
            overflow = (signed_B > 0 && signed_A < 0 && signed_Y < 0) || (signed_B < 0 && signed_A > 0 && signed_Y > 0);
        else
            overflow = 1'b0;
    end	
	end

endmodule