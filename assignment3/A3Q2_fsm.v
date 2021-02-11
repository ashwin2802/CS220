module fsm(x, clk, y);
    input x, clk;
    output reg y; // connect a wire here to get the output

    reg [2:0] state, next_state;

    initial begin
        state <= 3'b000;     // FSM consists of 6 states thus 3 bits needed to store them
        next_state <= 3'b000; // To store the next_state temporarily to get the output for the new input
        y <= 1'b1;  // Empty string considered alternating
    end

    always @(posedge clk) begin 
         // Implementing the next state functions and saving temporarily
        next_state[2] = (~x & (state[0] | state[2])) | (state[2] & (state[1] | state[0])) | (state[1] & x);
        next_state[1] = (state[2] & state[1]) | (~state[2] & ~state[1] & x) | (state[2] & ~state[0] & x);
        next_state[0] = ~state[0] | state[2] | (state[1] & x) | (~state[1] & state[0] & ~x);
        
        //Storing the output
        y = ~next_state[2] | next_state[1] | ~next_state[0];

        // Changing the state of out FSM according to next stat function permanently
        state[2] <= next_state[2];
        state[1] <= next_state[1];
        state[0] <= next_state[0];  
        
/*      state[2] <= (~x & (state[0] | state[2])) | (state[2] & (state[1] | state[0])) | (state[1] & x);
        state[1] <= (state[2] & state[1]) | (~state[2] & ~state[1] & x) | (state[2] & ~state[0] & x);
        state[0] <= ~state[0] | state[2] | (state[1] & x) | (~state[1] & state[0] & ~x);
 */

        //$display("t = %d: x - %d, y - %d", $time,x, y); //Displaying the output
    end

    //assign y = ~state[2] | state[1] | ~state[0];
endmodule