`timescale 1ns / 1ps

module Digit_divider(
    input [4:0] i_counter, 
    input [1:0] i_mode_select,
    output [1:0] o_1000, 
    output [3:0] o_10, o_1
    );

    assign o_1000 = i_mode_select;
    assign o_10 = i_counter / 10 % 10;
    assign o_1 = i_counter % 10;
endmodule
