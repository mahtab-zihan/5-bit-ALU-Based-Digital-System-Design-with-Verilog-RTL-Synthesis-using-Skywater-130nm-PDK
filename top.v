module top(
    input wire clk,
    input wire reset,
    output wire [4:0] result,
    output wire flag_gt_zero,
    output wire done
);

    // Internal wires
    wire [4:0] A, B;
    wire OP;
    wire [4:0] R_result;
    wire SF, ZF;

    // Instantiate controller
    controller controller1 (
        .clk(clk),
        .reset(reset),
        .A(A),
        .B(B),
        .OP(OP),
        .result(result),
        .flag(flag_gt_zero),
        .done(done)
    );

    // Instantiate ALU datapath
    ALU datapath1 (
        .A(A),
        .B(B),
        .OP(OP),
        .result(R_result),
        .CF(),          // Carry flag (unused)
        .SF(SF),        // Sign flag
        .ZF(ZF)         // Zero flag
    );

    // Output assignments
    assign result = R_result;
    assign flag_gt_zero = SF;  // Flag is 1 when result > 0 (using sign flag)

endmodule