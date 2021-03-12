module next_state(current_state, clk, branch_control, new_state, in);
    input clk;
    input [3:0] current_state;
    input [2:0] branch_control;
    input [1:0] in;

    output reg [3:0] new_state;

    reg [3:0] dispatches [1:0][3:0];        // Dispatch ROMs

    initial begin
        dispatches[0][0] <= 4'd4;
        dispatches[0][1] <= 4'd5;
        dispatches[0][2] <= 4'd6;
        dispatches[0][3] <= 4'd6;

        dispatches[1][0] <= 4'd11;
        dispatches[1][1] <= 4'd12;
        dispatches[1][2] <= 4'd12;
        dispatches[1][3] <= 4'd12;

        new_state <= 4'd0;
    end

    always @(posedge clk) begin
        #2    // Propagation delay modelling - we wait for branch control and input fetch
        if(branch_control == 3'd0) begin
            new_state <= current_state + 4'd1;
        end
        else if(branch_control == 3'd1) begin
            new_state <= dispatches[0][in];
        end
        else if(branch_control == 3'd2) begin
            new_state <= dispatches[1][in];
        end
        else if(branch_control == 3'd3) begin
            new_state <= 4'd7;
        end
        else begin
            new_state <= 4'd0;
        end
    end

endmodule