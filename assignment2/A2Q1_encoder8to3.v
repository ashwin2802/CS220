module encoder8to3(e_in, d_out);

    input [7:0] e_in;
    output wire[2:0] d_out;

    // Combinational encoder logic in SOP form
    assign d_out[0] = e_in[1] | e_in[3] | e_in[5] | e_in[7];
    assign d_out[1] = e_in[2] | e_in[3] | e_in[6] | e_in[7];
    assign d_out[2] = e_in[4] | e_in[5] | e_in[6] | e_in[7];

endmodule