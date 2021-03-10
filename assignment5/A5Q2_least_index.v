`include "A5Q2_three_bit_comparator.v"

module least_index(A, B, C, D, index);
    input [2:0]  A, B, C, D;
    output reg[1:0] index;

    wire[5:0] l;
    wire e, g;

    // three_bit_comparator COMP (ops[0], ops[1], l, e, g);
    three_bit_comparator COMP1 (A, B, l[0], e, g);
    three_bit_comparator COMP2 (C, D, l[1], e, g);
    three_bit_comparator COMP3 (A, C, l[2], e, g);
    three_bit_comparator COMP4 (B, D, l[3], e, g);  
    three_bit_comparator COMP5 (A, D, l[4], e, g);  
    three_bit_comparator COMP6 (B, C, l[5], e, g);  

    always @* begin
        if(l[0] == 1) begin
            if(l[2] == 1) begin
                if(l[4] == 1) begin
                    index = 2'b00;
                end
                else begin 
                    index = 2'b11;
                end
            end
            else begin
                if(l[1] == 1) begin
                    index = 2'b10;
                end
                else begin
                    index = 2'b11;
                end
            end
        end
        else begin
            if(l[3] == 1) begin
                if(l[5] == 1) begin
                    index = 2'b01;
                end
                else begin
                    index = 2'b10;
                end
            end
            else begin
                if(l[1] == 1) begin
                    index = 2'b10;
                end
                else begin
                    index = 2'b11;
                end
            end
        end
    end

    // initial begin
    //     $dumpfile("least.vcd");
    //     $dumpvars(0, least_index);
    // end


endmodule