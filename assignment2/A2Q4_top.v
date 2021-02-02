`include "A2Q4_rotate.v"

module rotate_top;
    reg clk;
    wire [3:0] out;

    shift_reg ROTATE (clk, out);
    
    always @(out) begin
        $display("t: %d - %b", $time, out);
    end

    initial begin
        clk = 1'b0;
        #3100000;
        $finish;
    end

    always begin
        #5
        clk = ~clk;
    end

    initial begin
        $dumpfile("rotate.vcd");
        $dumpvars(0, rotate_top);
    end

endmodule