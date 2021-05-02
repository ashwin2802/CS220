`include "A11Q2_div.v"

module div_top;

    reg clk,inp;
    reg[31:0] dividend,divisor;
    reg[4:0] dividend_length,divisor_length;

    wire done;
    wire [4:0] add_count,sub_count;
    wire [31:0] quotient,remainder;

    reg[31:0] dividend_list[0:9], divisor_list[0:9];
    reg[4:0] dividend_length_list[0:9], divisor_length_list[0:9]; 
    reg[4:0] index;

    divider div(clk,inp,dividend,dividend_length,divisor,divisor_length,quotient,remainder,add_count,sub_count,done);

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
    end

    initial begin 
        forever begin
            clk=0;
            #5
            clk=1;
            #5
            clk=0;
        end
    end

    // initial begin
    //     $dumpfile("div.top");
    //     $dumpvars(0, div_top);
    // end

<<<<<<< HEAD
endmodule
=======
endmodule;
>>>>>>> bb23131c2d180dbb258809ca9d90341fda28852d
