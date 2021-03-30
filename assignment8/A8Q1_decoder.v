module decoder(clk, state, instruct, format, opcode, rs, rt, rd, shift_amt, immediate, target);
    input [31:0] instruct;              //32-bits instruction
    input [2:0] state;
    input clk;

    output reg [1:0] format;
    output reg [5:0] opcode;
    output reg [4:0] rs,rt,rd,shift_amt;
    output reg [15:0] immediate;
    output reg [25:0] target;

    always @(posedge clk) begin
        if(state == 3'd1) begin
            if(instruct[31:26] == 6'd0) begin                 // R-format
                format <= 2'd0;
                rs <= instruct[25:21];
                rt <= instruct[20:16];
                rd <= instruct[15:11];
                shift_amt <= instruct[10:6];
                opcode <= instruct[5:0];
            end
            else if(instruct[31:26] == 6'd3) begin          // J-format
                format <= 2'd1;
                opcode <= instruct[31:26];
                target <= instruct[25:0];
            end
            else begin                                       // I-format
                format <= 2'd2;
                opcode <= instruct[31:26];
                rs <= instruct[25:21];
                if(instruct[31:26] == 6'b000100 || instruct[31:26] == 6'b000101) begin
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