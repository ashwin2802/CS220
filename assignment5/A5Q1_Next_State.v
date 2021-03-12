module next_state(current_state,clk,branch_control,new_state,in);
    input[3:0] current_state;
    input clk;
    input[2:0] branch_control;
    input[1:0]in;
    output reg[3:0] new_state;

    always @(posedge clk ) begin
        #2      //Modeling 2 second propogation delay
        if(branch_control == 3'd0)begin
            new_state <= current_state + 1;
        end
        else if(branch_control == 3'd1)begin
            if(in == 2'd0) begin
                new_state <= 4'd4;
            end
            else if(in == 2'd1) begin
                new_state <= 4'd5;
            end
            else begin
                new_state <= 4'd6;
            end
        end
        else if(branch_control == 3'd2)begin
            if(in ==2'd0 )begin
                new_state <= 4'd11;
            end
            else begin
                new_state <= 4'd12;
            end
        end
        else if(branch_control == 3'd3)begin
            new_state <= 4'd7;
        end
        else begin
            new_state <= 4'd0;
        end
    end

endmodule