module dram_bank(clk, row_num, input_valid, output_data, output_valid);
    input clk, input_valid;
    input [3:0] row_num;
    output reg [31:0] output_data;
    output reg output_valid;

    reg [31:0] data [15:0];
    reg [3:0] open_row;
    reg wait_cycles, r_en, w_en;    // wait_cycles: keeps a count of number of cycles to wait after input cycle according to the case
                                    // r_en acts as a switch needed to handle when intially row_num is high impedence state
                                    // w_en acts as a switch to whether to give out an output if wait_cycle is 0 

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
        wait_cycles <= 2'b1;
        r_en <= 1'b0;
        w_en <= 1'b0;
    end

    always @(posedge clk) begin
        if (input_valid) begin
            if (r_en == 1'b0) begin     // The case when no row is open
                wait_cycles <= 1'd0;    // Setting the cycles to wait after this cycle = 0
                r_en <= 1'b1;
                w_en <= 1'b1;
                open_row <= row_num;
                output_valid <= 1'b0;
            end
            else if (open_row == row_num) begin    // The case when the row reqeusted is equal to the open row
                output_data <= data[row_num];       // Directly fetch output and return
                output_valid <= 1'b1;
            end
            else begin                      // The case when the requested row is not equal to currently open row
                wait_cycles <= 1'd1;        // Setting the cycles to wait after this cycle = 2
                open_row <= row_num;    
                output_valid <= 1'b0;
                w_en <= 1'b1;
            end
        end
        else begin
            if (wait_cycles > 1'd0) begin
                wait_cycles <= wait_cycles - 1;     // A decrementing counter that goes till 0
                output_valid <= 1'b0;
            end
            else if (w_en == 1'b1) begin            // When wait_cycles = 0 and w_en switch is turned on
                output_data <= data[row_num];
                output_valid <= 1'b1;
                w_en <= 1'b0;
            end
            else begin
                output_valid <= 1'b0;
            end
        end
    end
endmodule