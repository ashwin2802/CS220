module register_file(read_address1,read_address2,write_address,read_enable1,read_enable2,write_enable,clk,write_in,read_out1,read_out2);
    input [4:0] read_address1,read_address2,write_address;
    input [15:0] write_in;
    input read_enable1,read_enable2,write_enable,clk;
    output reg [15:0] read_out1;
    output reg [15:0] read_out2;
    //Reading takes 2 clock_cycles
    //Writing takes 2 clock_cycles

    reg[15:0] registers[31:0];
    reg[1:0] counter; 
    initial begin
        registers[0] <= 16'd0;
        registers[1] <= 16'd0;
        registers[2] <= 16'd0;
        registers[3] <= 16'd0;
        registers[4] <= 16'd0;
        registers[5] <= 16'd0;
        registers[6] <= 16'd0;
        registers[7] <= 16'd0;
        registers[8] <= 16'd0;
        registers[9] <= 16'd0;
        registers[10] <= 16'd0;
        registers[11] <= 16'd0;
        registers[12] <= 16'd0;
        registers[13] <= 16'd0;
        registers[14] <= 16'd0;
        registers[15] <= 16'd0;
        registers[16] <= 16'd0;
        registers[17] <= 16'd0;
        registers[18] <= 16'd0;
        registers[19] <= 16'd0;
        registers[20] <= 16'd0;
        registers[21] <= 16'd0;
        registers[22] <= 16'd0;
        registers[23] <= 16'd0;
        registers[24] <= 16'd0;
        registers[25] <= 16'd0;
        registers[26] <= 16'd0;
        registers[27] <= 16'd0;
        registers[28] <= 16'd0;
        registers[29] <= 16'd0;
        registers[30] <= 16'd0;
        registers[31] <= 16'd0;    
        counter <= 2'd0;
    end

    always @(posedge clk ) begin
        if(read_enable1|read_enable2|write_enable)begin
            if (counter==2) begin
                if (read_enable1)begin
                    read_out1 <= registers[read_address1];
                    
                end
                if (read_enable2) begin
                    read_out2 <= registers[read_address2];
                end
                if (write_enable) begin
                    registers[write_address] <= write_in;
                end
                counter <= 0;
            end
            else begin
                counter <= counter+1;
            end
        end
    end

endmodule