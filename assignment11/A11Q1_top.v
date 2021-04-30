`include "A11Q1_mult.v"
`define NUM_OPS 10

module booth_top;

    reg [31:0] A, B;
    reg clk, en;
    
    wire [63:0] C;
    wire [4:0] add, sub;
    wire done;

    reg [31:0] datamemA [`NUM_OPS-1:0];
    reg [31:0] datamemB [`NUM_OPS-1:0];

    reg [3:0] opc;

    initial begin
        clk <= 1'b0;
        opc <= 1'b0;
        A <= 32'd0;
        B <= 32'd0;
    end

    initial begin
        forever begin
            #5
            clk <= ~clk;
        end
    end

    initial begin
        datamemA[0] <= -32'd91; datamemB[0] <= -32'd37;
        datamemA[1] <= 32'd10; datamemB[1] <= 32'd7;
        datamemA[2] <= -32'd25; datamemB[2] <= 32'd10;
        datamemA[3] <= -32'd300; datamemB[3] <= 32'd45;
        datamemA[4] <= 32'd420; datamemB[4] <= -32'd69;
        datamemA[5] <= 32'd1111; datamemB[5] <= 32'd1111;
        datamemA[6] <= -32'd10; datamemB[6] <= -32'd7;
        datamemA[7] <= 32'd100; datamemB[7] <= 32'd0;
        datamemA[8] <= 32'd0; datamemB[8] <= 32'd255;
        datamemA[9] <= -32'd123456; datamemB[9] <= -32'd654321;
    end

    multiplier MULT(A, B, en, clk, C, add, sub, done);

    always @(negedge clk) begin
        if(done == 1'b1) begin
            if(opc != 4'd0) begin
                $display("t = %d: A = %h (%d), B = %h (%d), A x B = %h (%d) - add ops = %d, sub ops = %d", $time, A, $signed(A), B, $signed(B), C, $signed(C), add, sub);
            end

            en <= 1'b1;
            A <= datamemA[opc];
            B <= datamemB[opc];
            opc <= opc + 1;

            if(opc == `NUM_OPS) begin
                $finish;
            end
        end
        else begin
            en <= 1'b0;
        end
    end

    initial begin
        $dumpfile("mult.vcd");
        $dumpvars(0, booth_top);
    end

endmodule
