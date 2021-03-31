`include "A8Q1_defs.h"

module data_memory(clk, state, data_en, 
    row_num, row_data);

    input clk, data_en;
    input [2:0] state;
    input [3:0] row_num;
    output reg [7:0] row_data;

    reg [7:0] data [`DATA_SIZE-1:0];

    // Initialize data memory here
    initial begin
        data[0] <= 8'b11111010; // -6
        data[1] <= 8'b00000010; //  2
        data[2] <= 8'b00000101; //  5
        data[3] <= 8'b00000100; //  4
        data[4] <= 8'b00000110; //  6
        data[5] <= 8'b00000111; //  7
        data[6] <= 8'b00001111; //  15
        data[7] <= 8'b00001001; //  9
        data[8] <= 8'b00001000; //  8
        data[9] <= 8'b00001010; //  10. S = 60
        data[10] <= 8'b00001010; //  n = 10
    end

    always @(posedge clk) begin
        if(state == `MEM && data_en == 1'b1) begin      // Correct state and data fetch is required
            row_data <= data[row_num];                  // Fetch data from datamem
        end
    end

endmodule