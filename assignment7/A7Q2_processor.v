`include "A7Q2_decoder.v"
`include "A7Q2_register_file.v"

module processor(clk,instruct,instruct_sig,PC_initial,MAX_PC,OUTPUT_REG,output_sig,PC_final);
    input clk,instruct_sig;
    input [31:0] instruct;
    input [2:0] PC_initial;
    output reg[2:0] PC_final;
    reg[2:0] state;
    input [2:0] MAX_PC;
    input [5:0] OUTPUT_REG;
    output reg output_sig;
    
    reg read_enable1,read_enable2,write_enable;
    reg [4:0] read_address1,read_address2,write_address;
    wire [7:0] read_out1,read_out2;
    reg [7:0] write_in;
    reg decode_enable;

    wire[5:0] opcode,func;
    wire[4:0] rs,rt,rd,shift_amt;
    wire[15:0] immediate;

    reg counter;
    reg instruct_valid;

    initial begin
        counter <= 1'd0;
        read_enable1 <= 1'b0;
        read_enable2 <= 1'b0;
        write_enable <= 1'b0;
        state <= 3'd0;
        decode_enable <= 1'b0;
        instruct_valid <= 1'b1;
        output_sig <= 1'b0;
    end


    always @(posedge clk ) begin
        if (instruct_sig == 0) begin
            if(state == 3'd0) begin
                write_enable <= 1'b0;
                read_enable1 <= 1'b0;
                read_enable2 <= 1'b0;
                PC_final <= PC_initial + 1;
                state <= 3'd1;
                instruct_valid <= 1'b1;
            end
            else if(state == 3'd1) begin
                decode_enable <= 1'b1;
                state <= 3'd2;
            end
            else if(state == 3'd2) begin
                decode_enable <= 1'b0;
                if(opcode == 6'd0) begin
                    read_address1 <= rs;
                    read_address2 <= rt;
                    read_enable1 <= 1'b1;
                    read_enable2 <= 1'b1;
                end
                else if(opcode == 6'd9) begin
                    read_address1 <= rs;
                    read_enable1 <= 1'b1;
                end
                state <= 3'd3;
            end
            else if(state == 3'd3) begin
                read_enable1 <= 1'b0;
                read_enable2 <= 1'b0;
                if(opcode == 6'd0) begin
                    if(func == 6'd33) begin
                        write_in <= read_out1 + read_out2;
                    end
                    else if(func == 6'd35) begin
                        write_in <= read_out1 - read_out2;
                    end

                end
                else if(opcode == 6'd9) begin
                    write_in <= read_out1 + immediate[7:0];
                end
                else begin
                    instruct_valid <= 1'b0;
                end
                state <= 3'd4;
            end
            else if(state == 3'd4) begin
                if(instruct_valid == 1)begin
                    if(opcode == 6'd0) begin
                        if(rd != 5'd0) begin
                            write_address <= rd;
                            write_enable <= 1'b1;
                        end
                    end
                    else if(opcode == 6'd9) begin
                        if(rt != 5'd0) begin
                            write_address <= rd;
                            write_enable <= 1'b1;
                        end
                    end

                end
                if(PC_final < MAX_PC) begin
                    state <= 3'd0;
                end
                else begin
                    state <= 3'd5;
                end

            end

            else if(state <= 3'd5)begin
                if (counter == 1'b0) begin
                    read_address1 <= OUTPUT_REG;
                    read_enable1 <= 1'b1;
                    counter <= 1'b1;
                end
                else if(counter == 1'b1) begin
                    $display("OUTPUT REGISTER CONTENT : %d",read_out1);
                    counter <= 1'b0;
                    output_sig <= 1'b1;
                end

            end
        end
    end

    register_file registers(clk,read_enable1,read_enable2,write_enable,read_address1,read_address2,write_address,read_out1,read_out2,write_in);
    decoder decode(clk,decode_enable,instruct,opcode,rs,rt,rd,shift_amt,func,immediate);


endmodule
