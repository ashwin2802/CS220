module blink(clk,out);
    input clk;
    output reg out;
    integer counter;
    initial                 //Initialising the counter
        begin
            counter = 0;
        end

    initial begin
        out = 1'b0;
    end
    always @(posedge clk) begin  /// Making the clock positive edge triggered 
        if(counter == 25000)begin
            out <= ~out;
            counter <= 1;
        end
        else begin
            out <= out;
            counter <= counter+1;
        end
    end
endmodule