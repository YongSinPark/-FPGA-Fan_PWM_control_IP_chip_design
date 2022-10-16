`timescale 1ns / 1ps

module FSM_motor_state(
    input i_clk, i_reset,
    input [3:0] i_button,
    input i_motor_end_sign,
    output [1:0] o_mode_select
    );
    parameter MODE_OFF = 2'h0, MODE_1 = 2'h1, MODE_2 = 2'h2, MODE_3 = 2'h3;

    reg [2:0] cur_state = 0, next_state = 0;
    reg [1:0] r_mode_select;

    assign o_mode_select = r_mode_select;

    always @(posedge i_clk, posedge i_reset) begin
        if(i_reset) cur_state <= MODE_OFF;
        else cur_state <= next_state;
    end

    always @(cur_state, i_motor_end_sign) begin
        if(i_motor_end_sign) next_state <= MODE_OFF;
        else begin
            next_state <= MODE_OFF;
            case(cur_state) 
            MODE_OFF : begin
                if(i_button[1] == 1'b1) next_state <= MODE_1;
                else if(i_button[2] == 1'b1) next_state <= MODE_2;
                else if(i_button[3] == 1'b1) next_state <= MODE_3;
                else next_state <= MODE_OFF;
            end
            MODE_1 : begin
                if(i_button[0] == 1'b1) next_state <= MODE_OFF;
                else if(i_button[2] == 1'b1) next_state <= MODE_2;
                else if(i_button[3] == 1'b1) next_state <= MODE_3;
                else next_state <= MODE_1;
            end
            MODE_2 : begin
                if(i_button[0] == 1'b1) next_state <= MODE_OFF;
                else if(i_button[1] == 1'b1) next_state <= MODE_1;
                else if(i_button[3] == 1'b1) next_state <= MODE_3;
                else next_state <= MODE_2;
            end
            MODE_3 : begin
                if(i_button[0] == 1'b1) next_state <= MODE_OFF;
                else if(i_button[1] == 1'b1) next_state <= MODE_1;
                else if(i_button[2] == 1'b1) next_state <= MODE_2;
                else next_state <= MODE_3;
            end
            endcase
        end
    end

    always @(cur_state) begin
        r_mode_select <= MODE_OFF;
        case (cur_state)
        MODE_OFF : r_mode_select <= MODE_OFF;
        MODE_1 : r_mode_select <= MODE_1;
        MODE_2 : r_mode_select <= MODE_2;
        MODE_3 : r_mode_select <= MODE_3;
        endcase
    end

endmodule
