`include "A7Q2_processor.v"

module processor_top;
    reg clk,instruct_sig;
    reg [2:0] PC_initial,MAX_PC;
    reg [5:0] OUTPUT_REG;
    reg [31:0] instruct;

    wire[2:0] PC_final; 
    wire output_sig;
    processor mini_proccessor(clk,instruct,instruct_sig,PC_initial,MAX_PC,OUTPUT_REG,output_sig,PC_final);

    reg[31:0] instructions[5:0];

    initial begin
        MAX_PC <= 3'd5;
        OUTPUT_REG <= 5'd6;
        PC_initial <= 3'd0;

        instructions[0] <= 32'b 00010100000000010000000000101101;
        instructions[1] <= 32'b 00010100000000101111111111101100;
        instructions[2] <= 32'b 00010100000000111111111111000100;
        instructions[3] <= 32'b 00000000001000100010100000100001;
        instructions[4] <= 32'b 00000000011001000011000000100001; 
        instructions[5] <= 32'b 00000000101001100010100000100011; 

        instruct_sig <= 1'b1;
        clk <= 1'b0;

    end

    initial begin
        instruct <= instructions[0];
    end
    
endmodule