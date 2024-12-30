module tb_data_memory;

    // Define the enum locally in the testbench
    typedef enum logic [2:0] {
        LB,
        LBU,
        LH,
        LHU,
        LW,
        SB,
        SH,
        SW
    } memory_op_type;

    // Parameters
    parameter size = 1024;

    // Signals
    logic clk;
    logic reset_n;
    logic mem_write, mem_read;
    logic [31:0] addr;
    logic [2:0] fun3;
    logic [31:0] data_in;
    logic [31:0] data_out;

    // DUT instance
    data_memory #(.size(size)) dut (
        .clk(clk),
        .reset_n(reset_n),
        .mem_write(mem_write),
        .mem_read(mem_read),
        .addr(addr),
        .fun3(fun3),
        .data_in(data_in),
        .data_out(data_out)
    );

    // Clock generation
    always #5 clk = ~clk;

    // Tasks for write and read operations
    task write_data(input [31:0] address, input [31:0] data, input [2:0] mode);
        begin
            addr = address;
            data_in = data;
            fun3 = mode;
            mem_write = 1;
            mem_read = 0;
            #10; // Wait for one clock cycle
            mem_write = 0;
        end
    endtask

    task read_data(input [31:0] address, input [2:0] mode);
        begin
            addr = address;
            fun3 = mode;
            mem_read = 1;
            mem_write = 0;
            #10; // Wait for one clock cycle
            mem_read = 0;
        end
    endtask

    // Testbench procedure
    initial begin
        // Initialize signals
        clk = 0;
        reset_n = 0;
        mem_write = 0;
        mem_read = 0;
        addr = 0;
        fun3 = 0;
        data_in = 0;

        // Reset the DUT
        #10 reset_n = 1;

        // Test SW (Store Word)
        write_data(32'h00000000, 32'hAABBCCDD, SW);
        write_data(32'h00000004, 32'h11223344, SW);

        // Test SH (Store Halfword)
        write_data(32'h00000000, 32'h00001234, SH);
        write_data(32'h00000002, 32'h00005678, SH);

        // Test SB (Store Byte)
        write_data(32'h00000000, 32'h000000AA, SB);
        write_data(32'h00000001, 32'h000000BB, SB);

        // Test LW (Load Word)
        read_data(32'h00000000, LW);
        #10 ;
        
           // Test LW (Load Word)
        read_data(32'h00000004, LW);
        #10 ;


        // Test LH (Load Halfword)
        read_data(32'h00000000, LH);
        #10;

        // Test LHU (Load Halfword Unsigned)
        read_data(32'h00000002, LHU);
        #10 ;

        // Test LB (Load Byte)
        read_data(32'h00000000, LB);
        #10 ;

        // Test LBU (Load Byte Unsigned)
        read_data(32'h00000001, LBU);
        #10 ;




    //test resert
      // Reset the DUT
        #10 reset_n = 0;
        #10 reset_n = 1;
        
        // Test LW (Load Word)
        read_data(32'h00000000, LW);
        #10 ;
        
           // Test LW (Load Word)
        read_data(32'h00000004, LW);
        #10 ;


        // Test LH (Load Halfword)
        read_data(32'h00000000, LH);
        #10;

        // Test LHU (Load Halfword Unsigned)
        read_data(32'h00000002, LHU);
        #10 ;

        // Test LB (Load Byte)
        read_data(32'h00000000, LB);
        #10 ;

        // Test LBU (Load Byte Unsigned)
        read_data(32'h00000001, LBU);
        #10 ;





        // End simulation
        $finish;
    end

endmodule
