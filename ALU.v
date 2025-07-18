module ALU
(
    input wire [4:0] A, B,                   
    input wire OP,    
    output reg [4:0] result,     
    output wire CF,
    output wire SF,
    output wire ZF           
);

    wire [4:0] R_NOT, R_ROL;

    // Instantiate modules
    ALU_NOT_5bit NOT1 ( .A(A), .result(R_NOT));
    ALU_ROL_5bit ROL1 ( .in(A), .shift(B[2:0]), .out(R_ROL));  // last 3 bits of input B

    always @(*) 
    begin
        case (OP)
            1'b0: // NOT 
                begin 
                    result = R_NOT; 
                end
            1'b1: // ROL
                begin 
                    result = R_ROL;
                end
            
            default: 
                begin
                    result = 5'b00000;  
                end
        endcase
    end

    assign CF = 1'b0;
    assign SF = result[4];
    assign ZF = ~(result[4] | result[3] | result[2] | result[1] | result[0]);

endmodule