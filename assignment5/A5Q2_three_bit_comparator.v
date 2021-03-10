`include "A5Q2_one_bit_comparator.v"

module three_bit_comparator (x, y, l_out, e_out, g_out);

   input [2:0] x, y;
   output wire l_out, e_out, g_out;

   wire [1:0] l_mid, e_mid, g_mid;

   // sequentially connect three one-bit comparators
   one_bit_comparator CA0 (x[2], y[2], 1'b0, 1'b1, 1'b0, l_mid[0], e_mid[0], g_mid[0]);
   one_bit_comparator CA1 (x[1], y[1], l_mid[0], e_mid[0], g_mid[0],  l_mid[1], e_mid[1], g_mid[1]);
   one_bit_comparator CA2 (x[0], y[0], l_mid[1], e_mid[1], g_mid[1], l_out, e_out, g_out);

endmodule
