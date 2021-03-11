`include "A5_Q1_Microcode_ROM.v"
`include "A5_Q1_Next_State.v"

module FSM(clk,in,state);
    input clk;
    input[1:0] in;
    output reg[3:0] state;
    wire[2:0] branch_control;
    wire[3:0] next;

    initial begin
        state <= 4'd0;
    end

    Microcode_ROM FSM_MR(state,clk,branch_control);

    next_state FSM_next_state_func(state,clk,branch_control,next,in);
    always @(negedge clk ) begin
        state <= next;
    end

endmodule