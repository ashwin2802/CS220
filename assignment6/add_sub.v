`include "one_bit_adder.v"

module sixteen_bit_adder(A, B, opcode, sum, c_out, over);

    input [15:0] A, B;
    input opcode;

    output wire [15:0] sum;
    output wire c_out, over;

    wire [14:0] c_mid;

    // Combine 8 one-bit adder blocks sequentially
    one_bit_adder ADDER0 (A[0], B[0], opcode, opcode, sum[0], c_mid[0]);     // opcode as c_in for first bit - adds one for 2s complement in subtraction
    one_bit_adder ADDER1 (A[1], B[1], c_mid[0], opcode, sum[1], c_mid[1]);
    one_bit_adder ADDER2 (A[2], B[2], c_mid[1], opcode, sum[2], c_mid[2]);
    one_bit_adder ADDER3 (A[3], B[3], c_mid[2], opcode, sum[3], c_mid[3]);
    one_bit_adder ADDER4 (A[4], B[4], c_mid[3], opcode, sum[4], c_mid[4]); 
    one_bit_adder ADDER5 (A[5], B[5], c_mid[4], opcode, sum[5], c_mid[5]);
    one_bit_adder ADDER6 (A[6], B[6], c_mid[5], opcode, sum[6], c_mid[6]);
    one_bit_adder ADDER7 (A[7], B[7], c_mid[6], opcode, sum[7], c_mid[7]);
    one_bit_adder ADDER8 (A[8], B[8], c_mid[7], opcode, sum[8], c_mid[8]);
    one_bit_adder ADDER9 (A[9], B[9], c_mid[8], opcode, sum[9], c_mid[9]);
    one_bit_adder ADDER10 (A[10], B[10], c_mid[9], opcode, sum[10], c_mid[10]);
    one_bit_adder ADDER11 (A[11], B[11], c_mid[10], opcode, sum[11], c_mid[11]);
    one_bit_adder ADDER12 (A[12], B[12], c_mid[11], opcode, sum[12], c_mid[12]);
    one_bit_adder ADDER13 (A[13], B[13], c_mid[12], opcode, sum[13], c_mid[13]);
    one_bit_adder ADDER14 (A[14], B[14], c_mid[13], opcode, sum[14], c_mid[14]);
    one_bit_adder ADDER15 (A[15], B[15], c_mid[14], opcode, sum[15], c_out);

    assign over = c_mid[14] ^ c_out;     // overflow bit

endmodule