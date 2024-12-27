typedef enum logic [3:0] {
    ADD,
    SUB,
    AND,
    OR,
    XOR,
    SLL,
    SRL,
    SRA,
    SLT,
    SLTU
} alu_op_t;

module alu #(parameter ALU_WIDTH = 32 )(
    input logic [ALU_WIDTH - 1:0] op1, 
    input logic [ALU_WIDTH - 1:0] op2,
    input logic [3:0] alu_op, // we have 10 instruction so we need 4 bit to select amoung them
    output logic [ALU_WIDTH - 1:0] alu_out,
    output logic zero
);

    alu_op_t alu_op_e;
    assign alu_op_e = alu_op_t'(alu_op); // type cast
    always_comb begin 
        case(alu_op) 
            ADD: alu_out = op1 + op2;
            SUB: alu_out = op1 - op2;
            AND: alu_out = op1 & op2;
            OR:  alu_out = op1 | op2;
            XOR: alu_out = op1 ^ op2;
            SLL: alu_out = op1 << ( op2 [$clog2(ALU_WIDTH)-1:0] ); 
            SRL: alu_out = op1 >> (op2[$clog2(ALU_WIDTH)-1:0]);
            SRA: alu_out = ($signed(op1)) >>> (op2[$clog2(ALU_WIDTH)-1:0]);
            SLT: alu_out = op1 < op2;
            SLTU:alu_out = ($unsigned(op1)) < ($unsigned(op2));
            default: alu_out = 0; // Ensure no unintended latches
        endcase
    end
    assign zero = (alu_out==0);


endmodule 