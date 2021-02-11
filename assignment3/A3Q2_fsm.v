module fsm(x, clk, y);
    input x, clk;
    output reg y;

    reg [2:0] state, next_state;

    initial begin
        state <= 3'b000;
        next_state <= 3'b000;
        y <= 1'b1;
    end

    always @(posedge clk) begin 
        next_state[2] = (~x & (state[0] | state[2])) | (state[2] & (state[1] | state[0])) | (state[1] & x);
        next_state[1] = (state[2] & state[1]) | (~state[2] & ~state[1] & x) | (state[2] & ~state[0] & x);
        next_state[0] = ~state[0] | state[2] | (state[1] & x) | (~state[1] & state[0] & ~x);
        
        y = ~next_state[2] | next_state[1] | ~next_state[0];

        state[2] <= next_state[2];
        state[1] <= next_state[1];
        state[0] <= next_state[0];

        $display("t = %d: x - %d, y - %d", $time,x, y);
    end
endmodule