parameter  
    // opcode
    // R-type
    AND = 4'b0000,
    ADD = 4'b0001,
    SUB = 4'b0010,
    
    // I-type
    ADDI = 4'b0011,
    ANDI = 4'b0100,
    
    LW = 4'b0101,
	LB = 4'b0110,
	
	u =	1'b0,
	s = 1'b1,
	
    //LBu = 5'b01100,
    //LBs = 5'b01101,
    
    SW = 4'b0111,
    
    BGT = 5'b1000,
    //BGTZ = 5'b10001,
    
    BLT = 5'b1001,
    //BLTZ = 5'b10011,
    
    BEQ = 5'b1010,
    //BEQZ = 5'b10101,
    
    BNE = 5'b1011,
    //BNEZ = 5'b10111,
	
	Z=1'b1,
    
    // J-type
    JMP = 4'b1100,
    CALL = 4'b1101,
    RET = 4'b1110,
    
    // S-type
    Sv = 4'b1111,
    
    // Signals
    // PC src
    // 2-bit select to determine next PC value
    PCD = 2'b00,  // PC = PC + 2
    PCB = 2'b01,  // PC = PC + sign_extended (Imm16)
    PCJ = 2'b10,  // PC = PC[15:13] || address12|| '0'
    PCR = 2'b11,  // PC = R7
    
    // RASRC
    RS1RT = 2'b00,
    RSIT = 2'b01,
    RSST = 2'b10,
    CR7 = 2'b11,
    
    // RBSRC
    RS2RT = 2'b00,
    RDIT = 2'b01,
    RZERO = 2'b10,
    
    // RDSRC
    RDRT = 2'b00,
    RIT = 2'b01,
    RETR7 = 2'b10,
    
    // En W
    // 1-bit select to E/D write on registers
    WE = 1'b1, // Write enabled
    WD = 1'b0, // Write disabled
    
    // ALU SRC
    RSRC = 1'b0,
    IMMSRC = 1'b1,
    
    // ALU OP
    ANDOP = 2'b00,
    ADDOP = 2'b01,
    SUBOP = 2'b10,
    SUBINVOP = 2'b11,
    
    // address_in_memo
    RADDRESS = 1'b0,
    ALUADDRESS = 1'b1,
    
    // data_in_memo
    RBDATA = 1'b1,
    IMMDATA = 1'b0,
    
    // EN_EXT
    en_ext = 1'b1,
    dis_ext = 1'b0,
    
    // signed / unsigned 
    sext = 1'b1,
    uext = 1'b0,  
    
    // mem read/write 
    disabledMemo = 2'b00,
    readmemo = 2'b01,
    writeMemo = 2'b10,
    
    // WBD
    ALUR = 2'b00,
    DATAR = 2'b01,
    
    // EXTOP
    SIMM = 1'b0,
    IIMM = 1'b1,
    
    // EXTS/U
    signedext = 1'b1,
    unsignedext = 1'b0,
    
    // 8 registers
    R0 = 3'd0, // zero register
    R1 = 3'd1, 
    R2 = 3'd2, 
    R3 = 3'd3, 
    R4 = 3'd4, 
    R6 = 3'd6, 
    R7 = 3'd7;