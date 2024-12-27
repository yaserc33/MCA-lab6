module data_path # (parameter mode=32) (
    input  logic clk, 
    input  logic reset_n,
);








// pc
logic [mode-1:0] current_pc , next_pc ;

program_counter #(.WITH(mode)) pc (
    .clk(clk),
    .reset_n(reset_n),
    .pc_in(current_pc),
    .pc_out(next_pc)
);


//instruction memory 
logic [mode-1:0] instruction ;

  inst_mem #(
    .IMEM_size(200), 
    .mode(mode)
)instruction_memory(
    .addr(next_pc)
    .inst(instruction)
)




    
endmodule