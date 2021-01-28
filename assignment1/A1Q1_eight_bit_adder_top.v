`include "A1Q1_eight_bit_adder.v"

module eight_bit_adder_top;

    reg [7:0] A, B;
    reg C_in; 

    wire [7:0] Sum;
    wire Carry;   

    // unit under test
    eight_bit_adder ADDER (A, B, C_in, Sum, Carry);   

    // display intermediate inputs and outputs
    always @ (A or B or C_in or Sum or Carry) begin
        begin 
            $display("t = %d: %b + %b + %b = %b, Carry = %b", $time, A, B, C_in, Sum, Carry);
        end
    end   

    // testcases
    initial begin
        A = 100; B = 100; C_in = 1;
        #1
        $display("\n");
        
        A = 200; B = 200; C_in = 0;
        #1
        $display("\n");
        
        A = 20; B = 200; C_in = 0;
        #1
        $display("\n");
       
        A = 142; B = 60; C_in = 1;
        #1
        $display("\n");
        
        A = 159; B = 231; C_in = 0;
        #1
        $display("\n");
       
        A = 180; B = 150; C_in = 1;
        #1
        $display("\n");
        
        A = 50; B = 13; C_in = 0;
        #1
        $display("\n");
        
        A = 88; B = 65; C_in = 1;
        #1
        $display("\n");
        
        A = 102; B = 255; C_in = 0;
        #1
        $display("\n");
       
        A = 67; B = 22 ; C_in = 1;
        #1
        $display("\n");
       
        $finish;
    end

endmodule
