module fsm(x, clk, y);
    input x, clk;
    output wire y; // connect a wire here to get the output

    reg [2:0] state;

    initial begin
        state <= 3'b000;     // FSM consists of 6 states thus 3 bits needed to store them and 000 is start state
    end

    always @(posedge clk) begin 
        
        // Implementing the next state function
        state[2] <= (~x & (state[0] | state[2])) | (state[2] & (state[1] | state[0])) | (state[1] & x);
        state[1] <= (state[2] & state[1]) | (~state[2] & ~state[1] & x) | (state[2] & ~state[0] & x);
        state[0] <= ~state[0] | state[2] | (state[1] & x) | (~state[1] & state[0] & ~x);


    end

    assign y = ~state[2] | state[1] | ~state[0]; // Assigning solution to the output wire
endmodule