`include "A2Q2_priority_encoder3to8.v"

module priority_encoder_top;

    reg [7:0] A;
    wire [2:0] B;

    priority_encoder UUT (A,B); // Instantiate the priority encoder

    always @(A or B) begin
        // Display priority encoder inputs and outputs
        $monitor("t = %d : Input - %b --> Encoder Output: %b", $time, A, B);
    end

    // Test Cases
    initial begin
        A = 8'b10000000;
        #1
        A = 8'b01000000;
        #1
        A = 8'b00100000;
        #1
        A = 8'b00010000;
        #1
        A = 8'b00001000;
        #1
        A = 8'b00000100;
        #1
        A = 8'b00000010;
        #1
        A = 8'b00000001;
        #1
        A = 8'b00101010;
        #1
        A = 8'b01000011;
        #1
        A = 8'b11010000;
        #1
        A = 8'b11111111;
        #1
        A = 8'b10101010;
        #1
        A = 8'bxxxxxxx1;
        #1
        A = 8'bxxxxxx10;
        #1
        A = 8'bxxxxx100;
        #1
        A = 8'bxxxx1000;
        #1
        A = 8'bxxx10000;
        #1
        A = 8'bxx100000;
        #1
        A = 8'bx1000000;
        $finish;
    end

endmodule