`include "A5Q2_least_index.v"

module least_top;
    reg[2:0] A, B, C, D;    // input register - stores the 4 input values
    wire[1:0] index;         // output register - stores the output index 

    least_index UUT (A, B, C, D, index); // instantiate module

    // always @(A or B or C or D or index) begin
    //     $display("t = %d: A = %b(%d), B = %b(%d), C = %b(%d), D = %b(%d) - index = %b(%d)", $time, A, A, B, B, C, C, D, D, index, index);
    // end

    initial begin
        A <= 3'b110; B <= 3'b010; C <= 3'b001; D <= 3'b111;
        #1
        $display("t = %d: A = %b(%d), B = %b(%d), C = %b(%d), D = %b(%d) - index = %b(%d)", $time, A, A, B, B, C, C, D, D, index, index);
        A <= 3'b110; B <= 3'b010; C <= 3'b010; D <= 3'b111;
        #1
        $display("t = %d: A = %b(%d), B = %b(%d), C = %b(%d), D = %b(%d) - index = %b(%d)", $time, A, A, B, B, C, C, D, D, index, index);
        A <= 3'b100; B <= 3'b110; C <= 3'b101; D <= 3'b111;
        #1
        $display("t = %d: A = %b(%d), B = %b(%d), C = %b(%d), D = %b(%d) - index = %b(%d)", $time, A, A, B, B, C, C, D, D, index, index);
        A <= 3'b101; B <= 3'b011; C <= 3'b111; D <= 3'b101;
        #1
        $display("t = %d: A = %b(%d), B = %b(%d), C = %b(%d), D = %b(%d) - index = %b(%d)", $time, A, A, B, B, C, C, D, D, index, index);
        A <= 3'b111; B <= 3'b101; C <= 3'b111; D <= 3'b101;
        #1
        $display("t = %d: A = %b(%d), B = %b(%d), C = %b(%d), D = %b(%d) - index = %b(%d)", $time, A, A, B, B, C, C, D, D, index, index);
        A <= 3'b111; B <= 3'b111; C <= 3'b111; D <= 3'b101;
        #1
        $display("t = %d: A = %b(%d), B = %b(%d), C = %b(%d), D = %b(%d) - index = %b(%d)", $time, A, A, B, B, C, C, D, D, index, index);
        A <= 3'b000; B <= 3'b000; C <= 3'b000; D <= 3'b000;
        #1
        $display("t = %d: A = %b(%d), B = %b(%d), C = %b(%d), D = %b(%d) - index = %b(%d)", $time, A, A, B, B, C, C, D, D, index, index);
        A <= 3'b101; B <= 3'b101; C <= 3'b011; D <= 3'b100;
        #1
        $display("t = %d: A = %b(%d), B = %b(%d), C = %b(%d), D = %b(%d) - index = %b(%d)", $time, A, A, B, B, C, C, D, D, index, index);
        A <= 3'b010; B <= 3'b001; C <= 3'b101; D <= 3'b110;
        #1
        $display("t = %d: A = %b(%d), B = %b(%d), C = %b(%d), D = %b(%d) - index = %b(%d)", $time, A, A, B, B, C, C, D, D, index, index);
        A <= 3'b111; B <= 3'b000; C <= 3'b011; D <= 3'b101;
        #1
        $display("t = %d: A = %b(%d), B = %b(%d), C = %b(%d), D = %b(%d) - index = %b(%d)", $time, A, A, B, B, C, C, D, D, index, index);
        $finish;
    end

endmodule