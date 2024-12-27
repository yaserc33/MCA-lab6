module inst_mem #(
    parameter IMEM_size = 200, 
    parameter mode = 32
)(
    input logic [mode-1: 0]addr,
    output logic [mode-1:0] inst
);

    // instruction memory 
    logic [mode-1:0] imem [0:IMEM_size];
    initial $readmemh("C:/risc5test.hex", imem);
    assign inst = imem[addr];



endmodule 