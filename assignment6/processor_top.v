`include "processor.v"
`define NUM_INSTR 9

module processor_top;
    reg [33:0] instr_mem [`NUM_INSTR:0];
    reg [33:0] instr;
    reg [3:0] pc;
    reg clk, instr_en;

    wire [15:0] data_out1, data_out2, data_out3;
    wire done;

    initial begin
        clk <= 1'b0;
        pc <= 4'd0;
        instr_en <= 1'b0;

        instr_mem[0] <= {3'b000, 5'd0, 5'd0, 5'd1, 16'd17};
        instr_mem[1] <= {3'b011, 5'd1, 5'd0, 5'd2, -16'd9};
        instr_mem[2] <= {3'b100, 5'd1, 5'd2, 5'd3, 16'd65};
        instr_mem[3] <= {3'b010, 5'd2, 5'd3, 5'd0, 16'd0};
        instr_mem[4] <= {3'b111, 5'd3, 5'd0, 5'd5, 16'd3};
        instr_mem[5] <= {3'b101, 5'd1, 5'd2, 5'd4, 16'd0};
        instr_mem[6] <= {3'b111, 5'd4, 5'd0, 5'd4, 16'd9};
        instr_mem[7] <= {3'b110, 5'd5, 5'd4, 5'd6, 16'd0};
        instr_mem[8] <= {3'b001, 5'd6, 5'd0, 5'd0, 16'd0};
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

    processor PROC(instr, clk, instr_en, done, data_out1, data_out2, data_out3);

    always @(posedge done) begin
        // if(instr[33:31] == 3'b000) begin
        //     $display("t = %d: (Op: %b) complete", $time, instr[33:31]);
        // end
        if(instr[33:31] == 3'b001) begin
            $display("t = %d: (Op: %b) - Read %b (%d) from %h", $time, instr[33:31], data_out1, data_out1, instr[30:26]);
        end
        else if(instr[33:31] == 3'b010) begin
            $display("t = %d: (Op: %b) - Read %b (%d) from %h", $time, instr[33:31], data_out1, data_out1, instr[30:26]);
            $display("t = %d: (Op: %b) - Read %b (%d) from %h", $time, instr[33:31], data_out2, data_out2, instr[25:21]);
        end
        else if(instr[33:31] == 3'b011) begin
            $display("t = %d: (Op: %b) - Read %b (%d) from %h", $time, instr[33:31], data_out1, data_out1, instr[30:26]);
        end
        else if(instr[33:31] == 3'b100) begin
            $display("t = %d: (Op: %b) - Read %b (%d) from %h", $time, instr[33:31], data_out1, data_out1, instr[30:26]);
            $display("t = %d: (Op: %b) - Read %b (%d) from %h", $time, instr[33:31], data_out2, data_out2, instr[25:21]);
        end
        else if(instr[33:31] == 3'b101) begin
            $display("t = %d: (Op: %b) - Wrote %b (%d) to %h", $time, instr[33:31], data_out3, data_out3, instr[20:16]);
        end
        else if(instr[33:31] == 3'b110) begin
            $display("t = %d: (Op: %b) - Wrote %b (%d) to %h", $time, instr[33:31], data_out3, data_out3, instr[20:16]);
        end
        else if(instr[33:31] == 3'b111) begin
            $display("t = %d: (Op: %b) - Wrote %b (%d) to %h", $time, instr[33:31], data_out3, data_out3, instr[20:16]);
        end

        instr_en <= 1'b0;
    end

    always @(posedge clk) begin
        if(instr_en == 1'b0) begin
            instr <= instr_mem[pc];
            instr_en <= 1'b1;

            // $display("t = %d: Send instruction #%d :- %b %d %d %d %d", $time, pc, instr[33:31], instr[30:26], instr[25:21], instr[20:16], instr[15:0]);

            if(pc < `NUM_INSTR) begin
                pc <= pc + 1;
            end
            else begin
                $finish;
            end
        end
    end

    initial begin
        $dumpfile("proc.vcd");
        $dumpvars(0, processor_top);
    end

endmodule