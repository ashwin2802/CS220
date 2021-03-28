`include "A7Q1_size.h"

module decoder(instr, instr_en, numr, numi, numj, num3, num4, num5, num6, clk);
    input [31:0] instr;
    input clk, instr_en;

    output reg [3:0] numr, numi, numj;
    output reg [3:0] num3, num4, num5, num6;

    initial begin
        numr <= 3'd0;
        numi <= 3'd0;
        numj <= 3'd0;
        num3 <= 3'd0;
        num4 <= 3'd0;
        num5 <= 3'd0;
        num6 <= 3'd0;
    end

    always @(posedge instr_en) begin
        if (instr[31:26] == 6'b000000) begin
            numr <= `PROP_DELAY numr + 1;
            case (instr[15:11])
                3: begin
                    num3 <= `PROP_DELAY num3 + 1;
                end
                4: begin
                    num4 <= `PROP_DELAY num4 + 1;
                end
                5:begin
                    num5 <= `PROP_DELAY num5 + 1;
                end
                6: begin
                    num6 <= `PROP_DELAY num6 + 1;
                end
            endcase
        end
        else if(instr[31:26] == 6'b000010 || instr[31:26] == 6'b000011) begin
            numj <= `PROP_DELAY numj + 1;
        end
        else if(instr[31:26] > 6'b000011) begin
            numi <= `PROP_DELAY numi + 1;
            case (instr[20:16])
                3: begin
                    num3 <= `PROP_DELAY num3 + 1;
                end
                4: begin
                    num4 <= `PROP_DELAY num4 + 1;
                end
                5:begin
                    num5 <= `PROP_DELAY num5 + 1;
                end
                6: begin
                    num6 <= `PROP_DELAY num6 + 1;
                end
            endcase
        end
    end
    
endmodule