`include "A7Q2_processor.v"

module processor_top;
    reg clk,instruct_sig;
    reg [2:0] PC_initial,MAX_PC;
    reg [5:0] OUTPUT_REG;
    reg [31:0] instruct;

    wire[2:0] PC_final; 
    wire output_sig;
    wire instruct_over;
    processor mini_proccessor(clk,instruct,instruct_sig,PC_initial,MAX_PC,OUTPUT_REG,output_sig,PC_final,instruct_over);

    reg[31:0] instructions[5:0];
    reg counter;

    initial begin

        instructions[0] <= 32'b 00010100000000010000000000101101;
        instructions[1] <= 32'b 00010100000000101111111111101100;
        instructions[2] <= 32'b 00010100000000111111111111000100;
        instructions[3] <= 32'b 00000000001000100010100000100001;
        instructions[4] <= 32'b 00000000011001000011000000100001; 
        instructions[5] <= 32'b 00000000101001100010100000100011; 


    end

    initial begin
        instruct <= 32'b 00010100000000010000000000101101;
        instruct_sig <= 1'b0;
        clk <= 1'b0;
        MAX_PC <= 3'd5;
        OUTPUT_REG <= 5'd6;
        PC_initial <= 3'd0;
        counter <= 1'b0;
    end

    always begin
        #5
        clk <= ~clk;
    end
    initial begin
        #200
        $finish;
    end

    

    always @(posedge clk ) begin
        if(instruct_over == 1'b0) begin
            if(output_sig == 1'b1)begin
                if(counter == 1'b0)  begin
                    instruct_sig <= 1'b1;
                    counter <= 1'b1;
                    PC_initial <= PC_final;
                end
                else if(counter == 1'b1) begin
                    instruct_sig <= 1'b0;
                    counter <= 1'b1;
                    instruct <= 1'b0;
                end
            end
        end
        else if(instruct_over == 1'b1)begin
            instruct_sig <= 1'b0;
        end
    end

        // gtkwave debugging

    initial begin
        $dumpfile("A7Q2.vcd");
        $dumpvars(0, processor_top);
    end

    
endmodule