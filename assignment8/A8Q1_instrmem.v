`include "A8Q1_size.h"

// Instruction memory module
module instruction_memory(clk, state, pc, instr);
    input clk;
    input [2:0] state;
    input [7:0] pc;
    output reg[31:0] instr;

    reg [31:0] instruct_mem [`NUM_INSTR-1:0];

    // Initialize memory
    initial begin
        instruct_mem[0] <= 32'b00100100000000100000000000000000; 
        instruct_mem[1] <= 32'b00100100000000110000000000000000; 
        instruct_mem[2] <= 32'b00000000011000010010000000101010; 
        instruct_mem[3] <= 32'b00010000100000000000000000001000; 
        instruct_mem[4] <= 32'b00100100000001010000000000001010; 
        instruct_mem[5] <= 32'b00010000011001010000000000000110; 
        instruct_mem[6] <= 32'b10001100011001100000000000000000; 
        instruct_mem[7] <= 32'b00000000010001100001000000100001;
        instruct_mem[8] <= 32'b00100100011000110000000000000001; 
        instruct_mem[9] <= 32'b00000000011000010010000000101010; 
        instruct_mem[10] <= 32'b00010100100000001111111111111011; 
        instruct_mem[11] <= 32'b00000011111000000000000000001000; 
        instruct_mem[12] <= 32'b10001100000000010000000000001010; 
        instruct_mem[13] <= 32'b00001100000000000000000000000000; 
    end

     // Load new instruction
    always @(posedge clk) begin
        if(state == 3'd0) begin
            instr <= instruct_mem[pc];
        end
    end

endmodule