module decoder(clk,decode_enable,instruct,opcode,rs,rt,rd,shift_amt,func,immediate);
    input[31:0] instruct;              //32-bits instruction
    input clk;
    input decode_enable;               //Needed to enable the decoder
    output reg[5:0] opcode,func;
    output reg[4:0] rs,rt,rd,shift_amt;
    output reg[15:0]immediate;
    always @(negedge clk ) begin
        if(decode_enable == 1'b1)begin
            if(instruct[31:26] == 6'd0)begin                 //R-format
                opcode <= instruct[31:26];
                rs <= instruct[25:21];
                rt <= instruct[20:16];
                rd <= instruct[15:11];
                shift_amt <= instruct[10:6];
                func <= instruct[5:0];
            end
            else if(instruct[31:26] == 6'd9)begin            //I-format
                opcode <= instruct[31:26];
                rs <= instruct[25:21];
                rt <= instruct[20:16];
                immediate <= instruct[15:0];
            end
        end
    end
endmodule