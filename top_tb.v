`timescale 1ns/1ns

module top_tb;

    // Inputs
    reg clk, reset;
    
    // Outputs
    wire [4:0] result;
    wire flag_gt_zero;
    wire done;

    // Instantiate Unit Under Test
    top uut (
        .clk(clk),
        .reset(reset),
        .result(result),
        .flag_gt_zero(flag_gt_zero),
        .done(done)
    );

    // Clock generator (100MHz)
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // Test sequence
    initial begin
        // Initialize waveform dump
        $dumpfile("top_test.vcd");
        $dumpvars(0, top_tb);
        
        // Reset sequence
        reset = 1;
        #10;
        reset = 0;
        
        // Wait for completion or timeout
        wait(done == 1 || $time >= 200);
        
        // Additional delay for observation
        #20;
        
        $display("Test completed at time = %0t ns", $time);
        $finish;
    end

    // Monitor to display signals
    initial begin
        $monitor("Time = %0t ns | State = %b | A = %b | B = %b | OP = %b | Result = %b | Flag = %b | Done = %b",
                 $time,
                 uut.controller1.pstate,
                 uut.controller1.A,
                 uut.controller1.B,
                 uut.controller1.OP,
                 result,
                 flag_gt_zero,
                 done);
    end

endmodule