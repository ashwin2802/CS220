`include "A4Q2_five_bit_adder.v"

module worm(in,clk,out1,out2);

    input in_valid;
    input [3:0] in;
    input clk;

    output wire[4:0] out1, out2;    
    
    reg[4:0] state[1:0];
    wire[4:0] buff;
    
    reg[1:0] direction, steps;    
    wire overflow, c_out;
    reg opcode;
    reg[4:0] A, B;

    five_bit_adder ADDER(A, B, opcode, buff, c_out, overflow);

    initial begin
        state[0] <= 5'd0;
        state[1] <= 5'd0; 
        A <= 5'd0;
        B <= 5'd0;
        opcode <= 1'd0;
        // buff <= 5'd0;
    end

    // 00 - N, 01 - E, 10 - S, 11 - W

    always @(posedge clk) begin
        // direction <= {in[3], in[2]};
        A <= state[in[2]];
        B <= {in[1], in[0]};
        opcode <= in[3];
    
        // #1
/*         if(buff[4] == 1'b1) begin
            state[in[2]] <= {1'b0, {4{~in[3]}}};
        end
        else begin
            state[in[2]] <= buff;
        end

        #1
        $display("t = %d: in:%b State:{%d, %d}, buff=%b, A = %b, B = %b\n", $time, in, state[0], state[1], buff, A, B); */
    end

    always @(negedge clk) begin
        if(buff[4] == 1'b1) begin
            state[in[2]] <= {1'b0, {4{~in[3]}}};
        end
        else begin
            state[in[2]] <= buff;
        end

        //$display("t = %d: in:%b State:{%d, %d}, buff=%b, A = %b, B = %b\n", $time, in, state[0], state[1], buff, A, B);
    end

    //  always @(posedge clk ) begin
    //     dir <= {in[3],in[2]};
    //     size <= {in[1],in[0]};
    //     if(dir == 2'd0)begin
    //         // temp = state[0]+size;
    //         five_bit_adder ADDER(state[0], size, 1'b0, temp, c_out, overflow);
    //         //$display("temp = %d size = %d   ",temp,size);
    //         if(temp < 5'd15)begin
    //             state[0] <= temp;
    //             //$display("state[0] = %d\n",state[0]);
    //         end
    //         else begin
    //             state[0] <= 5'd15;
    //         end
    //     end

    //     else if(dir == 2'd1)begin
    //         // temp = state[1]+size;
    //                     five_bit_adder ADDER(state[1], size, 1'b0, temp, c_out, overflow);
    //         if(temp < 5'd15)begin
    //             state[1] <= temp;
    //         end
    //         else begin
    //             state[1] <= 5'd15;
    //         end
    //     end
    //     else if(dir == 2'd2)begin
    //         // temp = state[0]-size;
    //         five_bit_adder ADDER(state[0], size, 1'b1, temp, c_out, overflow);
    //         if(temp <5'd15)begin
    //             state[0] <= temp;
    //         end
    //         else begin
    //             state[0] <= 5'd0;
    //         end
    //     end 
    //     else begin
    //         // temp = state[1] - size;
    //         five_bit_adder ADDER(state[1], size, 1'b1, temp, c_out, overflow);
    //         if(temp <5'd15)begin
    //             state[1] <= temp;
    //         end
    //         else begin
    //             state[1] <= 5'd0;
    //         end
    //     end
    //  end

     assign out1 = state[0];
     assign out2 = state[1];

     initial begin
         $dumpfile("worm.vcd");
         $dumpvars(0, worm);
         $dumpvars(0, state[0][4:0]);
         $dumpvars(0, state[1][4:0]);
     end

endmodule