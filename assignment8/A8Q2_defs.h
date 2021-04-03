`define NUM_INSTR 11
`define MAX_PC 11
`define START_PC 0
`define OUTPUT_REG 4
`define DATA_SIZE 3

// Instruction pipeline stages
`define IF 3'd0
`define ID 3'd1
`define RF 3'd2
`define EX 3'd3
`define MEM 3'd4
`define WB 3'd5
`define OUT 3'd6

// Instruction Formats
`define R 2'd0
`define J 2'd1
`define I 2'd2

// Instruction opcodes/functions
`define SLT 6'b101010
`define ADDU 6'b100001
`define JR 6'b001000
`define ADDIU 6'b001001
`define BEQ 6'b000100
`define LW 6'b100011
`define BNE 6'b000101
`define JAL 6'b000011