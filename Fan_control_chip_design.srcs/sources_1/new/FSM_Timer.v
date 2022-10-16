`timescale 1ns / 1ps

module FSM_Timer(
    input i_clk, i_reset, i_timer_button,
    input i_motor_end_sign,
    output [1:0] o_mode,
    output [4:0] o_time
    );

    parameter TIMER_OFF = 2'h0, TIMER_10s = 2'h1, TIMER_20s = 2'h2, TIMER_30s = 2'h3;

    reg [1:0] cur_state = 0, next_state = 0;
    reg [4:0] r_time = 0;
    reg [1:0] r_mode;
    
    assign o_mode = r_mode;
    assign o_time = r_time;

    always @(posedge i_clk, posedge i_reset) begin
        if(i_reset) cur_state <= TIMER_OFF;
        else cur_state <= next_state;
    end

    always @(cur_state) begin
        if(i_motor_end_sign) next_state <= TIMER_OFF;
        else begin
            next_state <= TIMER_OFF;
            case(cur_state)
            TIMER_OFF : begin
                if(i_timer_button == 1'b1) begin
                    next_state <= TIMER_10s;
                end
                else next_state <= TIMER_OFF;
            end
            TIMER_10s : begin
                if(i_timer_button == 1'b1) begin
                    next_state <= TIMER_20s;
                end
                else next_state <= TIMER_10s;
            end
            TIMER_20s : begin
                if(i_timer_button == 1'b1) begin
                    next_state <= TIMER_30s;
                end
                else next_state <= TIMER_20s;
            end
            TIMER_30s : begin
                if(i_timer_button == 1'b1) begin
                    next_state <= TIMER_OFF;
                end
                else next_state <= TIMER_30s;
            end
            endcase
        end
    end

    always @(cur_state) begin
        r_mode <= TIMER_OFF;
        case(cur_state)
        TIMER_OFF : begin
            r_mode <= TIMER_OFF;
            r_time <= 0;
        end
        TIMER_10s : begin
            r_mode <= TIMER_10s;
            r_time <= 10;
        end
        TIMER_20s : begin
            r_mode <= TIMER_20s;
            r_time <= 20;
        end
        TIMER_30s : begin
            r_mode <= TIMER_30s;
            r_time <= 30;
        end
        endcase
    end
endmodule