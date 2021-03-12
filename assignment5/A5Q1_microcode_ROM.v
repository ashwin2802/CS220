module Microcode_ROM (current_state, clk, branch_control);
    input clk;
    input [3:0] current_state;
    
    output reg [2:0] branch_control;

    reg [2:0] rom [12:0];

    initial begin
        /* Five branches:
            0: Default transition - increment state by 1
            1: Transitions for S3  
            2: Transitions for S10
            3: Transitions to S7
            4: Transitions to S0
        */

        // Encode branches from state table
        rom[0] <= 3'd0;
        rom[1] <= 3'd0;
        rom[2] <= 3'd0;
        rom[3] <= 3'd1;
        rom[4] <= 3'd3;
        rom[5] <= 3'd3;
        rom[6] <= 3'd0;
        rom[7] <= 3'd0;
        rom[8] <= 3'd0;
        rom[9] <= 3'd0;
        rom[10] <= 3'd2;
        rom[11] <= 3'd4;
        rom[12] <= 3'd4;

        branch_control <= 3'd0; // Initialize default transition branch
    end 

    always @(posedge clk) begin
        branch_control <= rom[current_state];   // Send branch to state selection mux
    end

endmodule