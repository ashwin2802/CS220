`include "A8Q2_defs.h"

module decoder(clk, state, instruct, 
    format, opcode, rs, rt, rd, 
    shift_amt, immediate, target);

    input [31:0] instruct;              //32-bits instruction
    input [2:0] state;
    input clk;

    output reg [1:0] format;
    output reg [4:0] rs, rt, rd, shift_amt;
    output reg [5:0] opcode;
    output reg [15:0] immediate;
    output reg [25:0] target;

    always @(posedge clk) begin
        if(state == `ID) begin                                // Decode state
            if(instruct[31:26] == 6'd0) begin                 // R-format
                format <= `R;
                rs <= instruct[25:21];
                rt <= instruct[20:16];
                rd <= instruct[15:11];
                shift_amt <= instruct[10:6];
                opcode <= instruct[5:0];
            end
            else if(instruct[31:26] == `JAL) begin            // J-format: only jal needs to be supported
                format <= `J;
                opcode <= instruct[31:26];
                target <= instruct[25:0];
            end
            else begin                                       // I-format
                format <= `I;
                opcode <= instruct[31:26];
                rs <= instruct[25:21];
                if(instruct[31:26] == `BEQ || instruct[31:26] == `BNE) begin  // 2 source operands for beq and bne - store second in rt to maintain uniformity
                    rt <= instruct[20:16];
                end
                else begin
                    rd <= instruct[20:16];
                end
                immediate <= instruct[15:0];
            end
        end
    end

endmodule