`include "A1Q1_one_bit_adder.v"

module eight_bit_adder (x, y, carry_in, sum, carry_out);

   input [7:0] x, y;
   input carry_in;

   output wire [7:0] sum;
   output wire carry_out;

   wire [6:0] carry_mid;

   // sequentially connect eight one-bit full adders
   one_bit_adder FA0 (x[0], y[0], carry_in, sum[0], carry_mid[0]);
   one_bit_adder FA1 (x[1], y[1], carry_mid[0], sum[1], carry_mid[1]);
   one_bit_adder FA2 (x[2], y[2], carry_mid[1], sum[2], carry_mid[2]);
   one_bit_adder FA3 (x[3], y[3], carry_mid[2], sum[3], carry_mid[3]);
   one_bit_adder FA4 (x[4], y[4], carry_mid[3], sum[4], carry_mid[4]);
   one_bit_adder FA5 (x[5], y[5], carry_mid[4], sum[5], carry_mid[5]);
   one_bit_adder FA6 (x[6], y[6], carry_mid[5], sum[6], carry_mid[6]);
   one_bit_adder FA7 (x[7], y[7], carry_mid[6], sum[7], carry_out);

endmodule
