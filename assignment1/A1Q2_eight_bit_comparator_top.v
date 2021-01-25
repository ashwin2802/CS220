`include "A1Q2_eight_bit_comparator.v"

module eight_bit_comparator_top;

   reg [7:0] A, B;
   wire L_out, E_out, G_out;

   eight_bit_comparator COMP (A, B, L_out, E_out, G_out);

   always @ (A or B or L_out or E_out or G_out) begin
       #0
       begin 
           $display("t = %d: %b ? %b - L: %b, E: %b, G: %b\n", $time, A, B, L_out, E_out, G_out);
       end
   end

   initial begin
      A = 100; B = 100;
      #1
      A = 200; B = 200;
      #1
      A = 20; B = 200;
      #1 
      A = 200; B = 20;
      #1
      A = 1; B = 0;
      #1
      A = 0; B = 255;
      #1 
      A = 69; B = 96;
      #1 
      A = 143; B = 57;
      #1
      A = 56; B = 238;
      #1
      A = 145; B = 145;
      $finish;
   end

endmodule