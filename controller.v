module controller(
    input wire clk,
    input wire reset,
    output reg [4:0] A,
    output reg [4:0] B,
    output reg OP,
    output reg [4:0] result,
    output reg flag,
    output reg done
);

    // Define states
    parameter [2:0] START = 3'b000,
                    ONE   = 3'b001,
                    TWO   = 3'b010,
                    THREE = 3'b011,
                    FINISH = 3'b100;

    reg [2:0] pstate, nstate;

    // State Register
    always @(posedge clk or posedge reset) begin
        if (reset)
            pstate <= START;
        else
            pstate <= nstate;
    end

    // Next State and Outputs
    always @(*) begin
        // Default outputs
        A = 5'b00000;
        B = 5'b00000;
        OP = 1'b0;
        flag = 1'b0;
        done = 1'b0;
        nstate = pstate;

        case (pstate)
            START: begin
                nstate = ONE;
            end
            
            ONE: begin
                A = 5'b00101;   // Test NOT operation
                B = 5'b00000;
                OP = 1'b0;
                nstate = TWO;
            end

            TWO: begin
                A = 5'b10000;   // Test ROL operation (shift 1)
                B = 5'b00001;
                OP = 1'b1;
                nstate = THREE;
            end

            THREE: begin
                A = 5'b00000;   // Test NOT operation with all zeros (flag should be 0)
                B = 5'b00000;
                OP = 1'b0;
                nstate = FINISH;
            end

            FINISH: begin
                done = 1'b1;
                nstate = FINISH;  // Stay in FINISH state until reset
            end

            default: nstate = START;
        endcase
    end

endmodule