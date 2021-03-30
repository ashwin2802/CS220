`include "A8Q1_size.h"

module alu_unit(clk, state, pc, format, opcode, op1, op2, shift, imm, jumpt, new_pc, data_addr, reg_addr, data_out, data_en, valid, write);
    input clk;
    input [2:0] state;
    input [1:0] format;
    input [4:0] rs;
    input [5:0] opcode;
    input [7:0] op1, op2, pc;
    input [4:0] shift;
    input [15:0] imm;
    input [25:0] jumpt;

    output reg [7:0] data_out, new_pc;
    output reg [3:0] data_addr;
    output reg [4:0] reg_addr;
    output reg valid, write, data_en;

    initial begin
        valid <= 1'b0;
        write <= 1'b0;
        data_en <= 1'b0;
    end

    always @(posedge clk) begin
        if(state == 3'd3) begin
            valid <= 1'b1;
            write <= 1'b0;
            data_en <= 1'b0;
            reg_addr <= 5'd0;
            if(format == 2'd0) begin
                case (opcode) 
                    6'b101010: begin  // slt
                        if($signed(op1) < $signed(op2)) begin
                            data_out <= 8'd1;
                        end
                        else begin
                            data_out <= 8'd0;
                        end
                        write <= 1'b1;
                        new_pc <= pc + 1;
                    end
                    6'b100001: begin  // addu
                        data_out <= op1 + op2;
                        write <= 1'b1;
                        new_pc <= pc + 1;
                    end
                    6'b001000: begin  // jr
                        new_pc <= op1;
                    end
                    default: begin
                        valid <= 1'b0;
                        new_pc <= pc + 1;
                    end
                endcase
            end
            else if(format == 2'd2) begin
                case (opcode)
                    6'b001001: begin  // addiu
                        data_out <= op1 + imm[7:0];
                        write <= 1'b1;
                        new_pc <= pc + 1;
                    end
                    6'b000100: begin  // beq
                        if(op1 == op2) begin
                            new_pc <= pc + imm[7:0];
                        end
                        else begin
                            new_pc <= pc + 1;
                        end
                    end
                    6'b100011: begin  // lw 
                        data_addr <= op1 + imm[7:0];
                        write <= 1'b1;
                        new_pc <= pc + 1;
                        data_en <= 1'b1;
                    end
                    6'b000101: begin  // bne
                        if(op1 != op2) begin
                            new_pc <= pc + imm[7:0];
                        end
                        else begin
                            new_pc <= pc + 1;
                        end
                    end
                    default: begin
                        valid <= 1'b0;
                        new_pc <= pc + 1;
                    end
                endcase
            end
            else if(format == 2'd1) begin  // jal
                data_out <= pc + 8'd1;
                reg_addr <= 5'd31;
                write <= 1'b1;
                new_pc <= jumpt[7:0];
            end
            else begin
                valid <= 1'b0;
                new_pc <= pc + 1;
            end
        end
    end

endmodule