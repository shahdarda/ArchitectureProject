`include "constants.v"

// 0: Pc = Pc + 2
// 1: PC = 	PC + sign_extended (Imm16) 
// 2: PC = {PC[15:13], Immediate13 }
// 3: PC = 	 R7

module pcModule(clock, PC, PCsrc, immediate12, Imm16, R7Value, EN);

    input wire clock;

    input wire [1:0] PCsrc;
    input wire [12:0] immediate12;
    input wire [15:0] R7Value;
    input wire signed [15:0] Imm16;
	input wire EN;

    // PC Output
    output reg [15:0] PC;

    // To store assignments
    wire [15:0] NextPC;
    wire [15:0] JumpConc;

    // PC + 2
    assign NextPC = PC + 16'd2;
    // Concatinate PC and immediate
    assign JumpConc = {{PC[15:13], immediate12, 1'b0}};

    initial begin
        PC <= 16'd0;
    end


    always @(posedge clock) begin
		if(EN) begin
            case (PCsrc)
                2'b00: begin
                    // PC = PC + 2
                    PC = NextPC;
                end
                2'b01:  begin
                   
                    PC = Imm16;
                end
                2'b10: begin
                   PC = JumpConc;
                end
                2'b11: begin
                    
                    PC = R7Value;
                end
            endcase
		end
    end
endmodule