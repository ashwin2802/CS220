module decoder(instruct,clk,read_address1,read_address2,write_address,write_in,opcode);
    input[33:0] instruct;
    input clk;
    output reg[4:0] read_address1,read_address2,write_address;
    output reg[15:0] write_in;
    output reg[2:0] opcode;

    always @(posedge clk ) begin
        opcode <= instruct[33:31];
        write_address <= instruct[30:26];
        read_address1 <= instruct[25:21];
        read_address2 <= instruct[20:16];
        write_in <= instruct[15:0];
    end

endmodule