`include "A5_Q1_FSM.v"

module fsm_top;
reg clk;
reg[1:0] in;
wire[3:0] state;

FSM fsm_1(clk,in,state);

initial begin
    clk <= 1'b1;
    in <= 2'b00;
end

always begin
    #5
    clk <= ~clk;
end

always begin
    #13
    in <= 2'b01;
    #10
    in <= 2'b11; 
    #10
    in <= 2'b11;
    #10
    in <= 2'b00;
    #10
    in <= 2'b11;
    #10
    in <= 2'b10;
    #10
    in <= 2'b00;
    #10
    in <= 2'b00;
    #10
    in <= 2'b11;
    #10
    $finish;
end

initial begin
    #250
    $finish;
end

always @(state) begin
    $display("t = %d : State = %d",$time,state);
end

initial begin
    $dumpfile("FSM.vcd");
    $dumpvars(0,fsm_top); 
end

endmodule