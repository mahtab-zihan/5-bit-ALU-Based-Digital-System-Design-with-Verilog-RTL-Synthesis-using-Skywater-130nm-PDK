`timescale 1ns/1ps
module ALU_tb;

    reg [4:0] A, B;       
    reg OP;          
    wire [4:0] R;          
    wire CF;
    wire SF;
    wire ZF;

    ALU uut (
        .A(A),
        .B(B),
        .OP(OP),
        .result(R),
        .CF(CF),
        .SF(SF),
        .ZF(ZF)
    );

    initial begin
        $dumpfile("alu_test.vcd");
        $dumpvars(0, ALU_tb);

        // Test NOT operation
        A = 5'b00101; B = 5'b00000; OP = 1'b0;
        #10;
        
        // Test ROL operation with shift 1
        A = 5'b10000; B = 5'b00001; OP = 1'b1;
        #10;
        
        // Test ROL operation with shift 3
        A = 5'b10110; B = 5'b00011; OP = 1'b1;
        #10;
        
        // Test edge case with all zeros
        A = 5'b00000; B = 5'b00000; OP = 1'b0;
        #10;
        
        // Test edge case with all ones
        A = 5'b11111; B = 5'b00000; OP = 1'b0;
        #10;

        $finish;
    end

    initial begin
        $monitor("Time=%0t A=%b B=%b OP=%b -> R=%b CF=%b ZF=%b SF=%b", $time, A, B, OP, R, CF, ZF, SF);
    end

endmodule