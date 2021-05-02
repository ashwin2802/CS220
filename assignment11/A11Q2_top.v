`include "A11Q2_div.v"

module div_top;

    reg [31:0] old_remainder,old_quotient,old_divisor;
    reg [4:0]divider_size,dividend_size,old_counter;
    reg clk,done;
    wire [31:0] new_remainder,new_quotient,new_divisor;
    wire [4:0] new_counter;
    wire status;


    divider div(done,clk,old_remainder,old_quotient,old_divisor,old_counter,divider_size,dividend_size,new_remainder,new_quotient,new_divisor,new_counter,status);

<<<<<<< HEAD
=======
    divider div(clk,inp,dividend,dividend_length,divisor,divisor_length,quotient,remainder,add_count,sub_count,done);
>>>>>>> Pre-submission modifications for Assignment 11

    always @(negedge clk ) begin
        if(done ==1)begin
            if(index !=0)begin
                $display("Time =%d : Dividend = %d Divisor = %d Remainder = %d Quotient = %d Additions = %d Subtractions = %d",$time,dividend,divisor,remainder,quotient,add_count,sub_count);
            end
            index <= index+1;
            inp <= 1'b1;
            dividend <= dividend_list[index];
            divisor <= divisor_list[index];
            dividend_length <= dividend_length_list[index];
            divisor_length <= divisor_length_list[index];
            
        end
        else begin
            inp <= 1'b0;
        end

        if(index > 4'd10)begin
            $finish;
        end
    end

    initial begin
<<<<<<< HEAD
        clk <= 1'b1;
        done <= 1'b0;
=======
        index <=1'b0;
        inp <= 1'b1;

        dividend_list[0] = 67;
        divisor_list[0] = 14;
        dividend_length_list[0] = 7;
        divisor_length_list[0] = 4;

        dividend_list[1] <= 68;
        divisor_list[1] <= 14;
        dividend_length_list[1] <= 7;
        divisor_length_list[1] <= 4;

        dividend_list[2] <= 99;
        divisor_list[2] <= 14;
        dividend_length_list[2] <= 7;
        divisor_length_list[2] <= 4;

        dividend_list[3] <= 13;
        divisor_list[3] <= 77;
        dividend_length_list[3] <= 4;
        divisor_length_list[3] <= 7;

        dividend_list[4] <= 87;
        divisor_list[4] <= 16;
        dividend_length_list[4] <= 7;
        divisor_length_list[4] <= 4;

        dividend_list[5] <= 78;
        divisor_list[5] <= 11;
        dividend_length_list[5] <= 7;
        divisor_length_list[5] <= 4;

        dividend_list[6] <= 57;
        divisor_list[6] <= 12;
        dividend_length_list[6] <= 6;
        divisor_length_list[6] <= 4;

        dividend_list[7] <= 67;
        divisor_list[7] <= 4;
        dividend_length_list[7] <= 7;
        divisor_length_list[7] <= 3;

        dividend_list[8] <= 6;
        divisor_list[8] <= 14;
        dividend_length_list[8] <= 3;
        divisor_length_list[8] <= 4;

        dividend_list[9] <= 156;
        divisor_list[9] <= 69;
        dividend_length_list[9] <= 8;
        divisor_length_list[9] <= 7;
>>>>>>> Pre-submission modifications for Assignment 11
    end

    initial begin
        forever begin
            #5   
            clk <= ~clk;
        end
    end
<<<<<<< HEAD

    initial begin
        
        old_remainder <= 32'd67;
        old_quotient <= 32'd0;
        old_divisor <= 32'd14;
        old_counter <= 5'd0;
        dividend_size <= 5'd7;
        divider_size <= 5'd4;
        #10
        done <= 1'b1;
        
/*         #95
        done <=1'b0;
        old_remainder <= 32'd99;
        old_quotient <= 32'd0;
        old_divisor <= 32'd15;
        old_counter <= 5'd0;
        dividend_size <= 5'd7;
        divider_size <= 5'd4;
        #5
        done <= 1'b1; */
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
=======

    // initial begin
    //     $dumpfile("div.top");
    //     $dumpvars(0, div_top);
    // end
>>>>>>> Pre-submission modifications for Assignment 11

