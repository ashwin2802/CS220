`include "A4Q1_eight_bit_adder.v"

module adder_top;
    reg [7:0] A, B;
    reg opcode, a, b, c_in;

    wire [7:0] sum;
    wire c_out, over, one_sum, cout;

    eight_bit_adder UUT(A, B, opcode, sum, c_out, over);

    initial begin
        A = 8'b00000000; B = 8'b01111111; opcode = 0;
        #1
        $display("t = %d: %b + %b + %b = %b, Carry = %b Over? = %b", $time, A, B, opcode, sum, c_out, over);

        A = 8'b00110000; B = 8'b01111111; opcode = 0;
        #1
        $display("t = %d: %b + %b + %b = %b, Carry = %b Over? = %b", $time, A, B, opcode, sum, c_out, over);

        A = 8'b10101000; B = 8'b01111111; opcode = 0;
        #1
        $display("t = %d: %b + %b + %b = %b, Carry = %b Over? = %b", $time, A, B, opcode, sum, c_out, over);

        A = 8'b00101010; B = 8'b01101011; opcode = 1;
        #1
        $display("t = %d: %b + %b + %b = %b, Carry = %b Over? = %b", $time, A, B, opcode, sum, c_out, over);

        A = 8'b01010100; B = 8'b01111111; opcode = 1;
        #1
        $display("t = %d: %b + %b + %b = %b, Carry = %b Over? = %b", $time, A, B, opcode, sum, c_out, over);

        A = 8'b00101000; B = 8'b01111111; opcode = 1;
        #1
        $display("t = %d: %b + %b + %b = %b, Carry = %b Over? = %b", $time, A, B, opcode, sum, c_out, over);

        A = 8'b00000000; B = 8'b01111111; opcode = 1;
        #1
        $display("t = %d: %b + %b + %b = %b, Carry = %b Over? = %b", $time, A, B, opcode, sum, c_out, over);

        A = 8'b00001010; B = 8'b01100111; opcode = 1;
        #1
        $display("t = %d: %b + %b + %b = %b, Carry = %b Over? = %b", $time, A, B, opcode, sum, c_out, over);

        A = 8'b00100100; B = 8'b11101111; opcode = 1;
        #1
        $display("t = %d: %b + %b + %b = %b, Carry = %b Over? = %b", $time, A, B, opcode, sum, c_out, over);

        A = 8'b01010000; B = 8'b01111111; opcode = 0;
        #1
        $display("t = %d: %b + %b + %b = %b, Carry = %b Over? = %b", $time, A, B, opcode, sum, c_out, over);

        $finish;

    end

    initial begin
        $dumpfile("add.vcd");
        $dumpvars(0,adder_top);
    end


endmodule