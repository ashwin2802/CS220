module one_bit_comparator (a, b, l_in, e_in, g_in, l_out, e_out, g_out);

    input a, b, l_in, e_in, g_in;
    output wire l_out, g_out, e_out;

    // comparator logic for one bit 
    // with previous bit comparison results as inputs
    assign l_out = l_in || (e_in & ~a & b);
    assign e_out = e_in & ((a & b) || (~a & ~b));
    assign g_out = g_in || (e_in & a & ~b);

endmodule
