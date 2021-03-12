`include "A5Q1_microcode_ROM.v"
`include "A5Q1_next_state.v"

module FSM(clk,in,state);
    input clk;
    input [1:0] in;

    output reg [3:0] state;

    wire [2:0] branch_control;
    wire [3:0] next;

    initial begin
        state <= 4'd0;  // Starting state
    end

    Microcode_ROM FSM_MR(state, clk, branch_control);
    next_state state_update(state, clk, branch_control, next, in);

    always @(next) begin
        state <= next;      // Fetch next state from next state function output as soon as it updates
    end

endmodule