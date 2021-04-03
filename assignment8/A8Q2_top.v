`include "A8Q2_defs.h"
`include "A8Q2_processor.v"

module processor_top;
    reg clk;
    wire done;
    wire [7:0] data;

    // NOTE: Data Memory is initialized in A8Q2_datamem.v

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

    always @(posedge done) begin        // Display final output
       $display("Time = %d: Result in $%d: %b", $time, `OUTPUT_REG, data); // Answer displayed in  2's complement
       $finish; 
    end

    // initial begin
    //     $dumpfile("proc.vcd");
    //     $dumpvars(0, processor_top);
    // end

endmodule