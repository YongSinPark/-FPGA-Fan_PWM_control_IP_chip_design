`timescale 1ns / 1ps

module Comparator_motor(
    input [9:0] i_counter,
    output o_mode1, o_mode2, o_mode3
    );

    assign o_mode1 = (i_counter < 300) ? 1'b1 : 1'b0;
    assign o_mode2 = (i_counter < 600) ? 1'b1 : 1'b0;
    assign o_mode3 = (i_counter < 900) ? 1'b1 : 1'b0;
endmodule