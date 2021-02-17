`include "A4_Q2_worm.v"

module worm_top;
    reg clk;
    reg[5:0] in;
    wire[5:0] out1;
    wire[5:0] out2;

    worm a(in,clk,out1,out2);

    always @(negedge clk) begin
        $display("t = %d: Co-ordinates = (%d,%d)", $time, out1,out2);

    end

    always begin
        #5
        clk <= ~clk;
    end

    initial begin
        clk <= 1'b0;
        #200
        $finish;
    end  

    initial begin
        in <= 6'b000010;
        #10
        in <= 6'b000011;
        #10
        in <= 6'b010111;
        #10
        in <= 6'b100111;
        #10
        in <= 6'b111111;
        #20
        $finish;
    end

    

endmodule