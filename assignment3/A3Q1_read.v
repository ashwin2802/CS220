module dram_bank(clk, row_num, input_valid, output_data, output_valid);
    input clk, input_valid;
    input [3:0] row_num;
    output reg [31:0] output_data;
    output reg output_valid;

    reg [31:0] data [15:0];
    reg [3:0] open_row;
    reg [1:0] wait_cycles;

    initial begin
        data[0] <= 32'd0;
        data[1] <= 32'd1;
        data[2] <= 32'd2;
        data[3] <= 32'd3;
        data[4] <= 32'd4;
        data[5] <= 32'd5;
        data[6] <= 32'd6;
        data[7] <= 32'd7;
        data[8] <= 32'd8;
        data[9] <= 32'd9;
        data[10] <= 32'd10;
        data[11] <= 32'd11;
        data[12] <= 32'd12;
        data[13] <= 32'd13;
        data[14] <= 32'd14;
        data[15] <= 32'd15;

        open_row <= 4'bZZZZ;
        wait_cycles <= 2'd1;
    end

    always @(posedge clk) begin
        if (input_valid) begin
            if (open_row === 4'bZZZZ) begin
                wait_cycles = 2'd1;
                open_row = row_num;
                output_valid = 1'b0;
            end
            else if (open_row == row_num) begin
                wait_cycles = 2'd0;
            end
            else begin
                wait_cycles = 2'd2;
                open_row = row_num;
                output_valid = 1'b0;
            end
        end

        if (wait_cycles > 0) begin
            wait_cycles = wait_cycles - 1;
            output_valid = 1'b0;
        end 
        else begin
            output_data = data[row_num];
            output_valid = 1'b1;
        end
    end

endmodule