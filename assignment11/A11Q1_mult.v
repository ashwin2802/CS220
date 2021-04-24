module multiplier(opA, opB, op_en, clk, res, add, sub, done);
    input [31:0] opA, opB;
    input op_en, clk;

    output reg [63:0] res;
    output reg [4:0] add, sub;
    output reg done;
    
    reg [5:0] index;
    reg [63:0] A;
    reg [63:0] rem_mult;
    reg [64:0] B;

    initial begin
        done <= 1'b1;
        index <= 6'd0;
        sub <= 5'd0;
        add <= 5'd0;
        res <= 63'd0;
        A <= 63'd0;
        B <= 64'd0;
    end

    always @(posedge op_en) begin
        done <= 1'b0;
        index <= 6'd1;
        add <= 5'd0;
        sub <= 5'd0;
        res <= 63'd0;
        A <= $signed(opA);
        B[64:1] <= $signed(opB);
    end

    always @(posedge clk) begin
        if(B[index] != B[index-1]) begin
            if(B[index] == 1'b1) begin
                res <= res - (A << (index-1));
                sub <= sub + 5'd1;
            end
            else begin
                res <= res + (A << (index-1));
                add <= add + 5'd1;
            end
        end

        if (index == 6'd32) begin
            done <= 1'b1;
        end

        index <= index + 5'd1;
    end
endmodule