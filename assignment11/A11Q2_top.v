`include "A11Q2_div.v"

module div_top;

    reg [31:0] old_remainder,old_quotient,old_divisor;
    reg [4:0]divider_size,dividend_size,old_counter;
    reg clk,done;
    wire [31:0] new_remainder,new_quotient,new_divisor;
    wire [4:0] new_counter;
    wire status;

    reg [31:0]dividend,divisor;

    divider div(done,clk,old_remainder,old_quotient,old_divisor,old_counter,divider_size,dividend_size,new_remainder,new_quotient,new_divisor,new_counter,status);


    always @(negedge clk ) begin
        old_remainder <= new_remainder;
        old_divisor <= new_divisor;
        old_counter <= new_counter;
        old_quotient <= new_quotient;
        if(status == 1'b1)begin
            $display("t = %d: Remainder = %d  Quotient = %d Count = %d",$time,new_remainder,new_quotient,new_counter);
        end
    end

    initial begin
        clk <= 1'b0;
        done <= 1'b0;
    end

    initial begin
        forever begin
            #5   
            clk <= ~clk;
        end
    end

    initial begin
        old_remainder <= 32'd67;
        old_divisor <= 32'd14;
        dividend_size <= 5'd7;
        divider_size <= 5'd4;
        #5
        done <= 1'b1;
    end

    initial begin
        #500
        $finish;
    end

        // gtkwave debugging

    initial begin
        $dumpfile("divide.vcd");
        $dumpvars(0, div_top);
    end 







endmodule

