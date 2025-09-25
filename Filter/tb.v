// verilog
// filepath: d:\Matlab_verilog\Filter\test_qrs.v
`include "qrs.v"
`timescale 1ns/1ps

module test_qrs;

    reg clk;
    reg rst;
    reg slope_;
    reg r_peak;
    wire [31:0] r_r_int;

    // Instantiate the qrs module
    qrs uut (
        .clk(clk),
        .rst(rst),
        .slope_(slope_),
        .r_peak(r_peak),
        .r_r_int(r_r_int)
    );

    // Clock generation
    initial clk = 0;
    always #5 clk = ~clk; // 100MHz clock

    initial begin
        // Initialize inputs
        rst = 1;
        slope_ = 0;
        r_peak = 0;

        // Apply reset
        #12;
        rst = 0;

        // Wait a few cycles
        #10;

        // Test 1: Single r_peak pulse
        r_peak = 1;
        #10;
        r_peak = 0;
        #20;

        // Test 2: Another r_peak pulse after some delay
        #30;
        r_peak = 1;
        #10;
        r_peak = 0;
        #20;

        // Test 3: Toggle slope_ (should not affect outputs in current logic)
        slope_ = 1;
        #10;
        slope_ = 0;
        #10;

        // Test 4: Apply reset in the middle
        rst = 1;
        #10;
        rst = 0;
        #10;

        // Test 5: Multiple r_peak pulses
        repeat(3) begin
            r_peak = 1;
            #10;
            r_peak = 0;
            #10;
        end

        // Finish simulation
        #50;
        $finish;
    end

    // Monitor outputs
    initial begin
        $monitor("Time=%0t | rst=%b r_peak=%b slope_=%b | r_r_int=%h", 
            $time, rst, r_peak, slope_, r_r_int);
    end

endmodule