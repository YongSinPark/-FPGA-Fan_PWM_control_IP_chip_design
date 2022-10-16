`timescale 1ns / 1ps

module MUX_led(
    input [1:0] i_mode_select,
    output [2:0] o_mode
    );

    reg [2:0] r_mode;
    assign o_mode = r_mode;

    always @(i_mode_select) begin
        case(i_mode_select)
        3'h0: r_mode = 3'b000;
        3'h1: r_mode = 3'b001;
        3'h2: r_mode = 3'b010;
        3'h3: r_mode = 3'b100;
        endcase
    end
endmodule
