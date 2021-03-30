`include "A8Q1_size.h"
`include "A8Q1_processor.v"

module processor_top;
    reg clk;
    wire done;
    wire [7:0] data;

    processor PROC(clk, done, data);

    initial begin
        clk <= 1'b0;
    end

    initial begin
        forever begin
            #5
            clk <= ~clk;
        end
    end

    always @(posedge done) begin
       $display("Time = %d: Result in $%d: %b (%d)", $time, `OUTPUT_REG, data, data);
       $finish; 
    end

    initial begin
        $dumpfile("proc.vcd");
        $dumpvars(0, processor_top);
    end

endmodule