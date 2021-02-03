module blink(clk, B);

    input clk;
    output reg B;       // store data bit
    reg[14:0] counter;  // clock cycle counter

    initial begin
        B = 1'b0;       // initialize data bit as 0
        counter = 0;    // initialize counter
    end

    always @(negedge clk) begin  // negative edge triggered logic
        if(counter == 25000) begin
            B <= ~B;            // blink
            counter <= 1;       // reset counter
        end
        else begin
            counter <= counter + 1;
        end
    end

endmodule