module tb_mux2to1;

// Testbench signals
reg [15:0] a;
reg [15:0] b;
reg  sel;
wire [15:0] y;

// Instantiate the MUX
mux2 mux2to1 (a,b,sel,y);

// Apply test vectors
initial begin
    // Display the results
    $monitor("At time %t: a = %b, b = %b, sel = %b -> y = %b", $time, a, b, sel, y);
    
    	     // Test case 1: sel = 0
    a = 16'h0000; b = 16'hFFFF; sel = 0; #10;  // Expected output: y = 0000
    a = 16'h1234; b = 16'h5678; sel = 0; #10;  // Expected output: y = 1234
    a = 16'hABCD; b = 16'hEF01; sel = 0; #10;  // Expected output: y = ABCD
    a = 16'hFFFF; b = 16'h0000; sel = 0; #10;  // Expected output: y = FFFF
    
    // Test case 2: sel = 1
    a = 16'h0000; b = 16'hFFFF; sel = 1; #10;  // Expected output: y = FFFF
    a = 16'h1234; b = 16'h5678; sel = 1; #10;  // Expected output: y = 5678
    a = 16'hABCD; b = 16'hEF01; sel = 1; #10;  // Expected output: y = EF01
    a = 16'hFFFF; b = 16'h0000; sel = 1; #10;  // Expected output: y = 0000

    // End simulation
    $finish;
end

endmodule