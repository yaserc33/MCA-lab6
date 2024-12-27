module program_counter #(parameter n =32)(
    input  logic clk, 
    input  logic reset_n,
    input  logic [n-1:0] pc_in,  
    output logic [n-1:0] pc_out
);

    always_ff @(posedge clk, negedge reset_n)
    begin 
        if(~reset_n)  
            pc_out <= 0;
        else  
            pc_out <= pc_in;
         
    end


endmodule 
