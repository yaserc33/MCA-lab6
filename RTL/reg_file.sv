module reg_file #(parameter mode = 32 , reg_number =32) (
    input logic clk, 
    input logic reset_n,
    input logic write, // enable write to rs (reg_file[sel_write_reg] <= data_in;) 
    input logic [$clog2(reg_number):0] sel_read_reg1, // address for reading from rs1 (we need 5 bit to address 32 Registers ) 
    input logic [$clog2(reg_number):0] sel_read_reg2, // address for reading from rs2
    input logic [$clog2(reg_number):0] sel_write_reg, // address for wrting to  rd
    input logic [mode - 1:0] data_in,     // rd  data coming from alu
    output logic [mode - 1:0] data_out1,  // rs1 data going to alu
    output logic [mode - 1:0] data_out2   // rs2 data going to alu
);

    
    logic [mode - 1:0] reg_file [0:31];

    
    always @(posedge clk, negedge reset_n) begin 
        
        if(~reset_n) begin 
            for(int i = 1; i<reg_number; i=i+1)  
                reg_file[i] <= 0;    
        end 

        else if(write) begin
            reg_file[sel_write_reg] <= data_in;
            reg_file[0] <= 0;
        end

        else begin
        //  do nothing (ensue nothing will happened)
        end
        
    end
    
    assign data_out1 = reg_file[sel_read_reg1];
    assign data_out2 = reg_file[sel_read_reg2];


endmodule 