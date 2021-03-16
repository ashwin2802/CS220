module decoder(inst, rs1, rs2, rd, shift, command, imm);
    input [33:0] inst;
    output reg [4:0] rs1, rs2, rd;
    output reg [3:0] shift;
    output reg [2:0] command;
    output reg [15:0] imm;

    always @(inst) begin
        if(inst[33:31] == 3'd0) begin
            // R format
            command <= inst[2:0];
            shift <= inst[6:3];
            rd <= inst[11:7];
            rs2 <= inst[16:12];
            rs1 <= inst[21:17];
        end
        else begin
            // I format
            command <= inst[33:31];
            rs1 <= inst[30:26];
            rs2 <= inst[25:21];
            rd <= inst[20:16];
            imm <= inst[15:0];
        end
    end

endmodule