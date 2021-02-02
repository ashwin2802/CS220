module shift_reg(clk, R);
    input clk;
    output reg[3:0] R;
    reg[14:0] counter;
    
    initial begin
        R = 4'b1000;
        counter = 0;
    end

    always @(negedge clk) begin
        if(counter == 25000) begin
            R[3] <= R[2];
            R[2] <= R[1];
            R[1] <= R[0];
            R[0] <= R[3];
            counter <= 1;
        end
        else begin
            counter = counter + 1;
        end
    end

endmodule