`include "constants.v"

module controlUnit (
    input wire clock,
    input wire [3:0] OPCODE,
    input wire modeBit,
    input wire zeroFlag,
    input wire negativeFlag,
    input wire overflowFlag,
    
    output reg enIF,  // enable instruction fetch
    output reg enID,  // enable instruction decode
    output reg enEXE,  // enable execute
    output reg enMem,  // enable memory
    output reg enWRB,  // enable write back

    output reg [1:0] PCSrc,
    output reg [1:0] RASrc,
    output reg [1:0] RBSrc,
    output reg [1:0] RDSrc,
    output reg RegWR,
    output reg ALUSrc,
    output reg [1:0] ALUOp,
    output reg addressMemo,
    output reg dataMemo,
    output reg [1:0] memoRW,
    output reg extEn,
    output reg SUExt,
    output reg [1:0] WBdata,
    output reg extOP,
    output reg extSU
);


    // Define stages
    `define IF 3'b000
    `define ID 3'b001
    `define EXE 3'b010
    `define MEM 3'b011
    `define WRB 3'b100
    `define INIT 3'b101

    reg [2:0] currentStage = `INIT;
    reg [2:0] nextStage = `IF;

    always @(posedge clock) begin
        currentStage <= nextStage;
    end

    always @(posedge clock) begin
        case (currentStage)
            `INIT: begin
                enIF = 1'b0;
                nextStage <= `IF;
            end
            
            `IF: begin
                // Disable all previous stages leading up to IF
                enID = 1'b0;
                enEXE = 1'b0;
                enMem = 1'b0;
                enWRB = 1'b0;
                memoRW = 2'b00; 
                RegWR = 1'b0;

                // Enable IF
                enIF = 1'b1;

                // Determine PCSrc
                PCSrc[1] = (OPCODE == JMP) || (OPCODE == CALL) || (OPCODE == RET);
                PCSrc[0] = ((OPCODE == BGT) && ~(zeroFlag) && ~(overflowFlag) && ~(negativeFlag)) || 
                           ((OPCODE == BLT) && ~(zeroFlag) && ~(overflowFlag) && (negativeFlag)) || 
                           ((OPCODE == BEQ) && (zeroFlag) && ~(overflowFlag) && ~(negativeFlag)) || 
                           ((OPCODE == BNE) && ~(zeroFlag) && ~(overflowFlag)) || 
                           (OPCODE == RET);

                // Determine next stage
                nextStage <= `ID;
            end	
			
		   `ID: begin
			enIF = 1'b0;   
			enID = 1'b1;	 
			
			// Next stage is determined by opcode
			if (OPCODE == JMP || OPCODE == RET) begin
					nextStage <= `IF;
			end	
			
			else if (OPCODE == CALL)begin 
				nextStage <= `WRB;
			end	
			
			else if (OPCODE == Sv)begin 
				nextStage <= `MEM;
			end
			
			else begin
					nextStage <= `EXE;
			end		
			
			// Determine RASrc
			RASrc[1] = (OPCODE == RET) || (OPCODE == Sv);
			RASrc[0] = ~((OPCODE == AND)|| (OPCODE == ADD)||(OPCODE == SUB)||(OPCODE == Sv)); 
			
			// Determine RBSrc
			RBSrc[1] = ((OPCODE == BGT) && (modeBit == 1)) || ((OPCODE == BLT) && (modeBit == 1)) || ((OPCODE == BEQ) && (modeBit == 1)) || ((OPCODE == BNE) && (modeBit == 1));
			RBSrc[0] = (OPCODE == SW) ||((OPCODE == BGT) && (modeBit == 0)) || ((OPCODE == BLT) && (modeBit == 0)) || ((OPCODE == BEQ) && (modeBit == 0)) || ((OPCODE == BNE) && (modeBit == 0));  
			
			 // Determine RDSrc
			 RDSrc[1] = (OPCODE == CALL);
			 RDSrc[0] = ~ ((OPCODE == ADD)|| (OPCODE == AND) ||(OPCODE == SUB) || (OPCODE == CALL));
			 
			 //Determine RegWR
			 RegWR = (OPCODE == AND) ||	(OPCODE == ADD) || (OPCODE == SUB) || (OPCODE == ADDI) ||(OPCODE == ANDI) || (OPCODE == LW) || (OPCODE == LB) || (OPCODE == CALL);
			 
			 extOP = ~(OPCODE == Sv);
			 extSU = ~(OPCODE == ANDI);
			 
			end	 
			
			`EXE : begin 
			 enID = 1'b0;
			 enEXE = 1'b1;	
			 
			 
			 if(OPCODE == LW || OPCODE == LB || OPCODE == SW ) begin
				 nextStage <= `MEM;
			 end 
			 
			 if(OPCODE == BGT || OPCODE == BLT || OPCODE == BEQ || OPCODE == BNE ) begin
				 nextStage <= `IF;
			end
			
			else begin
				nextStage <= `WRB; 
			end
			
			ALUSrc = (OPCODE == ADDI)||(OPCODE == ANDI)|| (OPCODE == LW) || (OPCODE == LB)||(OPCODE == SW);
			ALUOp[1] = ~((OPCODE == AND) ||(OPCODE == ADD) ||(OPCODE == ADDI)||(OPCODE == ANDI)|| (OPCODE == LW) || (OPCODE == LB)||(OPCODE == SW));
			ALUOp[0] = ~((OPCODE == AND) ||(OPCODE == SUB) ||(OPCODE == ANDI));	
			
			end	
			 
			`MEM : begin 
				enEXE = 1'b0; 
				enID = 1'b0;
				enMem = 1'b1;
				
				if(OPCODE == SW || OPCODE == Sv )begin
					nextStage <= `IF;
				end
				else begin
					nextStage <= `WRB;
				end
				
			addressMemo =  ~(OPCODE == Sv);
			dataMemo = OPCODE == SW;
			memoRW[1] = (OPCODE == LW )||(OPCODE == LB);
			memoRW[0] = (OPCODE == SW )||(OPCODE == Sv);
			extEn = ~(OPCODE == LW);
			SUExt = modeBit;
			end	  
			 
			`WRB: begin 
				enEXE = 1'b0; 
				enID = 1'b0;
				enMem = 1'b0;	
				enWRB = 1'b1;
				
				nextStage <= `IF;
					
				   WBdata[1] = (OPCODE == CALL);   
				   WBdata[0] = (OPCODE == LW ) || (OPCODE == LB);
				   
				end
				endcase
				end
				endmodule
				
				
				
			