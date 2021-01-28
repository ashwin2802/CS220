`include "A1Q2_one_bit_comparator.v"

module eight_bit_comparator (x, y, l_out, e_out, g_out);

   input [7:0] x, y;
   output wire l_out, e_out, g_out;

   wire [6:0] l_mid, e_mid, g_mid;

   // sequentially connect eight one-bit comparators
   one_bit_comparator CA0 (x[7], y[7], 1'b0, 1'b1, 1'b0, l_mid[0], e_mid[0], g_mid[0]);
   one_bit_comparator CA1 (x[6], y[6], l_mid[0], e_mid[0], g_mid[0],  l_mid[1], e_mid[1], g_mid[1]);
   one_bit_comparator CA2 (x[5], y[5], l_mid[1], e_mid[1], g_mid[1],  l_mid[2], e_mid[2], g_mid[2]);
   one_bit_comparator CA3 (x[4], y[4], l_mid[2], e_mid[2], g_mid[2],  l_mid[3], e_mid[3], g_mid[3]);
   one_bit_comparator CA4 (x[3], y[3], l_mid[3], e_mid[3], g_mid[3],  l_mid[4], e_mid[4], g_mid[4]);
   one_bit_comparator CA5 (x[2], y[2], l_mid[4], e_mid[4], g_mid[4], l_mid[5], e_mid[5], g_mid[5]);
   one_bit_comparator CA6 (x[1], y[1], l_mid[5], e_mid[5], g_mid[5], l_mid[6], e_mid[6], g_mid[6]);
   one_bit_comparator CA7 (x[0], y[0], l_mid[6], e_mid[6], g_mid[6], l_out, e_out, g_out);

endmodule
