module registerFile(
    input wire clock,
    input wire enable_write, 
    input wire [2:0] RA, RB, RW,
    input wire [15:0] BusW,
    output reg [15:0] BusA, BusB
);

    reg [15:0] registers_array [7:0];
    
    always @(posedge clock) begin
        BusA <= registers_array[RA];
        BusB <= registers_array[RB];
    end

    always @(posedge clock) begin
        if (enable_write && RW != 3'b000) begin
            registers_array[RW] <= BusW;
        end
    end

    initial begin
        registers_array[0] <= 16'h0000;
        registers_array[1] <= 16'h0000;
        registers_array[2] <= 16'h0000;
        registers_array[3] <= 16'h0000;
        registers_array[4] <= 16'h0000;
        registers_array[5] <= 16'h0000;
        registers_array[6] <= 16'h0000;
        registers_array[7] <= 16'h0000;
    end

endmodule