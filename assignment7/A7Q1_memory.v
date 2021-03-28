`define NUM_INSTR 8

// Instruction memory module
module memory(clk, pc, instr, en);
    input clk;
    input [3:0] pc;
    output reg[31:0] instr;
    output reg en;

    reg [31:0] instruct_mem [`NUM_INSTR-1:0];

    // Initialize memory
    initial begin
        instruct_mem[0] <= 32'b00100000000001000011010001010110; // I format, write to $4
        instruct_mem[1] <= 32'b00100000000001011111111111111111; // I format, write to $5
        instruct_mem[2] <= 32'b00000000101001000011000001000000; // R format, write to $6
        instruct_mem[3] <= 32'b00100000000000110000000000000111; // I format, write to $3
        instruct_mem[4] <= 32'b00000000110000110011000000000100; // R format, write to $6
        instruct_mem[5] <= 32'b00000000000000110001100001000010; // R format, write to $3
        instruct_mem[6] <= 32'b10001100100001011001101010111100; // I format, write to $5
        instruct_mem[7] <= 32'b00001000000100100011010001010110; // J format
    end

    // Load new instruction
    always @(posedge clk) begin
        instr <= instruct_mem[pc];
        en <= 1'b1;
    end

    // Deactivate output trigger
    always @(negedge clk) begin
        en <= 1'b0;
    end

endmodule