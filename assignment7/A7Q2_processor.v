`include "A7Q2_decoder.v"
`include "A7Q2_register_file.v"

module processor(clk,instruct,instruct_sig,PC_initial,MAX_PC,OUTPUT_REG,state,PC_final,instruct_over);
    input clk,instruct_sig;
    input [31:0] instruct;
    input [2:0] PC_initial;  //Program counter of current instruction
    input [2:0] MAX_PC; 
    input [5:0] OUTPUT_REG;
    
    output reg[2:0] PC_final; //Program counter of next instruction
    output reg[2:0] state;    //State of FSM
    output reg instruct_over; //Tells if all instructions complete or not
    
    reg read_enable1,read_enable2,write_enable;
    reg [4:0] read_address1,read_address2,write_address;
    reg [7:0] write_in;
    reg decode_enable;   //Enables the decoder
    reg counter;
    reg instruct_valid;  //Tells if the current instruction is valid

    wire[5:0] opcode,func;
    wire[4:0] rs,rt,rd,shift_amt;
    wire[15:0] immediate;
    wire [7:0] read_out1,read_out2;

    register_file registers(clk,read_enable1,read_enable2,write_enable,read_address1,read_address2,write_address,read_out1,read_out2,write_in);
    decoder decode(clk,decode_enable,instruct,opcode,rs,rt,rd,shift_amt,func,immediate);



    initial begin
        //Intializing various blocks of the processor
        counter <= 1'b0;
        read_enable1 <= 1'b0;
        read_enable2 <= 1'b0;
        write_enable <= 1'b0;
        state <= 3'd0;
        decode_enable <= 1'b0;
        instruct_valid <= 1'b1;
        instruct_over <= 1'b0;
        PC_final <= 3'd0;
    end


    always @(posedge clk ) begin
        if (instruct_sig == 0) begin
            if(state == 3'd0) begin      //Modeling state 0 of FSM
                write_enable <= 1'b0;
                read_enable1 <= 1'b0;
                read_enable2 <= 1'b0;
                PC_final <= PC_initial + 1;
                instruct_valid <= 1'b1;
                state <= 3'd1;


            end
            else if(state == 3'd1) begin  //Modeling state 1 of FSM
                decode_enable <= 1'b1;
                state <= 3'd2;
            end
            else if(state == 3'd2) begin  //Modeling state 2 of FSM
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
            else if(state == 3'd3) begin  //Modeling state 3 of FSM
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
            else if(state == 3'd4) begin   //Modeling state 4 of FSM
                read_enable1 <= 1'b0;
                read_enable2 <= 1'b0;
                if(instruct_valid == 1'b1)begin
                    if(opcode == 6'd0) begin
                        if(rd != 5'd0) begin
                            write_address <= rd;
                            write_enable <= 1'b1;
                
                        end
                    end
                    else if(opcode == 6'd9) begin
                        if(rt != 5'd0) begin
                            write_address <= rt;
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

            else if(state <= 3'd5)begin     //Modeling state 5 of FSM
                if (counter == 1'b0) begin
                    read_address1 <= OUTPUT_REG;
                    read_enable1 <= 1'b1;
                    counter <= 1'b1;
                end
                else if(counter == 1'b1) begin
                    $display("OUTPUT REGISTER CONTENT : %d",read_out1);   //Displaying the output here as state 5 is supposed to do that
                    counter <= 1'b0;
                    instruct_over <= 1'b1;
                end

            end
        end
    end

  

endmodule
