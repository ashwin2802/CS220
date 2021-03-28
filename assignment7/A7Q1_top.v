`include "A7Q1_decoder.v"
`include "A7Q1_memory.v"

module decoder_top;
    wire [31:0] instr;
    reg [3:0] pc; 
    reg clk;
    wire en;

    wire [3:0] format_counter [2:0];
    wire [3:0] reg_counter [3:0];

    initial begin
        clk <= 1'b0;
        pc <= 1'b0;
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

    memory MEM(clk, pc, instr, en);
    decoder DEC(instr, en, format_counter[0], format_counter[1], format_counter[2], 
            reg_counter[0], reg_counter[1], reg_counter[2], reg_counter[3],
            clk);

    // Increment program counter
    always @(posedge clk) begin
        if(pc < `NUM_INSTR) begin
            pc <= pc + 1;
        end
        else begin
            $display("Number of instructions per format: \n R: %d \t I: %d \t J: %d\n", format_counter[0], format_counter[1], format_counter[2]);
            $display("Number of writes per register: \n $3: %d \t $4: %d \t $5: %d \t $6: %d\n", reg_counter[0], reg_counter[1], reg_counter[2], reg_counter[3]);
            $finish;
        end
    end

    // initial begin
    //     $dumpfile("dec.top");
    //     $dumpvars(0, decoder_top);
    // end

endmodule