module divider(done,clk,old_remainder,old_quotient,old_divisor,old_counter,divider_size,dividend_size,new_remainder,new_quotient,new_divisor,new_counter,status);
    input [31:0] old_remainder,old_quotient,old_divisor;
    input [4:0]divider_size,dividend_size,old_counter;
    input clk,done;
    output reg [31:0] new_remainder,new_quotient,new_divisor;
    output reg [4:0] new_counter;
    output reg status;

    initial begin
        status <= 1'b0;
    end

    always @(posedge clk ) begin
        if(done == 1'b0)begin
            status <= 1'b1;
            if(dividend_size - divider_size > 0)begin
                new_remainder <= old_remainder;
                new_divisor <= (old_divisor << (dividend_size - divider_size));
                new_quotient <= old_quotient;
                new_counter <= old_counter;
            end
        end
        else if(inp == 1'b0)begin
            if (counter > 0) begin
                if($signed(remainder)<0)begin
                    remainder = remainder +div;
                    add_count = add_count+1;
                    quotient = quotient^1;
                end
                else begin
                    remainder = remainder - div;
                    sub_count = sub_count+1;
                end
                quotient = (quotient<<1) | 1'b1;
                counter = counter -1;
                div<= div>>1;
                if(counter == 0)begin
                    if($signed(remainder)<0)begin
                        remainder = remainder + div;
                        quotient = quotient ^ 1;
                        add_count = add_count+1;
                    end
                done <= 1'b1;
                end
            end
        end
    end



endmodule