`include "A4Q2_worm.v"

module worm_top;

    reg[3:0] in;
    reg clk;

    wire[4:0] out1, out2;

    worm BOARD (in, clk, out1, out2);       // instatiate hardware

    always @(out1 or out2) begin
        // Display last input and resulting state at the end of each clock period
        $display("t = %d: Input - %b, Location = (%d,%d)", $time, in, out1, out2);
    end

    // Clock with 10 time units period
    initial begin
        forever begin
            #5
            clk <= ~clk;
        end
    end

    // Simulation for 10 clock cycles
    initial begin
        clk <= 1'b0;
        #100
        $finish;
    end  

    // Direction encoding: 00 - N, 01 - E, 10 - S, 11 - W
    // Test Run
    initial begin
        #3              // 2 units before the rising edge
        in <= 4'b0011;  // 3 steps N
        #10
        in <= 4'b0110;  // 2 steps E
        #10
        in <= 4'b1111;  // 3 steps W
        #10
        in <= 4'b1000;  // 0 steps S
        #10
        in <= 4'b0101;  // 1 steps E
        #10
        in <= 4'b0010;  // 2 steps N
        #10
        in <= 4'b1101;  // 1 steps W
        #10
        in <= 4'b0010;  // 2 steps N
        #10
        in <= 4'b0111;  // 3 steps E
        #10
        in <= 4'b1001;  // 1 steps S
    end

endmodule