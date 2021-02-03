`include "A2Q3_blink.v"

//`timescale 1ns/1ps
module blink_top;
    reg clk;
    wire out;
    blink fft(clk,out);  // initializing our hardware

    always @(out) begin
        $display("%d : %b",$time,out);
    end

    always begin
        clk = 0;  // Clock with time period = 5 with duty cycle 50%
        #5        // clk starts from 0 thus first computation occurs at t = 5 where the first posedge occurs
        clk = 1;
        #5
        clk = 0;
    end

    initial begin
        #3100000     // 10 * 310000 as time period = 10
        $finish;    // For generality set it at (time period * 310000) for arbitrary clocks 
    end


    // Uncomment the following section for visualizing using gtkwave
    // initial begin
    //     $dumpfile("blink.vcd");
    //     $dumpvars(0,blink_top);
    // end
endmodule

