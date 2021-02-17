module worm(in,clk,out1,out2);

    input[5:0] in;
    input clk;
    output wire[5:0] out1;
    output wire[5:0] out2;
    reg[5:0] state[1:0];
    reg[1:0] dir;
    reg[3:0] size;
    reg[5:0] temp;

    initial begin
        state[0] = 5'd0;
        state[1] = 5'd0; 
    end

     always @(posedge clk ) begin
        dir <= {in[5],in[4]};
        size <= {in[3],in[2],in[1],in[0]};
        if(dir == 2'd0)begin
            temp = state[0]+size;
            //$display("temp = %d size = %d   ",temp,size);
            if(temp < 5'd15)begin
                state[0] <= temp;
                //$display("state[0] = %d\n",state[0]);
            end
            else begin
                state[0] <= 5'd15;
            end
        end

        else if(dir == 2'd1)begin
            temp = state[1]+size;
            if(temp < 5'd15)begin
                state[1] <= temp;
            end
            else begin
                state[1] <= 5'd15;
            end
        end
        else if(dir == 2'd2)begin
            temp = state[0]-size;
            if(temp >5'd0)begin
                state[0] <= state[0]-size;
            end
            else begin
                state[0] <= 5'd0;
            end
        end 
        else begin
            temp = state[1] - size;
            if(temp >5'd0)begin
                state[1] <= state[0] -size;
            end
            else begin
                state[1] <= 5'd0;
            end
        end
     end

     assign out1 = state[0];
     assign out2 = state[1];



endmodule