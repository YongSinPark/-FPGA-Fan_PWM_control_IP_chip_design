`timescale 1ns / 1ps

module Decoder_2_4(
    input [1:0] i_select,
    input i_enable,
    output [3:0] o_FND_select
    );

    reg [3:0] r_FND_select;
    assign o_FND_select =r_FND_select;

    always @(i_enable) begin
        if(i_enable) r_FND_select <= 4'b1111;
        else begin
            case (i_select) 
            2'b00 : r_FND_select <= 4'b1110;
            2'b01 : r_FND_select <= 4'b1101;
            2'b10 : r_FND_select <= 4'b1111;
            2'b11 : r_FND_select <= 4'b0111;
            endcase
        end
    end

endmodule