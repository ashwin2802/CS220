`include "A4Q2_five_bit_adder.v"

module worm(in,clk,out1,out2);

    input [3:0] in;         // 4-bit encoded input - direction and steps
    input clk;

    output wire[4:0] out1, out2;    
    
    reg[4:0] state[1:0];    // Store location of worm
    wire[4:0] buff;         // Store next state computation results

    // Storage for adder operations 
    reg[4:0] A, B;
    reg opcode;
    wire overflow, c_out;

    five_bit_adder ADDER(A, B, opcode, buff, c_out, overflow);      // Instantiate adder module

    initial begin               // Inititalize at (0,0)
        state[0] <= 5'd0;
        state[1] <= 5'd0; 

        A <= 5'd0;
        B <= 5'd0;
        opcode <= 1'd0;
    end

    // Direction encoding: 00 - N, 01 - E, 10 - S, 11 - W

    always @(posedge clk) begin     // Compute next state using current input
        A <= state[in[2]];          // Current state: state[0] for N/S, state[1] for E/W
        B <= {in[1], in[0]};        // Number of steps
        opcode <= in[3];            // Add steps for N/E, subtract for S/W
    end

    always @(negedge clk) begin                     // Correct overflow before updating next state
        if(buff[4] == 1'b1) begin                   // 5th bit is 1 - result is negative or exceeds 15
            state[in[2]] <= {1'b0, {4{~in[3]}}};    // Set to 15 for N/E, 0 for S/W overflow
        end else begin
            state[in[2]] <= buff;                   // no overflow
        end
    end

    // Set outputs
    assign out1 = state[0];
    assign out2 = state[1];

    // initial begin
    //     $dumpfile("worm.vcd");
    //     $dumpvars(0, worm);
    //     $dumpvars(0, state[0][4:0]);
    //     $dumpvars(0, state[1][4:0]);
    // end

endmodule