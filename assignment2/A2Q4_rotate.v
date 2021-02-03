module shift_reg(clk, R);

    input clk;
    output reg[3:0] R;  // store 4-bit data
    reg[14:0] counter;  // clock cycle counter
    
    initial begin
        R = 4'b1000;    // initialize data as 1000
        counter = 0;    // initialize counter
    end

    always @(negedge clk) begin    // Negative edge triggered logic
        if(counter == 25000) begin
            R[3] <= R[2];       // shift operation
            R[2] <= R[1];
            R[1] <= R[0];
            R[0] <= R[3];
            counter <= 1;       // reset counter
        end
        else begin
            counter <= counter + 1;
        end
    end

endmodule