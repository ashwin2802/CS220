module one_bit_comparator (a, b, l_in, e_in, g_in, l_out, e_out, g_out);

    input a, b, l_in, e_in, g_in;
    output wire l_out, g_out, e_out;

    assign l_out = l_in || (e_in & ~a & b);
    assign e_out = e_in & ((a & b) || (~a & ~b));
    assign g_out = g_in || (e_in & a & ~b);

endmodule

// module one_bit_comp_top;
//     reg A, B;
//     wire Lout, Eout, Gout;

//     one_bit_comparator COMP (A, B, 1'b0, 1'b1, 1'b0, Lout, Eout, Gout);

//     always @ (A or B or Lout or Eout or Gout) begin
//         #0
//         begin
//             $display("t = %d: %b ? %b - L: %b, E: %b, G: %b\n", $time, A, B, Lout, Eout, Gout);
//         end
//     end

//     initial begin
//         A = 1; B = 0;
//         #1
//         A = 0; B = 1;
//         #1
//         A = 1; B = 1;
//         #1 
//         A = 0; B = 0;
//     end

// endmodule