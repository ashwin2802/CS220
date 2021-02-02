module decoder3to8(e_in, d_out);
    input [2:0] e_in;
    output wire[7:0] d_out;

    assign d_out[0] = ~e_in[0] & ~e_in[1] & ~e_in[2];
    assign d_out[1] = e_in[0] & ~e_in[1] & ~e_in[2];
    assign d_out[2] = ~e_in[0] & e_in[1] & ~e_in[2];
    assign d_out[3] = e_in[0] & e_in[1] & ~e_in[2];
    assign d_out[4] = ~e_in[0] & ~e_in[1] & e_in[2];
    assign d_out[5] = e_in[0] & ~e_in[1] & e_in[2];
    assign d_out[6] = ~e_in[0] & e_in[1] & e_in[2];
    assign d_out[7] = e_in[0] & e_in[1] & e_in[2];

endmodule
