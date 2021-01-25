`include "A1Q1_eight_bit_adder.v"

module eight_bit_adder_top;

   reg [7:0] A, B;
   reg C_in;

   wire [7:0] Sum;
   wire Carry;

   eight_bit_adder ADDER (A, B, C_in, Sum, Carry);

   always @ (A or B or C_in or Sum or Carry) begin
       #0
       begin 
           $display("t = %d: %b + %b + %b = %b, Carry = %b\n", $time, A, B, C_in, Sum, Carry);
       end
   end

   initial begin
      A = 100; B = 100; C_in = 1;
      #1
      A = 200; B = 200; C_in = 0;
      #1
      A = 20; B = 200; C_in = 0;
      #1
      A = 142; B = 60; C_in = 1;
      #1
      A = 159; B = 231; C_in = 0;
      #1
      A = 180; B = 150; C_in = 1;
      #1
      A = 50; B = 13; C_in = 0;
      #1
      A = 88; B = 65; C_in = 1;
      #1
      A = 102; B = 255; C_in = 0;
      #1
      A = 67; B = 22 ; C_in = 1;
      #1
      $finish;
   end

endmodule