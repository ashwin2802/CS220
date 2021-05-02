module divider(clk,dividend,divisor,inp,dividend_length,divisor_length,done,add_count,sub_count,quotient,remainder);
    input clk,inp;
    input[31:0] dividend,divisor;
    input[4:0] dividend_length,divisor_length;

    output reg done;
    output reg [4:0] add_count,sub_count;
    output reg [31:0] quotient,remainder;
    
    reg [31:0] div;
    reg [5:0] counter;

    initial begin
        remainder <= 31'd0;
        quotient <= 31'd0;
        div <= 31'd0;
        done <= 1'b1;
    end

    always @(posedge clk ) begin
        if(inp == 1'b1)begin
            remainder <= dividend;
            quotient <= 31'd0;
            div <= divisor << (dividend_length - divisor_length);
            add_count <= 0;
            sub_count <= 0;
            counter <= dividend_length-divisor_length + 1;
            done <=1'b0;
        end
        else if(inp == 1'b0)begin
            if (counter > 0) begin
                if($signed(remainder)>=0)begin
                    remainder <= remainder - div;
                    sub_count <= sub_count+1;
                end
                else if($signed(remainder)<0)begin
                    remainder <= remainder +div;
                    add_count <= add_count+1;
                    quotient = quotient^1;
                end
                quotient = (quotient<<1) || 1'b1;
                counter <= counter -1;
                div <= div>>1;
            end
            else if(counter == 0)begin
                if($signed(remainder)<0)begin
                    remainder <= remainder + div;
                    quotient <= quotient^1;
                    add_count <= add_count+1;
                end
                done <= 1'b1;
            end
        end
    end

endmodule;