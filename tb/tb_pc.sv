module tb_program_counter;
    parameter WIDTH = 32;

    logic clk, reset_n;
    logic [WIDTH-1:0] pc_in;
    logic [WIDTH-1:0] pc_out;

    program_counter #(WIDTH) uut (
        .clk(clk),
        .reset_n(reset_n),
        .pc_in(pc_in),
        .pc_out(pc_out)   
         );

      initial begin
        clk = 0;
        forever #5 clk = ~clk; 
    end

 
    initial begin


        #10 reset_n = 0;

        #10 reset_n = 1;

        #5;

        //Increment counter
        #10 pc_in = 232331;
        #40 pc_in = 032323232;

        #10 reset_n = 0 ;

        

        #20 $stop;
    end
endmodule
