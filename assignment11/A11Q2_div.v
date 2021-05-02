module divider(clk,inp,dividend,dividend_length,divisor,divisor_length,quotient,remainder,add_count,sub_count,done);
    input clk,inp;
    input[31:0] dividend,divisor;
    input[4:0] dividend_length,divisor_length;

    output reg done;
    output reg [4:0] add_count,sub_count;
    output reg [31:0] quotient,remainder;
    
    reg [31:0] div;
    reg [5:0] counter;

    initial begin
        status <= 1'b0;
    end

    always @(posedge clk ) begin
        if(inp == 1'b1)begin  // fetch new input
            remainder <= dividend;
            quotient <= 31'd0;
            if(dividend_length > divisor_length)begin
                div <= divisor << (dividend_length - divisor_length);
            end
            add_count <= 0;
            sub_count <= 0;
            counter <= 0;
            done <=1'b0;
        end
        else if(inp == 1'b0)begin
            if(dividend_length < divisor_length)begin
                done <= 1'b1;
            end
            else if (counter < dividend_length-divisor_length + 1) begin
                if (remainder[31] == 1'b0) begin  // Positive remainder : subtraction
                    remainder = remainder - div;
                    sub_count = sub_count + 1;
                end
                else begin         // Negative remainder: addition 
                    remainder = remainder +div;
                    add_count = add_count+1;
                    quotient = quotient ^ 1; // Correct quotient
                end

                quotient = (quotient<<1) | 1'b1; // Increment and shift quotient
                div <= div>>1; // Move to next bit
                counter = counter + 1;
            
                if (counter == dividend_length-divisor_length + 1) begin // Extra round
                    if(remainder[31] == 1'b1) begin  // Negative remainder
                        remainder = remainder + div;
                        quotient = quotient^1;
                        add_count = add_count+1;
                    end
                    done <= 1'b1;
                end
            end
        end
    end



endmodule