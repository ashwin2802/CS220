`include "A1Q2_eight_bit_comparator.v"

module eight_bit_comparator_top;

    reg [7:0] A, B;
    wire L_out, E_out, G_out;

    // unit under test
    eight_bit_comparator COMP (A, B, L_out, E_out, G_out);

    // display intermediate inputs and outputs
    always @ (A or B or L_out or E_out or G_out) begin
        begin 
            $display("t = %d: %b ? %b - L: %b, E: %b, G: %b", $time, A, B, L_out, E_out, G_out);
        end
    end

    // testcases
    initial begin
        A = 100; B = 100;
        #1
        $display("\n");
      
        A = 200; B = 200;
        #1
        $display("\n");
        
        A = 20; B = 200;
        #1
        $display("\n"); 
        
        A = 200; B = 20;
        #1
        $display("\n");
      
        A = 1; B = 0;
        #1
        $display("\n");
      
        A = 0; B = 255;
        #1
        $display("\n"); 
      
        A = 69; B = 96;
        #1
        $display("\n"); 
        
        A = 143; B = 57;
        #1
        $display("\n");
      
        A = 56; B = 238;
        #1
        $display("\n");
      
        A = 145; B = 145;
        #1
        $display("\n");
        
        $finish;
    end

endmodule
