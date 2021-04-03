`include "A8Q2_defs.h"

module alu_unit(clk, state, pc, 
    format, opcode, op1, op2, 
    shift, imm, jumpt, new_pc, 
    data_addr, reg_addr, data_out, 
    data_en, valid, write);

    input clk;
    input [1:0] format;
    input [2:0] state;
    input [4:0] rs, shift;
    input [5:0] opcode;
    input [7:0] op1, op2, pc;
    input [15:0] imm;
    input [25:0] jumpt;

    output reg [7:0] data_out, new_pc;
    output reg [4:0] reg_addr;
    output reg [3:0] data_addr;
    output reg valid, write, data_en;

    initial begin
        valid <= 1'b0;      // stores validity of instruction
        write <= 1'b0;      // set to 1 if a result WB is required
        data_en <= 1'b0;    // set to 1 if a data MEM fetch is required
    end

    always @(posedge clk) begin
        if(state == `EX) begin
            valid <= 1'b1;
            write <= 1'b0;
            data_en <= 1'b0;
            reg_addr <= 5'd0;

            if(format == `R) begin
                case (opcode) 
                    `SLT: begin
                        if($signed(op1) < $signed(op2)) begin   // signed comparison
                            data_out <= 8'd1;       // store 1 for true
                        end
                        else begin
                            data_out <= 8'd0;       // store 0 for false
                        end
                        write <= 1'b1;              // result WB required
                        new_pc <= pc + 1;
                    end
                
                    `ADDU: begin
                        data_out <= op1 + op2;      // unsigned addition
                        write <= 1'b1;              // result WB required
                        new_pc <= pc + 1;
                    end
                
                    `JR: begin
                        new_pc <= op1;              // set jump target from register as new pc
                    end
                
                    default: begin
                        valid <= 1'b0;              // mark invalid
                        new_pc <= pc + 1;           // skip instruction
                    end
                endcase
            end

            else if(format == `I) begin
                case (opcode)

                    `ADDIU: begin
                        data_out <= op1 + imm[7:0];         // add unsigned immediate
                        write <= 1'b1;                      // need to write result
                        new_pc <= pc + 1;
                    end
                
                    `BEQ: begin
                        if(op1 == op2) begin
                            new_pc <= pc + imm[7:0];        // add offset to pc
                        end
                        else begin
                            new_pc <= pc + 1;               // fallthrough
                        end
                    end
                
                    `LW: begin
                        data_addr <= op1 + imm[7:0];        // compute data address
                        data_en <= 1'b1;                    // data fetch required
                        write <= 1'b1;                      // WB required after data loading
                        new_pc <= pc + 1;
                    end
                
                    `BNE: begin
                        if(op1 != op2) begin
                            new_pc <= pc + imm[7:0];    // add offset to pc
                        end
                        else begin
                            new_pc <= pc + 1;           // fallthrough
                        end
                    end
               
                    default: begin
                        valid <= 1'b0;              // mark invalid
                        new_pc <= pc + 1;           // skip instruction
                    end
                endcase
            end

            else if(format == `J) begin             // only jal in J format
                data_out <= pc + 8'd4;              // store pc + 4
                reg_addr <= 5'd31;                  // in $31
                write <= 1'b1;                      // WB to $31 needed
                new_pc <= jumpt[7:0];               // jump to target
            end

            else begin
                valid <= 1'b0;              // mark invalid
                new_pc <= pc + 1;           // skip instruction
            end
        end
    end

endmodule