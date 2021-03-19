`include "decoder.v"
`include "register_file.v"
 
 module processor(instruct,clk,instruct_sig,output_sig);
    input[33:0] instruct;
    input clk,instruct_sig;
    output reg output_sig;

    wire[4:0] read_address1;
    wire[4:0] read_address2;
    wire[4:0] write_address;
    wire[15:0] write_in;
    wire[15:0] read_out1;
    wire[15:0] read_out2;
    wire[2:0] opcode;
    reg read_enable1,read_enable2,write_enable;

    decoder decode_unit(instruct,clk,read_address1,read_address2,write_address,write_in,opcode);
    register_file reg_file(read_address1,read_address2,write_address,read_enable1,read_enable2,write_enable,clk,write_in,read_out1,read_out2); 
    
    reg [4:0] counter;

    initial begin
        read_enable1 <= 1'b0;
        read_enable2 <= 1'b0;
        write_enable <= 1'b0;
        counter <= 5'b0;
    end

    always @(posedge clk) begin
        output_sig <= instruct_sig;
        if(instruct_sig==0) begin
            counter <= counter+1;
            if(opcode == 3'b000) begin
                write_enable <= 1'b1;
            end
            else if(opcode == 3'b001) begin
                read_enable1 <= 1'b1;
                if(counter == 5'd2)begin
                    output_sig <= 1'b1;
                    read_enable1 <= 1'b0;
                    counter <= 5'd0;
                end

            end
            else if(opcode == 3'b010) begin
                read_enable1 <= 1'b1;
                read_enable2 <= 1'b1;
                if(counter == 5'd2)begin
                    output_sig <= 1'b1;
                    read_enable1 <= 1'b0;
                    read_enable2 <= 1'b0;
                    counter <= 0;
                end
            end
            else if(opcode == 3'b011) begin
                read_enable1 <= 1'b1;
                write_enable <= 1'b1;
                if(counter == 5'd2)begin
                    output_sig <= 1'b1;
                    read_enable1 <= 1'b0;
                    write_enable <= 1'b0;
                    counter <=0;
                end
            end
            else if(opcode == 3'b100) begin
                read_enable1 <= 1'b1;
                read_enable2 <= 1'b1;
                write_enable <= 1'b1;
                if(counter == 5'd2)begin
                    output_sig <= 1'b1;
                    read_enable1 <= 1'b0;
                    
                end 
            end
            else if(opcode == 3'b101) begin
                
            end
            else if(opcode == 3'b110) begin
                
            end
            else begin
                
            end
            
        end
    end
 
 
 endmodule