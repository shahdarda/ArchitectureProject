module mem(
    input clk, 
    input memRd, memWr,
    input [15:0] address, 
    input [15:0] data_in, 
	input EN,
    output reg [15:0] rd
);

    reg [7:0] RAM[255:0];

    initial begin
        RAM[0] <= 8'h20;
        RAM[1] <= 8'h02;
        RAM[2] <= 8'h00;
        RAM[3] <= 8'h05;
        RAM[4] <= 8'h20;
        RAM[5] <= 8'h03;
        RAM[6] <= 8'h00;
        RAM[7] <= 8'h0c;
        RAM[8] <= 8'h20;
        RAM[9] <= 8'h67;
        RAM[10] <= 8'hff;
        RAM[11] <= 8'hf7;
        RAM[12] <= 8'h00;
        RAM[13] <= 8'he2;
        RAM[14] <= 8'h20;
        RAM[15] <= 8'h25;
        RAM[16] <= 8'h00;
        RAM[17] <= 8'h64;
        RAM[18] <= 8'h28;
        RAM[19] <= 8'h24;
        RAM[20] <= 8'h00;
        RAM[21] <= 8'ha4;
        RAM[22] <= 8'h28;
        RAM[23] <= 8'h20;
        RAM[24] <= 8'h10;
        RAM[25] <= 8'ha7;
        RAM[26] <= 8'h00;
        RAM[27] <= 8'h0a;
        RAM[28] <= 8'h00;
        RAM[29] <= 8'h64;
        RAM[30] <= 8'h20;

    end

    always @(posedge clk) begin	 
		if (EN) begin
        if (memWr) begin
            RAM[address] <= data_in[7:0];
            RAM[address + 1] <= data_in[15:8];
        end
    end	 
	end

    always @(posedge clk) begin	 
		if (EN) begin
        if (memRd) begin
            rd <= {RAM[address + 1], RAM[address]};
        end
    end
	end

endmodule