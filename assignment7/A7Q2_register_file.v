module register_file(clk,read_enable1,read_enable2,write_enable,read_address1,read_address2,write_address,read_out1,read_out2,write_in);
    input[4:0] read_address1,read_address2,write_address;
    input clk,read_enable1,read_enable2,write_enable;
    input[7:0] write_in;

    output reg[7:0]read_out1,read_out2;

    reg[7:0] registers[31:0];
    initial begin
        registers[0] = 8'd0;
        registers[1] = 8'd0;
        registers[2] = 8'd0;
        registers[3] = 8'd0;
        registers[4] = 8'd0;
        registers[5] = 8'd0;
        registers[6] = 8'd0;
        registers[7] = 8'd0;
        registers[8] = 8'd0;
        registers[9] = 8'd0;
        registers[10] = 8'd0;
        registers[11] = 8'd0;
        registers[12] = 8'd0;
        registers[13] = 8'd0;
        registers[14] = 8'd0;
        registers[15] = 8'd0;
        registers[16] = 8'd0;
        registers[17] = 8'd0;
        registers[18] = 8'd0;
        registers[19] = 8'd0;
        registers[20] = 8'd0;
        registers[21] = 8'd0;
        registers[22] = 8'd0;
        registers[23] = 8'd0;
        registers[24] = 8'd0;
        registers[25] = 8'd0;
        registers[26] = 8'd0;
        registers[27] = 8'd0;
        registers[28] = 8'd0;
        registers[29] = 8'd0;
        registers[30] = 8'd0;
        registers[31] = 8'd0;
    end

    always @(negedge clk ) begin
        if(read_enable1 == 1'b1) begin
            read_out1 <= registers[read_address1];
        end
        if(read_enable2 == 1'b1) begin
            read_out2 <= registers[read_address2];
        end
        if(write_enable == 1'b1) begin
            registers[write_address] <= write_in;
        end
    end
endmodule