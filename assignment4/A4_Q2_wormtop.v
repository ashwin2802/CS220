`include "A4_Q2_worm.v"

module worm_top;
    reg clk;
    reg[3:0] in;
    wire[4:0] out1;
    wire[4:0] out2;
    reg in_valid;

    worm a(in,clk,out1,out2,in_valid);

    always @(negedge clk) begin
        $display("t = %d: Co-ordinates = (%d,%d)", $time, out1,out2);

    end

    always begin
        #5
        clk <= ~clk;
    end

    initial begin
        clk <= 1'b1;
        in_valid=1;
        #10
        in_valid=1;
        #200
        $finish;
    end  

    initial begin
        in <= 4'b0010;
        #10
        in <= 4'b0011;
        #10
        in <= 4'b0111;
        #10
        in <= 4'b1011;
        #10
        in <= 4'b1111;
        #10
        in <= 4'b0011;
        #10
        in <= 4'b1111;
        #20
        $finish;
    end

    initial begin
        $dumpfile("worm.vcd");
        $dumpvars(0,worm_top);
    end


endmodule