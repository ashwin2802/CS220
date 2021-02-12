`include "A3Q2_fsm.v"

module fsm_top;
    reg x, clk;
    wire y;

    fsm FSM(x, clk, y);

    initial begin
        clk <= 1'b0;
        #100;
        $finish;
    end
    
    initial begin
        forever begin
            #5
            clk <= ~clk;     // Generating a clock with clock cycle 10s
        end
    end

    always @(negedge clk) begin   // Printing the output at negedge
        $display("t = %d: x - %d, y - %d", $time, x, y);   //Displaying the outputs
    end 

    initial begin
        #3  x<=0;                               //Test cases

        #10 x<=1;

        #10 x<=0;

        #10 x<=1;                               // Till now alternating input thus input should be 1 till here

        #10 x<=1;                               // First point non-alternating input recieved so ouput should 0 from here onwards

        #10 x<=1;

        #10 x<=0;

        #10 x<=1;

        #10 x<=1;

        #10 x<=1;
    end

    // initial begin
    //     $dumpfile("fsm.vcd");
    //     $dumpvars(0,fsm_top);
    // end
endmodule