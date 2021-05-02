module nonrestdiv(clk, inp, dvd, dvs, ldivdnd, ldivsr, done, adds, subs, quo, rem);

    input clk;
    input inp;
    input [31:0] dvd;
    input [31:0] dvs;
    input [4:0] ldivdnd;
    input [4:0] ldivsr;

    output reg done;
    output reg [5:0] adds;
    output reg [5:0] subs;
    output reg [31:0] quo;
    output reg [31:0] rem;

    reg [31:0] dividend;
    reg [31:0] divisor;
    reg [5:0] itrs;

    initial begin
        done <= 1;
    end

    always @(posedge clk) begin
        if (inp == 1) begin
            dividend <= dvd;
            divisor <= dvs << (ldivdnd - ldivsr);
            itrs <= ldivdnd - ldivsr + 1;
            rem <= dvd;
            quo <= 0;
            adds <= 0;
            subs <= 0;
            done <= 0;
        end
        else if (itrs > 0) begin
            if ($signed(rem) < 0) begin
                rem = rem + divisor;
                quo = quo ^ 1;
                adds <= adds + 1;
            end
            else begin
                rem = rem - divisor;
                subs <= subs + 1;
            end
            quo = (quo << 1) | 1'b1;
            divisor <= divisor >> 1;
            itrs = itrs - 1;
            if (itrs == 0) begin
                if ($signed(rem) < 0) begin
                    rem = rem + divisor;
                    quo = quo ^ 1;
                    adds = adds + 1;
                end
                done = 1;
            end
        end
    end

endmodule

module test;

    reg clk;
    reg inp;
    reg [31:0] dvd;
    reg [31:0] dvs;
    reg [4:0] ldivdnd;
    reg [4:0] ldivsr;

    wire done;
    wire [5:0] adds;
    wire [5:0] subs;
    wire [31:0] quo;
    wire [31:0] rem;

    reg [3:0] ptr;
    reg [31:0] dividends [0:9];
    reg [31:0] divisors [0:9];
    reg [4:0] ldvds [0:9];
    reg [4:0] ldvs [0:9];

    nonrestdiv uut(clk, inp, dvd, dvs, ldivdnd, ldivsr, done, adds, subs, quo, rem);

    initial begin
        ptr <= 0;
        dividends[0] <= 67;
        divisors[0] <= 14;
        ldvds[0] <= 7;
        ldvs[0] <= 4;
        dividends[1] <= 100;
        divisors[1] <= 25;
        ldvds[1] <= 7;
        ldvs[1] <= 5;
        dividends[2] <= 10;
        divisors[2] <= 11;
        ldvds[2] <= 4;
        ldvs[2] <= 4;
        dividends[3] <= 1009;
        divisors[3] <= 7;
        ldvds[3] <= 10;
        ldvs[3] <= 3;
        dividends[4] <= 36;
        divisors[4] <= 3;
        ldvds[4] <= 6;
        ldvs[4] <= 2;
        dividends[5] <= 93216134;
        divisors[5] <= 781649;
        ldvds[5] <= 27;
        ldvs[5] <= 20;
        dividends[6] <= 16384;
        divisors[6] <= 4;
        ldvds[6] <= 15;
        ldvs[6] <= 3;
        dividends[7] <= 71924821;
        divisors[7] <= 651892;
        ldvds[7] <= 27;
        ldvs[7] <= 20;
        dividends[8] <= 91;
        divisors[8] <= 17;
        ldvds[8] <= 7;
        ldvs[8] <= 5;
        dividends[9] <= 180836;
        divisors[9] <= 777;
        ldvds[9] <= 18;
        ldvs[9] <= 10;
    end

    always @(negedge clk) begin
        if (done == 1) begin
            if (ptr!=0) $display("Dividend: %d, Divisor: %d, Quotient: %d, Remainder: %d, Additions: %d, Subtractions: %d", dvd, dvs, quo, rem, adds, subs);
            ptr <= ptr + 1;
            inp <= 1;
            dvd <= dividends[ptr];
            dvs <= divisors[ptr];
            ldivdnd <= ldvds[ptr];
            ldivsr <= ldvs[ptr];
        end
        else begin
            inp <= 0;
        end
        if (ptr > 10) $finish;
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

endmodule