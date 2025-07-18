module ALU_ROL_5bit
(
    input [4:0] in,
    input [2:0] shift,
    output reg [4:0] out
);

always @(*) begin
    case(shift)
        3'b000: out = in;
        3'b001: out = {in[3:0], in[4]};
        3'b010: out = {in[2:0], in[4:3]};
        3'b011: out = {in[1:0], in[4:2]};
        3'b100: out = {in[0], in[4:1]};
        default: out = in;
    endcase
end

endmodule