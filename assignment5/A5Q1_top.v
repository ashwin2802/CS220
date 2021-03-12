`include "A5Q1_FSM.v"

module fsm_top;
    reg clk;
    reg [1:0] in;
    wire [3:0] state;

    FSM UUT(clk,in,state);

    initial begin
        clk <= 1'b0;
        in <= 2'b00;
    end

    // clock
    always begin
        #5
        clk <= ~clk;
    end

    // Testcase
    always begin        // Current State = 0
        #3
        in <= 2'b01;    // Next State = 1
        #10
        in <= 2'b11;    // Next State = 2
        #10
        in <= 2'b11;    // Next State = 3
        #10
        in <= 2'b01;    // Next State = 5
        #10
        in <= 2'b11;    // Next State = 7
        #10
        in <= 2'b10;    // Next State = 8
        #10
        in <= 2'b00;    // Next State = 9
        #10
        in <= 2'b00;    // Next State = 10
        #10
        in <= 2'b11;    // Next State = 12
    end

    // Simulate for 10 clock cycles
    initial begin
        #100
        $finish;
    end

    // Display current state and latest input on posedge
    always @(posedge clk) begin
        $display("t = %d: State = %d        Last input = %b", $time, state, in);
    end

    // initial begin
    //     $dumpfile("FSM.vcd");
    //     $dumpvars(0,fsm_top); 
    // end

endmodule