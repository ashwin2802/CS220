`include "A2Q3_blink.v"

module blink_top;

    reg clk;
    wire out;

    blink FFT (clk,out);  // instantiate our hardware

    always @(out) begin
        $display("t = %d : %b", $time, out);     // Display data bit
    end

    always begin
        // 50% duty cycle so we wait for 10/2 = 5 cycles for a clock of 10 unit time period
        #5        
        clk = ~clk; 
    end

    initial begin
        clk = 1'b0;  // initialize clock
        #3100000     // 10 * 310000 as time period = 10
        $finish;     // For generality set it at (time period * 310000) for arbitrary clocks 
    end

    // Uncomment the following section for visualizing using gtkwave
    // initial begin
    //     $dumpfile("blink.vcd");
    //     $dumpvars(0,blink_top);
    // end

endmodule

