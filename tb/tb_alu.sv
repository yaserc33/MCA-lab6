module tb_alu;

    parameter ALU_WIDTH = 32;

    // Testbench Signals
    logic [ALU_WIDTH - 1:0] op1, op2;
    logic [3:0] alu_op;
    logic [ALU_WIDTH - 1:0] alu_out;

    // Instantiate the ALU module
    alu #(.ALU_WIDTH(ALU_WIDTH)) uut (
        .op1(op1),
        .op2(op2),
        .alu_op(alu_op),
        .alu_out(alu_out)
    );

    // Test procedure
    initial begin
        // Initialize signals
        op1 = 0;
        op2 = 0;
        alu_op = 0;

        // Test ADD
        op1 = 32'h00000010; // 16
        op2 = 32'h00000020; // 32
        alu_op = 4'd0;       // ADD
        #10;
        // Expected alu_out = 16 + 32 = 48

        // Test SUB
        op1 = 32'h00000030; // 48
        op2 = 32'h00000020; // 32
        alu_op = 4'd1;       // SUB
        #10;
        // Expected alu_out = 48 - 32 = 16

        // Test AND
        op1 = 32'hF0F0F0F0;
        op2 = 32'h0FF00FF0;
        alu_op = 4'd2;       // AND
        #10;

        // Test OR
        op1 = 32'hF0F0F0F0;
        op2 = 32'h0FF00FF0;
        alu_op = 4'd3;       // OR
        #10;

        // Test XOR
        op1 = 32'hF0F0F0F0;
        op2 = 32'h0FF00FF0;
        alu_op = 4'd4;       // XOR
        #10;

        // Test SLL
        op1 = 32'h00000001; // 1
        op2 = 32'h00000004; // 4
        alu_op = 4'd5;       // SLL
        #10;
        // Expected alu_out = 1 << 4 = 16

        // Test SRL
        op1 = 32'h00000010; // 16
        op2 = 32'h00000002; // 2
        alu_op = 4'd6;       // SRL
        #10;
        // Expected alu_out = 16 >> 2 = 4

        // Test SRA
        op1 = 32'h80000000; // -2147483648
        op2 = 32'h00000002; // 2
        alu_op = 4'd7;       // SRA
        #10;
        // Expected alu_out = -2147483648 >> 2 = -536870912 (arithmetic shift)

        // Test SLT
        op1 = 32'h00000010; // 16
        op2 = 32'h00000020; // 32
        alu_op = 4'd8;       // SLT
        #10;
        // Expected alu_out = (16 < 32) = 1

        // Test SLTU
        op1 = 32'hFFFFFFFF; // 4294967295 (unsigned)
        op2 = 32'h00000001; // 1
        alu_op = 4'd9;       // SLTU
        #10;



        // Test ZF
        op1 = 32'hFFFFFFFF; // 4
        op2 = 32'h00000001; // 1
        alu_op = 0;     
        #10;
       

        $stop;
    end

endmodule
