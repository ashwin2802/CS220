`include "add_sub.v"
`include "shift.v"
`include "memory.v"
`include "decoder.v"

module processor(inst, out1, out2, out3, out4, out_en, done, clk);
    input [33:0] inst;
    output reg [5:0] out1, out2;
    output reg [15:0] out3, out4;
    input clk;
    output reg done;
    output reg [3:0] out_en;

    wire [5:0] read_addr1, read_addr2, write_addr;
    wire read_en1, read_en2, write_en, opcode, c_out, over;
    wire [2:0] command;
    wire [15:0] write_data, read_data1, read_data2;
    wire [3:0] shift;

    decoder DECODER(inst, read_addr1, read_addr2, write_addr, shift, command, write_data);

    always @(command) begin
        if(command == 3'b000) begin

        end
        if(command == 3'b001) begin
            
        end
        if(command == 3'b010) begin
            
        end
        if(command == 3'b011) begin
            
        end
        if(command == 3'b100) begin
            
        end
        if(command == 3'b101) begin
            
        end
        if(command == 3'b110) begin
            
        end
        if(command == 3'b111) begin
            
        end
    end

    memory MEM(read_addr1, read_addr2, write_addr, write_data, read_en1, read_en2, write_en, read_data1, read_data2, clk);

    add_sub ADDER(read_data1, read_data2, opcode, write_data, c_out, over);


endmodule