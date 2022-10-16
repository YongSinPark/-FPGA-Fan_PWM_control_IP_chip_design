`timescale 1ns / 1ps

module MUX_motor(
    input i_mode1, i_mode2, i_mode3,
    input [1:0] i_mode_select,
    output o_mode
    );
    reg r_mode;
    assign o_mode = r_mode;

    always @(i_mode_select) begin
        case(i_mode_select)
        3'h0: r_mode = 3'h0;
        3'h1: r_mode = i_mode1;
        3'h2: r_mode = i_mode2;
        3'h3: r_mode = i_mode3;
        endcase
    end
endmodule
