`timescale 1ns / 1ps

module Button(
    input i_clk, i_reset, i_button,
    output o_buttonState
    );

    parameter PUSHED = 1'b1, RELEASED = 1'b0, TRUE = 1'b1, FALSE = 1'b0;
    parameter DEBOUNCE = 500_000; // 10ms

    reg r_prevState = RELEASED;
    reg r_buttonState;
    reg [31:0] r_counter = 0;

    assign o_buttonState = r_buttonState;

    always @(posedge i_clk, posedge i_reset) begin
        if(i_reset) begin
            r_buttonState <= FALSE;
            r_prevState <= RELEASED;
            r_counter <= 0;
        end
        else begin
            if(i_button == PUSHED && r_prevState == RELEASED && (r_counter < DEBOUNCE)) begin
                r_counter <= r_counter + 1;
                r_buttonState <= FALSE;
            end
            else if (i_button == PUSHED && r_prevState == RELEASED && (r_counter == DEBOUNCE)) begin
                r_counter <= 0;
                r_prevState <= PUSHED;
                r_buttonState <= FALSE;
            end
            else if (i_button == RELEASED && r_prevState == PUSHED && (r_counter < DEBOUNCE)) begin
                r_counter <= r_counter + 1;
                r_buttonState <= FALSE;
            end
            else if (i_button == RELEASED && r_prevState == PUSHED && (r_counter == DEBOUNCE)) begin
                r_counter <= 0;
                r_prevState <= RELEASED;
                r_buttonState <= TRUE;
            end
            else begin
                r_buttonState <= FALSE;
            end
        end
    end

endmodule