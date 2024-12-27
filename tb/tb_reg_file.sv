module tb_reg_file ;
    parameter mode = 32;
    parameter n = 32;

    logic clk, reset_n, write;
    logic [$clog2(n):0] sel_read_reg1 ,sel_read_reg2 ,sel_write_reg ;
    logic [mode-1:0] rs1,rs2,rd;

    reg_file #(.mode(mode),.reg_number(n)) uut (
        .clk(clk),
        .reset_n(reset_n),
        .write(write),
        .sel_read_reg1(sel_read_reg1),
        .sel_read_reg2(sel_read_reg2),
        .sel_write_reg(sel_write_reg),
        .data_in(rd),
        .data_out1(rs1),
        .data_out2(rs2)
         );

initial clk =0;
always #5 clk = ~clk ;


    // initial begin
    //     clk = 0;
    //     forever #5 clk = ~clk; 
    // end

 
    initial begin
        sel_read_reg1 =0;
        sel_read_reg2 =0;
        sel_write_reg =0;
        rd=0;
        reset_n = 0;

        #10 reset_n =1;

        #10 sel_write_reg=26;
        write=1;
        rd=1;


        #10 sel_read_reg1 =26;
        sel_read_reg2 =4 ;


        //check write
        #10 sel_write_reg=2;
        write=0;
        rd= 'hf;
        #10 sel_read_reg1 =2;




        //force x0 to be change what will happened ? 
        #10 sel_write_reg=0;
        write=1;
        rd= 'ha;
        #10 sel_read_reg1 =0;





        #10 reset_n = 0 ;

        

        #20 $stop;
    end
endmodule
