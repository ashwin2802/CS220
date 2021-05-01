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
            if(divider_size - dividend_size > 0)begin
                new_remainder <= old_remainder;
                new_divisor <= (old_divisor << (divider_size - dividend_size));
                new_quotient <= old_quotient;
                new_counter <= old_counter;
            end
        end
        else if(done == 1'b1)begin
            status <= 1'b1;
            if (old_counter < (divider_size - dividend_size + 5'd1))begin
                new_divisor <= old_divisor >> 1;
                new_counter <= old_counter+1;
                if(old_remainder < 32'd0)begin
                    new_remainder <= old_remainder + old_divisor;
                    new_quotient <= ((old_quotient^(32'd1))<<1) || 32'd1;
                end
                else if(old_remainder >= 32'd0)begin
                    new_remainder <= old_remainder - old_divisor;
                    new_quotient <= (old_quotient << 1) || 32'd1;
                end
            end
            else if(old_counter == (divider_size - dividend_size + 5'd1))begin
                if(old_remainder < 32'd0)begin
                    new_remainder <= old_remainder + old_divisor;
                    new_quotient <= old_quotient^(32'd1);
                    new_counter <= old_counter+1;
                    new_divisor <= old_divisor;
                end
                else if(old_remainder >=32'd0)begin
                    new_remainder <= old_remainder;
                    new_quotient <= old_quotient;
                    new_counter <= old_counter+1;
                    new_divisor <= old_divisor;
                    status <= 1'b0;
                end
            end
            else begin
                status <= 1'b0;
            end
        end
    end



endmodule