`include "A8Q2_defs.h"

module data_memory(clk, state, data_en, 
    row_num, row_data);

    input clk, data_en;
    input [2:0] state;
    input [3:0] row_num;
    output reg [7:0] row_data;

    reg [7:0] data [`DATA_SIZE-1:0];

    // Initialize data memory here
    initial begin
        data[0] <= 8'b11101100; // -20
        data[1] <= 8'b00001010; //  10
        data[2] <= 8'b00000010; //  2
    end

    always @(posedge clk) begin
        if(state == `MEM && data_en == 1'b1) begin      // Correct state and data fetch is required
            row_data <= data[row_num];                  // Fetch data from datamem
        end
    end

endmodule