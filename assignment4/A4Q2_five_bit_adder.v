`include "A4Q1_one_bit_adder.v"

module five_bit_adder(A, B, opcode, sum, c_out, over); 

    input [4:0] A, B;
    input opcode;

    output wire [4:0] sum;
    output wire c_out, over;

    wire [3:0] c_mid;

    // Sequentially combine 5 one-bit adders
    one_bit_adder ADDER0(A[0], B[0], opcode, opcode, sum[0], c_mid[0]);      // opcode as c_in for first bit - adds one for 2s complement in subtraction
    one_bit_adder ADDER1(A[1], B[1], c_mid[0], opcode, sum[1], c_mid[1]);
    one_bit_adder ADDER2(A[2], B[2], c_mid[1], opcode, sum[2], c_mid[2]);
    one_bit_adder ADDER3(A[3], B[3], c_mid[2], opcode, sum[3], c_mid[3]);
    one_bit_adder ADDER4(A[4], B[4], c_mid[3], opcode, sum[4], c_out); 

    assign over = c_mid[3] ^ c_out;     // overflow bit

endmodule