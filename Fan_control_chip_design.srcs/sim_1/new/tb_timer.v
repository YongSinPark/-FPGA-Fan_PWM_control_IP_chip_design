`timescale 1ns / 1ps

module tb_timer();
    reg i_clk = 1'b0; 
    reg i_reset;
    reg i_enable;
    reg [4:0] i_button;
    wire o_mode;
    wire [2:0] o_mode_led;
    wire [3:0] o_FND_select;
    wire [7:0] o_FND_font;
    wire w_clk_1M, w_clk_1k;
    wire [9:0] w_counter;
    wire w_mode1, w_mode2, w_mode3;
    wire [1:0] w_mode_select;
    wire [3:0] w_button_state;
    wire w_button_timer;
    wire [1:0] w_fnd_counter;
    wire [4:0] w_timer_counter;

    Prescaler_for_1MHz Prescaler_for_1MHz(
    .i_clk(i_clk), 
    .i_reset(i_reset),
    .o_clk(w_clk_1M)
    );

    Prescaler_for_1kHz Prescaler_for_1kHz(
    .i_clk(i_clk), 
    .i_reset(i_reset),
    .o_clk(w_clk_1k)
    );

    Counter_PWM Counter_PWM(
    .i_clk(w_clk_1M), 
    .i_reset(i_reset),
    .o_counter(w_counter)
    );

    Comparator_motor Comparator_motor(
    .i_counter(w_counter),
    .o_mode1(w_mode1), 
    .o_mode2(w_mode2), 
    .o_mode3(w_mode3)
    );

    MUX_motor MUX_motor(
    .i_mode1(w_mode1), 
    .i_mode2(w_mode2), 
    .i_mode3(w_mode3),
    .i_mode_select(w_mode_select),
    .o_mode(o_mode)
    );

    Button Button0(
    .i_clk(i_clk), 
    .i_reset(i_reset), 
    .i_button(i_button[0]),
    .o_buttonState(w_button_state[0])
    );

    Button Button1(
    .i_clk(i_clk), 
    .i_reset(i_reset), 
    .i_button(i_button[1]),
    .o_buttonState(w_button_state[1])
    );

    Button Button2(
    .i_clk(i_clk), 
    .i_reset(i_reset), 
    .i_button(i_button[2]),
    .o_buttonState(w_button_state[2])
    );

    Button Button3(
    .i_clk(i_clk), 
    .i_reset(i_reset), 
    .i_button(i_button[3]),
    .o_buttonState(w_button_state[3])
    );

    Button Button4(
    .i_clk(i_clk), 
    .i_reset(i_reset), 
    .i_button(i_button[4]),
    .o_buttonState(w_button_timer)
    );

    FSM_motor_state FSM_motor_state(
    .i_clk(i_clk), 
    .i_reset(i_reset),
    .i_button(w_button_state),
    .i_motor_end_sign(w_motor_end_sign),
    .o_mode_select(w_mode_select)
    );

    Counter_FND Counter_FND(
    .i_clk(w_clk_1k), 
    .i_reset(i_reset),
    .o_counter(w_fnd_counter)
    );

    Decoder_2_4 Decoder_2_4(
    .i_select(w_fnd_counter),
    .i_enable(i_enable),
    .o_FND_select(o_FND_select)
    );

    Decoder_BCD Decoder_BCD(
    .i_mode(w_timer_value),
    .i_enable(i_enable),
    .o_FND_font(o_FND_font)
    );

    Decoder_led Decoder_led(
    .i_mode_select(w_mode_select),
    .o_mode(o_mode_led)
    );
    wire w_motor_end_sign;

    Counter_Timer Counter_Timer(
    .i_clk(w_clk_1k), 
    .i_reset(i_reset),
    .i_time(w_time),
    .i_mode(w_mode),
    .o_timer_counter(w_timer_counter),
    .o_motor_end_sign(w_motor_end_sign)
    );

    wire [1:0] w_1000;
    wire [3:0] w_10, w_1;

    Digit_divider Digit_divider(
    .i_counter(w_timer_counter), 
    .i_mode_select(w_mode_select),
    .o_1000(w_1000),
    .o_10(w_10), 
    .o_1(w_1)
    );
    wire [3:0] w_timer_value;

    MUX_Timer MUX_Timer(
    .i_mode(w_1000), 
    .i_10(w_10), 
    .i_1(w_1),
    .i_mode_select(w_fnd_counter),
    .o_timer_mode(w_timer_value)
    );

    wire [1:0] w_mode;
    wire [4:0] w_time;

    FSM_Timer FSM_Timer(
    .i_clk(i_clk), 
    .i_reset(i_reset), 
    .i_timer_button(w_button_timer),
    .i_motor_end_sign(w_motor_end_sign),
    .o_mode(w_mode),
    .o_time(w_time)
    );


    always #5 i_clk = ~i_clk;

    initial begin
        #00 i_reset = 1'b0; i_enable = 1'b0; i_button[0] =  1'b0; i_button[1] =  1'b0; i_button[2] =  1'b0; i_button[3] =  1'b0; i_button[4] =  1'b0;
        for (integer i = 0; i < 100000; i = i + 1) begin
            #100000 i_reset = 1'b0; i_enable = 1'b0; i_button[0] =  1'b0; i_button[1] =  1'b1; i_button[2] =  1'b0; i_button[3] =  1'b0; i_button[4] =  1'b1;
            #100000 i_reset = 1'b0; i_enable = 1'b0; i_button[0] =  1'b0; i_button[1] =  1'b0; i_button[2] =  1'b0; i_button[3] =  1'b0; i_button[4] =  1'b0;
        end
        #100 $finish;

    end
endmodule
