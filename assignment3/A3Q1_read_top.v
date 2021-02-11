`include "A3Q1_read.v"

module read_top;

    reg clk, input_valid;
    reg [3:0] row_num;
    wire [31:0] output_data;
    wire output_valid;

    dram_bank RAM (clk, row_num, input_valid, output_data, output_valid);

    always @(posedge clk & output_valid) begin
        if(output_valid == 1'b1) begin
            $display("t = %d: Row num - %d, Data - %d", $time, row_num, output_data);
        end
    end

    always begin
        #5
        clk = ~clk;                   // Handling the clock and switching input_valid to 0 periodically as asked
        #5
        clk = ~clk;
        #3
        input_valid = 1'b0;
        #2
        clk = ~clk;
        #5
        clk = ~clk;
        #3
        input_valid = 1'b0;
        #2
        clk = ~clk;
        #5
        clk = ~clk;
    end

    initial begin
        clk = 1'b0;
        input_valid = 1'b0;
        #300;
        $finish;
    end

    initial begin
        #3
        row_num = 4'b0000;     // First test case sent at 3s, here no open row present so expected output at 15s after 1 cycle
        input_valid = 1;

        #30
        row_num = 4'b1111;    //  Input at 33s and row_num not equal to open row so ouput should occur at 35+20 = 55s
        input_valid = 1;
        
        #30
        row_num = 4'b1110;
        input_valid = 1;
        
        #30
        row_num = 4'b1010;
        input_valid = 1;
        
        #30
        row_num = 4'b1000;
        input_valid = 1;
        
        #30
        row_num = 4'b1000;   // Input at 153s, as open_row = row_num output should occur at 155s (the same cycle)
        input_valid = 1;
        
        #30
        row_num = 4'b1111;
        input_valid = 1;
        
        #30
        row_num = 4'b0000;
        input_valid = 1;
        
        #30
        row_num = 4'b0000;    // Input at 243s, as open_row = row_num output should occur at 245s (the same cycle)
        input_valid = 1;
        
        #30
        row_num = 4'b1010;
        input_valid = 1;
    end
endmodule