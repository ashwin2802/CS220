`include "A2Q1_decoder3to8.v"
`include "A2Q1_encoder8to3.v"

module autoencoder_top;

    reg[2:0] e_in;
    wire[2:0] e_out;
    wire[7:0] d_mid;

    decoder3to8 DECODER (e_in, d_mid);      // Instantiate decoder
    encoder8to3 ENCODER (d_mid, e_out);     // Instantiate encoder

    always @ (e_in or d_mid or e_out) begin
        // Display input, intermediate decoder output and final encoder output
        $monitor("t = %d: Input - %b --> Decoded Output: %b --> Re-encoded Output: %b", $time, e_in, d_mid, e_out);
    end

    // All 8 possible testcases
    initial begin
        e_in = 3'b000;
        #1
        e_in = 3'b001;
        #1
        e_in = 3'b010;
        #1
        e_in = 3'b011;
        #1
        e_in = 3'b100;
        #1
        e_in = 3'b101;
        #1
        e_in = 3'b110;
        #1
        e_in = 3'b111;
        #1
        $finish;
    end


endmodule