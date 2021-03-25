`include "A7Q1_decoder.v"
`include "A7Q1_size.h"

module decoder_top;
    reg [31:0] instruct_mem [`NUM_INSTR-1:0];
    reg [31:0] instr;
    reg [3:0] pc; 
    reg clk, en;

    wire [3:0] format_counter [2:0];
    wire [3:0] reg_counter [3:0];

    initial begin
        clk <= 1'b0;
        pc <= 1'b0;
        en <= 1'b0;
    end

    initial begin
        forever begin
            clk <= 1'b0;
            #5
            clk <= 1'b1;
            #5
            clk <= 1'b0;
        end
    end

    initial begin
        instruct_mem[0] <= 32'b00100000000001000011010001010110; 
        instruct_mem[1] <= 32'b00100000000001011111111111111111;
        instruct_mem[2] <= 32'b00000000101001000011000001000000;
        instruct_mem[3] <= 32'b00100000000000110000000000000111;
        instruct_mem[4] <= 32'b00000000110000110011000000000100;
        instruct_mem[5] <= 32'b00000000000000110001100001000010;
        instruct_mem[6] <= 32'b10001100100001011001101010111100;
        instruct_mem[7] <= 32'b00001000000100100011010001010110;
    end

    decoder DEC(instr, en, format_counter[0], format_counter[1], format_counter[2], 
            reg_counter[0], reg_counter[1], reg_counter[2], reg_counter[3],
            clk);

    always @(posedge clk) begin
        if(pc < `NUM_INSTR) begin
            instr <= `PROP_DELAY instruct_mem[pc];
            en <=  `PROP_DELAY 1'b1;
        end
        else begin
            $display("Number of instructions per format: \n R: %d \t I: %d \t J: %d\n", format_counter[0], format_counter[1], format_counter[2]);
            $display("Number of writes per register: \n $3: %d \t $4: %d \t $5: %d \t $6: %d\n", reg_counter[0], reg_counter[1], reg_counter[2], reg_counter[3]);
            $finish;
        end

        pc <= `PROP_DELAY pc + 1;
    end

    always @(negedge clk) begin
        en <= `PROP_DELAY 1'b0;
    end

    // initial begin
    //     $dumpfile("dec.top");
    //     $dumpvars(0, decoder_top);
    // end

endmodule