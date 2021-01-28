module one_bit_adder (a, b, c_in, sum, c_out);

    input a, b, c_in;
    output wire sum, c_out;

    // full adder logic for a single bit
    assign sum = a ^ b ^ c_in;
    assign c_out = (a & b) || (b & c_in) || (a & c_in);

endmodule
