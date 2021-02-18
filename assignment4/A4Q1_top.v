`include "A4Q1_eight_bit_adder.v"

module adder_top;
    reg [7:0] A, B;
    reg opcode;

    wire [7:0] sum;
    wire c_out, over;

    eight_bit_adder UUT (A, B, opcode, sum, c_out, over);        // Instantiate hardware

    always @(A or B or opcode or sum or c_out or over) begin
        // Display operands and results
        $monitor("t = %d: A = %b, B = %b, opcode = %b - Result = %b, Carry = %b, Overflow? = %b", $time, A, B, opcode, sum, c_out, over);
    end

    // Testcases
    initial begin
        A = 8'b00000000; B = 8'b01111111; opcode = 0;
        #1

        A = 8'b00110000; B = 8'b01111111; opcode = 0;
        #1

        A = 8'b10101000; B = 8'b01111111; opcode = 0;
        #1

        A = 8'b00101010; B = 8'b01101011; opcode = 1;
        #1

        A = 8'b01010100; B = 8'b01111111; opcode = 1;
        #1

        A = 8'b00101000; B = 8'b01111111; opcode = 1;
        #1

        A = 8'b00000000; B = 8'b01111111; opcode = 1;
        #1

        A = 8'b00001010; B = 8'b01100111; opcode = 1;
        #1

        A = 8'b00100100; B = 8'b11101111; opcode = 1;
        #1

        A = 8'b01010000; B = 8'b01111111; opcode = 0;
        #1

        $finish;

    end

    // initial begin
    //     $dumpfile("add.vcd");
    //     $dumpvars(0,adder_top);
    // end


endmodule