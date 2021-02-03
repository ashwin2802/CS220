`include "A2Q4_rotate.v"

module rotate_top;

    reg clk;
    wire [3:0] out;

    shift_reg ROTATE (clk, out);    // instantiate hardware
    
    always @(out) begin
        $display("t = %d : %b", $time, out);     // Display outputs
    end

    initial begin
        clk = 1'b0;     // initialize clock
        #3100000;       // 10 * 310000 as time period = 10
        $finish;        // For generality set it at (time period * 310000) for arbitrary clocks 
    end

    always begin
        // 50% duty cycle so we wait for 10/2 = 5 cycles for a clock of 10 unit time period
        #5
        clk = ~clk;
    end

    // Uncomment the following section for visualizing using gtkwave
    // initial begin
    //     $dumpfile("rotate.vcd");
    //     $dumpvars(0, rotate_top);
    // end

endmodule