`include "decoder.v"
`include "register_file.v"
 
 module processor(instruct,clk,instruct_sig,output_sig,out1,out2,alu_res);
    input[33:0] instruct;
    input clk,instruct_sig;
    output reg output_sig;
    wire[4:0] read_address1;
    wire[4:0] read_address2;
    wire[4:0] write_address;
    wire[15:0] write_data;
    reg[15:0] write_in;
    wire[15:0] read_out1;
    wire[15:0] read_out2;
    output wire[15:0] out1, out2;
    
    wire[2:0] opcode;
    reg read_enable1,read_enable2,write_enable;
    reg en;
    output reg[15:0] alu_res;

    decoder decode_unit(instruct,clk,read_address1,read_address2,write_address,opcode);
    register_file reg_file(read_address1,read_address2,write_address,read_enable1,read_enable2,write_enable,clk,write_in,read_out1,read_out2); 
    
    reg [4:0] counter;

    initial begin
        read_enable1 <= 1'b0;
        read_enable2 <= 1'b0;
        write_enable <= 1'b0;
        counter <= 5'b1;
        output_sig <= 1'b0;
    end

    always @(posedge clk) begin
        write_in <= instruct[15:0];
        if(instruct_sig == 0) begin
            en <= 1'b1;
        end
        else if(en == 1'b1) begin
            counter <= counter+1;
            if(opcode == 3'b000) begin
                write_enable <= 1'b1;
                if(counter == 5'd2)begin
                    output_sig <= 1'b1;
                    write_enable <= 1'b0;
                    counter <= 5'd1;
                    en <= 1'b0;
                end
            end
            else if(opcode == 3'b001) begin
                read_enable1 <= 1'b1;
                if(counter == 5'd2)begin
                    output_sig <= 1'b1;
                    read_enable1 <= 1'b0;
                    counter <= 5'd1;
                    en <= 1'b0;
                end
            end
            else if(opcode == 3'b010) begin
                read_enable1 <= 1'b1;
                read_enable2 <= 1'b1;
                if(counter == 5'd2)begin
                    output_sig <= 1'b1;
                    read_enable1 <= 1'b0;
                    read_enable2 <= 1'b0;
                    counter <= 5'd1;
                    en <= 1'b0;
                end
            end
            else if(opcode == 3'b011) begin
                read_enable1 <= 1'b1;
                write_enable <= 1'b1;
                if(counter == 5'd2)begin
                    output_sig <= 1'b1;
                    read_enable1 <= 1'b0;
                    write_enable <= 1'b0;
                    counter <= 5'd1;
                    en <= 1'b0;
                end
            end
            else if(opcode == 3'b100) begin
                read_enable1 <= 1'b1;
                read_enable2 <= 1'b1;
                write_enable <= 1'b1;
                if(counter == 5'd2)begin
                    output_sig <= 1'b1;
                    read_enable1 <= 1'b0;
                    read_enable2 <= 1'b0;
                    write_enable <= 1'b0;
                    counter <= 5'd1;
                end 
            end
            else if(opcode == 3'b101) begin
                read_enable1 <= 1'b1;
                read_enable2 <= 1'b1;
                write_enable <= 1'b0;
                if(counter == 5'd18)begin
                    alu_res <= (read_out1 + read_out2);
                    write_enable <= 1'b1;
                end
                if(counter == 5'd19) begin
                    write_in <= alu_res;
                    write_enable <= 1'b1;
                end
                if(counter == 5'd20)begin
                    output_sig <= 1'b1;
                    read_enable1 <= 1'b0;
                    read_enable2 <= 1'b0;
                    write_enable <= 1'b0;
                    counter <= 5'd1;
                end
            end
            else if(opcode == 3'b110) begin
                read_enable1 <= 1'b1;
                read_enable2 <= 1'b1;
                write_enable <= 1'b0;
                if(counter == 5'd18)begin
                    alu_res <= (read_out1 - read_out2);
                    write_enable <= 1'b1;
                end
                if(counter == 5'd19) begin
                    write_in <= alu_res;
                    write_enable <= 1'b1; 
                end
                if(counter == 5'd20)begin
                    output_sig <= 1'b1;
                    read_enable1 <= 1'b0;
                    read_enable2 <= 1'b0;
                    write_enable <= 1'b0;
                    counter <= 5'd1;
                end
            end
            else if(opcode == 3'b111) begin
                read_enable1 <= 1'b1;
                write_enable <= 1'b0;
                if(counter == 5'd18) begin
                    alu_res <= (read_out1 << write_in);
                    write_enable <= 1'b1;
                end
                if(counter == 5'd19) begin
                    write_in <= alu_res;
                    write_enable <= 1'b1;
                end
                if(counter == 5'd20)begin
                    output_sig <= 1'b1;
                    read_enable1 <= 1'b0;
                    read_enable2 <= 1'b0;
                    write_enable <= 1'b0;
                    counter <= 5'd1;
                end
            end
            else begin
                read_enable1 <= 1'b0;
                read_enable2 <= 1'b0;
                write_enable <= 1'b0;
                counter <= 5'd1;
                output_sig <= 1'b0;
            end
        
        end
    end

    always @(negedge clk) begin
        output_sig <= 1'b0;
    end
    
    assign out1 = read_out1;
    assign out2 = read_out2;
 
 endmodule