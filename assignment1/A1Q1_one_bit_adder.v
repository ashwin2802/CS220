module one_bit_adder (a, b, c_in, sum, cout);

    input a, b, c_in;
    output wire sum, cout;

    assign sum = a ^ b ^ c_in;
    assign cout = (a & b) || (b & c_in) || (a & c_in);

endmodule