`include "A8Q2_defs.h"

// Instruction memory module
module instruction_memory(clk, state, pc, instr);
    input clk;
    input [2:0] state;
    input [7:0] pc;
    output reg[31:0] instr;

    reg [31:0] instruct_mem [`NUM_INSTR-1:0];

    // Initialize memory
    initial begin
        instruct_mem[0] <= 32'b10001100000000010000000000000000; 
        instruct_mem[1] <= 32'b10001100000000100000000000000001; 
        instruct_mem[2] <= 32'b10001100000000110000000000000010; 
        instruct_mem[3] <= 32'b00100100000001000000000000000000; 
        instruct_mem[4] <= 32'b00100100001001010000000000000000; 
        instruct_mem[5] <= 32'b00000000101000100011000000101010; 
        instruct_mem[6] <= 32'b00010000110000000000000000000101; 
        instruct_mem[7] <= 32'b00000000100001010010000000100001;
        instruct_mem[8] <= 32'b00000000101000110010100000100001;
        instruct_mem[9] <= 32'b00000000101000100011000000101010; 
        instruct_mem[10] <= 32'b00010100110000001111111111111101; 

    end

     // Load new instruction
    always @(posedge clk) begin
        if(state == `IF) begin          // Instruction Fetch state
            instr <= instruct_mem[pc];  // Load instruction at current pc
        end
    end

endmodule