`include "A4_Q2_worm.v"

module worm_top;
    reg clk;
    reg[3:0] in;
    wire[4:0] out1;
    wire[4:0] out2;
    reg in_valid;

    worm a(in,clk,out1,out2);

    always @(out1 or out2) begin
        $display("t = %d: Input - %b, Location = (%d,%d)", $time,in, out1,out2);
    end

    initial begin
        forever begin
            #5
            clk <= ~clk;
        end
    end

    initial begin
        clk <= 1'b0;
        #100
        $finish;
    end  

    initial begin
        #3
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