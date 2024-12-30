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


module data_memory #(
    parameter size=1024 
) (
    input logic clk, 
    input logic reset_n,
    input logic mem_write , mem_read,  //enable signals
    input logic [31:0] addr, // limited by prameter size
    input logic [2:0] fun3,  // select mode lb,lbu,lh,lhu,lw,sb,sh,sw 
    input logic [31:0] data_in,
    output logic [31:0] data_out
);

    
    logic [31 :0] data_memory [0:size-1]; // data memory  with (size) location     --> log2(size+1) = log2(1024)=10 bit address
    logic [$clog2(size)+1 :2] word_addr;    // 10 bit word locations + 2 bit for byte address = 12 bit total bit   --> [11:2] word _addr
    logic [1:0]   byte_addr; 



    memory_op_type memory_op;
    assign  memory_op = memory_op_type'(fun3);// type cast



    assign word_addr = addr[$clog2(size)+1:2]; //to addrss a  word
    assign byte_addr = addr[1:0]; // to address the specific byte of a ward






    //store instrucations 
    always @(posedge clk, negedge reset_n) begin 
        if(~reset_n) begin 
            for(int i = 0; i<size ; i = i+1) begin 
                data_memory[i] <= 0;
            end
        end 
        else if (mem_write) begin 
            case(fun3) 
            SW:  data_memory[word_addr] <= data_in;

            SH: if(byte_addr ==2'b00) 
                    data_memory[word_addr][15:0] <= data_in[15:0];

                else if (byte_addr==2'b10)
                    data_memory[word_addr][31:16] <= data_in[15:0]; 
            SB:
                    if (byte_addr == 2'b00)
                        data_memory[word_addr][7:0] <= data_in[7:0];

                    else if (byte_addr == 2'b01)
                        data_memory[word_addr][15:8] <= data_in[7:0];

                    else if (byte_addr == 2'b10)
                        data_memory[word_addr][23:16] <= data_in[7:0];

                    else if (byte_addr == 2'b11)
                        data_memory[word_addr][31:24] <= data_in[7:0];
            

            default: /*nothing*/; 
            endcase
        end
    end

// load instructions 
always @(negedge clk, negedge reset_n) begin   // negedge clk  to make the write before read in case of read and write accsse in same time 
        if(~reset_n) begin 
            for(int i = 0; i<size; i = i+1) begin 
                data_memory[i] <= 0;
            end
        end 
        else if (mem_read) begin 
            case(fun3) 
            LW :  data_out <= data_memory[word_addr];


            LHU:  
                  if(byte_addr== 2'b00) 
                     data_out <= {   {16{1'b0}}  , data_memory[word_addr][15:0] };
                  else if (byte_addr==2'b10)
                     data_out <= {   {16{1'b0}}  , data_memory[word_addr][31:16] };

            LH :  if(byte_addr== 2'b00) 
                     data_out <= {  {16{data_memory[word_addr][15]}}  , data_memory[word_addr][15:0] };

                  else if (byte_addr==2'b10)
                     data_out <= {  {16{data_memory[word_addr][31]}}  , data_memory[word_addr][31:16]};



            LBU:  
                if(byte_addr ==2'b00) 
                    data_out <= {  {24{1'b0}}  , data_memory[word_addr][7:0] };

                else if (byte_addr ==2'b01)
                    data_out <= {  {24{1'b0}}  , data_memory[word_addr][15:8] };        

                else if(byte_addr ==2'b10) 
                    data_out <= {  {24{1'b0}}  , data_memory[word_addr][23:16] };         

                else if (byte_addr==2'b11)
                    data_out <= {  {24{1'b0}}  , data_memory[word_addr][31:24] };     


            LB:   
                if(byte_addr ==2'b00) 
                    data_out <= {  {24{data_memory[word_addr][7]}}   , data_memory[word_addr][7:0] };

                else if (byte_addr ==2'b01)
                    data_out <= {  {24{data_memory[word_addr][15]}}  , data_memory[word_addr][15:8] };        

                else if(byte_addr ==2'b10) 
                    data_out <= {  {24{data_memory[word_addr][23]}}  , data_memory[word_addr][23:16] };         

                else if (byte_addr==2'b11)
                    data_out <= {  {24{data_memory[word_addr][31]}}   , data_memory[word_addr][31:24] };     




            default: /*nothing*/; 
            endcase
        end
    end    



endmodule 