`include "constants.v"

module instructionMemory(clock, en, AddressBus, InstructionReg);

    // ----------------- INPUTS -----------------

    // clock
    input wire clock;
	input en;

    // address bus
    input wire [15:0] AddressBus;

    // ----------------- OUTPUTS -----------------

    // instruction register
    output reg [15:0] InstructionReg;

    // ----------------- INTERNALS -----------------

    // instruction memory
    reg [7:0] instruction_memory [255:0];


    // ----------------- LOGIC -----------------

    assign InstructionReg = {instruction_memory[AddressBus[15:0]+1],instruction_memory[AddressBus[15:0]]}; // drop least significant 2 bits of address since instructions are 32 bits

    // ----------------- INITIALIZATION -----------------

    initial begin
        

        // initial
        instruction_memory[0] = 16'b0;


       // instruction_memory[1] = { ADDI, R0, R1, 14'b1000, I_Type, 1'b0 };

       
        //instruction_memory[2] = { ADDI, R0, R2, 14'b1110, I_Type, 1'b0 };

        
       // instruction_memory[3] = { BEQ, R1, R2, 5'd0, 9'd8, I_Type, 1'b0 };

        
       // instruction_memory[4] = { ADDI, R0, R1, 14'b1110, I_Type, 1'b0 };

       
       // instruction_memory[5] = { BEQ, R1, R2, 5'd0, 9'd8, I_Type, 1'b0 };

       
       // instruction_memory[6] = { ADDI, R0, R4, 14'd1, I_Type, 1'b0 };

        
       // instruction_memory[7] = { ADDI, R0, R5, 14'd2, I_Type, 1'b0 };


    end


endmodule