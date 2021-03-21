module decoder(instruct, clk, read_address1, read_address2, write_address, opcode);
    input[33:0] instruct;
    input clk;

    output wire[4:0] read_address1, read_address2, write_address;
    output wire[2:0] opcode;

    assign opcode = instruct[33:31];                  // opcode needed to decode the operation
    assign read_address1 = instruct[30:26];           // needed to decode register to read from
    assign read_address2 = instruct[25:21];           // needed to decode register to read from
    assign write_address = instruct[20:16];           // needed to decode register to write to

endmodule