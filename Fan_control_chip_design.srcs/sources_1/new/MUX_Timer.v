`timescale 1ns / 1ps

module MUX_Timer(
    input [3:0] i_10, i_1,
    input [1:0] i_mode,
    input [1:0] i_mode_select,
    output [3:0] o_timer_mode
    );

    reg [3:0] r_timer_mode;
    assign o_timer_mode = r_timer_mode;

    always @(i_mode_select) begin
        case (i_mode_select)
        2'h0 : r_timer_mode <= i_1;
        2'h1 : r_timer_mode <= i_10;
        2'h2 : r_timer_mode <= 4'b0001;
        2'h3 : r_timer_mode <= i_mode;
        endcase
        
    end
endmodule