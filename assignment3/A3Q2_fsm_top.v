`include "A3Q2_fsm.v"

module fsm_top;
    reg x, clk;
    wire y;

    fsm FSM(x, clk, y);

    initial begin
        clk = 1'b0;
        #100;
        $finish;
    end
    
    initial begin
        forever begin
            #5
            clk = ~clk;
        end
    end

    // always @(posedge clk) begin
    //     $display("t = %d: x - %d, y - %d", $time, x, y);
    // end

    initial begin
        #3  x=0;

        #10 x=1;

        #10 x=0;

        #10 x=1;

        #10 x=1;

        #10 x=1;

        #10 x=0;

        #10 x=1;

        #10 x=0;

        #10 x=1;
    end
endmodule