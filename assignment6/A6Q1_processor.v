`include "A6Q1_decoder.v"
`include "A6Q1_register_file.v"
 
 module processor(instruct, clk, instruct_sig, output_sig, out1, out2, alu_res);
    input[33:0] instruct;
    input clk, instruct_sig;
    
    wire[4:0] read_address1, read_address2, write_address;
    wire[15:0] read_out1, read_out2;
    wire[2:0] opcode;

    reg read_enable1, read_enable2, write_enable;
    reg en;

    decoder decode_unit(instruct, clk, read_address1, read_address2, write_address, opcode);
    register_file reg_file(read_address1, read_address2, write_address, read_enable1, read_enable2, write_enable, clk, write_in, read_out1, read_out2); 
    
    reg [4:0] counter;

    initial begin
        read_enable1 <= 1'b0;
        read_enable2 <= 1'b0;
        write_enable <= 1'b0;
        counter <= 5'b0;
        output_sig <= 1'b0;   // Flag set to true when current operation is complete
    end

    always @(posedge clk) begin
        write_in <= instruct[15:0];

        if(instruct_sig == 0) begin                // Prepare for new instruction - Requires one cycle
            en <= 1'b1;
        end
        else if(en == 1'b1) begin
            counter <= counter + 1;

            if(opcode == 3'b000) begin             // Handling opcode 000
                write_enable <= 1'b1;              
                if(counter == 5'd2)begin           // Waiting 2 cycles for writing
                    output_sig <= 1'b1;
                    write_enable <= 1'b0;
                    counter <= 5'd0;
                    en <= 1'b0;
                end
            end

            else if(opcode == 3'b001) begin        // Handling opcode 001
                read_enable1 <= 1'b1;

                if(counter == 5'd2)begin           // Waiting 2 cycles for reading
                    output_sig <= 1'b1;
                    read_enable1 <= 1'b0;
                    counter <= 5'd0;
                    en <= 1'b0;
                end
            end

            else if(opcode == 3'b010) begin        // Handling opcode 010
                read_enable1 <= 1'b1;
                read_enable2 <= 1'b1;

                if(counter == 5'd2)begin           // Waiting 2 cycles for reading
                    output_sig <= 1'b1;
                    read_enable1 <= 1'b0;
                    read_enable2 <= 1'b0;
                    counter <= 5'd0;
                    en <= 1'b0;
                end
            end
            else if(opcode == 3'b011) begin        // Handling opcode 011
                read_enable1 <= 1'b1;
                write_enable <= 1'b1;

                if(counter == 5'd2)begin           // Waiting 2 cycles for writing and reading
                    output_sig <= 1'b1;
                    read_enable1 <= 1'b0;
                    write_enable <= 1'b0;
                    counter <= 5'd0;
                    en <= 1'b0;
                end
            end

            else if(opcode == 3'b100) begin        // Handling opcode 100
                read_enable1 <= 1'b1;
                read_enable2 <= 1'b1;
                write_enable <= 1'b1;

                if(counter == 5'd2)begin           // Waiting 2 cycles for writing and reading
                    output_sig <= 1'b1;
                    read_enable1 <= 1'b0;
                    read_enable2 <= 1'b0;
                    write_enable <= 1'b0;
                    counter <= 5'd0;
                end 
            end

            else if(opcode == 3'b101) begin         // Handling opcode 101
                read_enable1 <= 1'b1;
                read_enable2 <= 1'b1;
                write_enable <= 1'b0;

                if(counter == 5'd18)begin                   // Waiting 2 cycles for reading and 16 cycles for addition
                    alu_res <= (read_out1 + read_out2);     // Compute result
                    write_enable <= 1'b1;
                end

                if(counter == 5'd19) begin
                    write_in <= alu_res;                    // Send result for write
                    write_enable <= 1'b1;
                end

                if(counter == 5'd20)begin                   // Waiting 2 cycles for writing
                    output_sig <= 1'b1;
                    output_sig <= 1'b1;
                    read_enable1 <= 1'b0;
                    read_enable2 <= 1'b0;
                    write_enable <= 1'b0;
                    counter <= 5'd0;
                end
            end

            else if(opcode == 3'b110) begin          // Handling opcode 110
                read_enable1 <= 1'b1;
                read_enable2 <= 1'b1;
                write_enable <= 1'b0;

                if(counter == 5'd18)begin                   // Waiting 2 cycles for reading and 16 cycles for subtraction
                    alu_res <= (read_out1 - read_out2);     // Compute result
                    write_enable <= 1'b1;
                end

                if(counter == 5'd19) begin
                    write_in <= alu_res;                    // Send result for write
                    write_enable <= 1'b1; 
                end

                if(counter == 5'd20)begin                   // Waiting 2 cycles for writing
                    output_sig <= 1'b1;
                    read_enable1 <= 1'b0;
                    read_enable2 <= 1'b0;
                    write_enable <= 1'b0;
                    counter <= 5'd0;
                end
            end
            else if(opcode == 3'b111) begin             // Handling opcode 111
                read_enable1 <= 1'b1;
                write_enable <= 1'b0;
                if(counter == 5'd18) begin                  // Waiting 2 cycles for reading and 16 cycles for shifting
                    alu_res <= (read_out1 << write_in);     // Compute result
                    write_enable <= 1'b1;
                end
                if(counter == 5'd19) begin
                    write_in <= alu_res;                    // Send result for write
                    write_enable <= 1'b1;
                end
                if(counter == 5'd20)begin                   // Waiting 2 cycles for writing
                    output_sig <= 1'b1;
                    read_enable1 <= 1'b0;
                    read_enable2 <= 1'b0;
                    write_enable <= 1'b0;
                    counter <= 5'd0;
                end
            end
            else begin                              // handling cases where opcode maybe of the form xxx or zzz or some other gibberish form
                read_enable1 <= 1'b0;
                read_enable2 <= 1'b0;
                write_enable <= 1'b0;
                counter <= 5'd0;
                output_sig <= 1'b0;
            end
        
        end
    end

    always @(negedge clk) begin
        output_sig <= 1'b0;                         // Reset output flag
    end
    
    assign out1 = read_out1;                        // Give output to top module asynchronously
    assign out2 = read_out2;                        // Enable flags are synchronous
 
 endmodule