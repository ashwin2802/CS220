`include "A11Q2_div.v"

module div_top;

    reg [31:0] old_remainder,old_quotient,old_divisor;
    reg [4:0]divider_size,dividend_size,old_counter;
    reg clk,done;
    wire [31:0] new_remainder,new_quotient,new_divisor;
    wire [4:0] new_counter;
    wire status;


    divider div(done,clk,old_remainder,old_quotient,old_divisor,old_counter,divider_size,dividend_size,new_remainder,new_quotient,new_divisor,new_counter,status);


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

        if(index > 10)begin
            $finish;
        end
    end

    initial begin
        clk <= 1'b1;
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

