`timescale 1ns / 1ps

module Counter_Timer(
    input i_clk, i_reset,
    input [4:0] i_time,
    input [1:0] i_mode,
    output [4:0] o_timer_counter,
    output o_motor_end_sign
    );
    
    reg [31:0] r_counter = 0;
    
    reg [4:0] r_timer_counter = 0, r_10_timer_counter = 0, r_20_timer_counter = 0, r_30_timer_counter = 0;
    reg r_motor_end_sign = 0;

    assign o_motor_end_sign = r_motor_end_sign;
    assign o_timer_counter = r_timer_counter;

    always @(posedge i_clk, posedge i_reset) begin
        if(i_reset) begin
            r_counter <= 0;
            r_timer_counter <= 0;
        end
        else begin
            if(r_counter == 999) begin
                r_counter <= 0;
                case(i_time)
                10 : begin : block10
                    r_10_timer_counter <= 0;
                    if(r_10_timer_counter == 11) begin
                        if(r_motor_end_sign == 0) r_motor_end_sign <= 1'b1;
                        disable block10;
                    end
                    else begin
                        r_10_timer_counter <= r_10_timer_counter + 1;
                        r_timer_counter <= i_time - r_10_timer_counter; 
                    end
                end
                20 : begin : block20
                    r_20_timer_counter <= 0;
                    if(r_20_timer_counter == 21) begin
                        if(r_motor_end_sign == 0) r_motor_end_sign <= 1'b1;
                        disable block20;
                    end
                    else begin
                        r_20_timer_counter <= r_20_timer_counter + 1;
                        r_timer_counter <= i_time - r_20_timer_counter; 
                    end
                end 
                30 : begin : block30
                   r_30_timer_counter <= 0;
                   if(r_30_timer_counter == 31) begin
                        if(r_motor_end_sign == 0) r_motor_end_sign <= 1'b1;
                        disable block30;
                    end
                    else begin
                        r_30_timer_counter <= r_30_timer_counter + 1;
                        r_timer_counter <= i_time - (r_30_timer_counter); 
                    end
                end 
                default : begin
                     r_timer_counter <= 0;
                     r_motor_end_sign <= 0;
                     r_30_timer_counter <= 0;
                     r_10_timer_counter <= 0;
                     r_20_timer_counter <= 0;
                end
                endcase
                end
            else begin
                r_counter <= r_counter + 1;
            end
        end
    end
endmodule
