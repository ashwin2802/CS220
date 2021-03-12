`include "A5Q2_three_bit_comparator.v"

module least_index(A, B, C, D, index);
    input [2:0]  A, B, C, D;
    output reg[1:0] index;

    wire[5:0] l;
    wire e, g;

    // For instant output we have to manually compare all possible combinations
    three_bit_comparator COMP1 (A, B, l[0], e, g);
    three_bit_comparator COMP2 (C, D, l[1], e, g);
    three_bit_comparator COMP3 (A, C, l[2], e, g);
    three_bit_comparator COMP4 (B, D, l[3], e, g);  
    three_bit_comparator COMP5 (A, D, l[4], e, g);  
    three_bit_comparator COMP6 (B, C, l[5], e, g);  

    always @(A or B or C or D or l) begin
        if(l[0]) begin
            if(l[2]) begin
                if(l[4]) begin
                    index <= 2'b00;     // case: A < B && A < C && A < D
                end
                else begin 
                    index <= 2'b11;     // case: A < B && A < C && A > D
                end
            end
            else begin
                if(l[1]) begin
                    index <= 2'b10;     // case: A < B && A > C && C < D
                end
                else begin
                    index <= 2'b11;     // case: A < B && A > C && C > D
                end
            end
        end
        else begin
            if(l[3]) begin
                if(l[5]) begin
                    index <= 2'b01;     // case: A > B && B < D && B < C
                end
                else begin
                    index <= 2'b10;     // case: A > B && B < D && B > C
                end
            end
            else begin
                if(l[1]) begin
                    index <= 2'b10;     // case: A > B && B > D && C < D
                end
                else begin
                    index <= 2'b11;     // case: A > B && B > D && C > D
                end
            end
        end
    end

    // initial begin
    //     $dumpfile("least.vcd");
    //     $dumpvars(0, least_index);
    // end

endmodule