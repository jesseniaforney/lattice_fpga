// Toggle state of LED output on falling edge of switch input and account for bounching of mechanical switch
module toggle_led_top
#(
    parameter DEBOUNCE_MAX = 250000
)
(
    input  i_clk,                                              // Clock Input
    input  i_rst,                                              // Reset Input
    input  i_switch_1,                                         // Switch 1 Input
    output o_led_1,                                            // LED 1 Output
    output o_led_2,                                            // Unused LED Outputs
    output o_led_3,                                            // Unused LED Outputs
    output o_led_4                                             // Unused LED Outputs
);

    wire w_switch_debounced;

    debounce_filter #(
        .DEBOUNCE_MAX(DEBOUNCE_MAX)
    ) u_debounce_filter
    (   .i_clk(i_clk)
    ,   .i_rst(i_rst)
    ,   .i_switch_1(i_switch_1)
    ,   .o_switch_debounced(w_switch_debounced)
    );

    toggle_led u_toggle_led
    (   .i_clk(i_clk)
    ,   .i_rst(i_rst)
    ,   .i_switch_1(w_switch_debounced)
    ,   .o_led_1(o_led_1)
    ,   .o_led_2(o_led_2)
    ,   .o_led_3(o_led_3)
    ,   .o_led_4(o_led_4)
    );

endmodule