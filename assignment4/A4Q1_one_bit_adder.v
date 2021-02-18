module one_bit_adder(a, b, c_in, opcode, sum, c_out);

    input a, b, c_in, opcode;
    output wire sum, c_out;

    wire b_t;

    assign b_t = b ^ opcode;        // Flip bit for subtraction
    assign sum = a ^ b_t ^ c_in;
    assign c_out = (a & b_t) || (b_t & c_in) || (a & c_in);

endmodule