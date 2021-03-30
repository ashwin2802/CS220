`include "A8Q1_size.h"
`include "A8Q1_instrmem.v"
`include "A8Q1_decoder.v"
`include "A8Q1_regfile.v"
`include "A8Q1_datamem.v"
`include "A8Q1_alu.v"

module processor(clk, done, out);
    input clk;
    output reg done;
    output reg [7:0] out;

    reg [2:0] state;
    reg [7:0] pc;

    wire [31:0] instr;
    
    wire [1:0] format;
    wire [5:0] opcode;
    wire [4:0] rs, rd, rt, shift;
    wire [15:0] imm;
    wire [25:0] jt;

    wire [7:0] r_data1, r_data2;
    reg [7:0] w_data;

    wire [3:0] data_addr;
    wire [4:0] reg_addr;
    wire valid, write, data_en;
    wire [7:0] new_pc, res_data, data_out;

    initial begin
        state <= 3'd0;
        done <= 1'd0;
        pc <= `START_PC;
    end

    instruction_memory INSTR(clk, state, pc, instr);
    decoder DEC(clk, state, instr, format, opcode, rs, rt, rd, shift, imm, jt);
    register_file REGFILE(clk, state, rs, rt, rd, reg_addr, write, format, valid, r_data1, r_data2, w_data, exec_done);
    alu_unit ALU(clk, state, pc, format, opcode, r_data1, r_data2, shift, imm, jt, new_pc, data_addr, reg_addr, res_data, data_en, valid, write);
    data_memory DATA(clk, state, data_en, data_addr, data_out);

    always @(posedge clk) begin
        if(state == 3'd5 && pc < `MAX_PC) begin
            state <= 3'd0;
        end
        else if(state != 3'd6) begin
            state <= state + 3'd1;
        end
        else begin
            out <= r_data1;
            done <= exec_done;
        end
    end

    always @(negedge clk) begin
        if(state == 3'd4) begin
            pc <= new_pc;
        end
        if(state == 3'd5) begin
            if(data_en == 1'b1) begin
                w_data <= data_out;
            end
            else begin
                w_data <= res_data;
            end
        end
    end

endmodule