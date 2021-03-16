module memory(read_address1, read_address2, write_address, write_data, read_en1, read_en2, write_en, read_data1, read_data2, clk);
    input [4:0] read_address1, read_address2, write_address;
    input [15:0] write_data;
    input read_en1, read_en2, write_en, clk;
    output reg [15:0] read_data1, read_data2;

    reg [15:0] register_file [31:0];

    initial begin
        register_file[0] <= 16'd0;
        register_file[1] <= 16'd0;
        register_file[2] <= 16'd0;
        register_file[3] <= 16'd0;
        register_file[4] <= 16'd0;
        register_file[5] <= 16'd0;
        register_file[6] <= 16'd0;
        register_file[7] <= 16'd0;
        register_file[8] <= 16'd0;
        register_file[9] <= 16'd0;
        register_file[10] <= 16'd0;
        register_file[11] <= 16'd0;
        register_file[12] <= 16'd0;
        register_file[13] <= 16'd0;
        register_file[14] <= 16'd0;
        register_file[15] <= 16'd0;
        register_file[16] <= 16'd0;
        register_file[17] <= 16'd0;
        register_file[18] <= 16'd0;
        register_file[19] <= 16'd0;
        register_file[20] <= 16'd0;
        register_file[21] <= 16'd0;
        register_file[22] <= 16'd0;
        register_file[23] <= 16'd0;
        register_file[24] <= 16'd0;
        register_file[25] <= 16'd0;
        register_file[26] <= 16'd0;
        register_file[27] <= 16'd0;
        register_file[28] <= 16'd0;
        register_file[29] <= 16'd0;
        register_file[30] <= 16'd0;
        register_file[31] <= 16'd0;
    end

    always @(posedge clk) begin
        if(read_en1) begin
            read_data1 <= register_file[read_address1];
        end
        if(read_en2) begin
            read_data2 <= register_file[read_address2];
        end
        if(write_en) begin
            register_file[write_address] <= write_data;
        end
    end

endmodule