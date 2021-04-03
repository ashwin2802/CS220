`include "A8Q2_defs.h"

module register_file(clk, state, read_address1, read_address2,
    write_address1, write_address2, write, format, valid, 
    read_out1, read_out2, write_in, done);
    
    input [7:0] write_in;
    input [4:0] read_address1, read_address2;
    input [4:0] write_address1, write_address2;
    input [2:0] state;
    input [1:0] format;
    input clk, write, valid;

    output reg [7:0] read_out1, read_out2;
    output reg done;

    reg [7:0] registers[31:0];

    initial begin
        // Initialising 32 registers each of width 8 bits
        registers[0] = 8'd0; registers[1] = 8'd0; registers[2] = 8'd0; registers[3] = 8'd0;
        registers[4] = 8'd0; registers[5] = 8'd0; registers[6] = 8'd0; registers[7] = 8'd0;
        registers[8] = 8'd0; registers[9] = 8'd0; registers[10] = 8'd0; registers[11] = 8'd0;
        registers[12] = 8'd0; registers[13] = 8'd0; registers[14] = 8'd0; registers[15] = 8'd0;
        registers[16] = 8'd0; registers[17] = 8'd0; registers[18] = 8'd0; registers[19] = 8'd0;
        registers[20] = 8'd0; registers[21] = 8'd0; registers[22] = 8'd0; registers[23] = 8'd0;
        registers[24] = 8'd0; registers[25] = 8'd0; registers[26] = 8'd0; registers[27] = 8'd0;
        registers[28] = 8'd0; registers[29] = 8'd0; registers[30] = 8'd0; registers[31] = 8'd0;

        done <= 1'b0;
    end

    always @(posedge clk) begin
        if(state == `RF) begin                       // Fetch source operands from registers
            read_out1 <= registers[read_address1];
            read_out2 <= registers[read_address2];
        end
        else if(state == `WB) begin                 // Write results to registers
            if(write == 1'b1 && valid == 1'b1) begin        // Write is required, instruction is valid
                if(format == `J && write_address2 != 5'd0) begin 
                    registers[write_address2] <= write_in;    // Write to register address computed by ALU - for jump targets
                end
                else if(write_address1 != 5'd0) begin
                    registers[write_address1] <= write_in;    // Write to instruction destination register
                end
            end
        end
        else if(state == `OUT) begin                // Fetch output and mark done
            read_out1 <= registers[`OUTPUT_REG];
            done <= 1'b1;
        end
    end

    // gtkwave debugging for register storage
    // initial begin
    //     $dumpfile("proc.vcd");
    //     $dumpvars(0, registers[0]);
    //     $dumpvars(0, registers[1]);
    //     $dumpvars(0, registers[2]);
    //     $dumpvars(0, registers[3]);
    //     $dumpvars(0, registers[4]);
    //     $dumpvars(0, registers[5]);
    //     $dumpvars(0, registers[6]);
    //     $dumpvars(0, registers[31]);
    // end


endmodule