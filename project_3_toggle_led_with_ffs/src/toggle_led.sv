// Design utilizes FFs to toggle state of LED output on falling edge of switch input

module toggle_led
(
    input  i_clk,                                              // Clock Input
    input  i_rst,                                              // Reset Input
    input  i_switch_1,                                         // Switch 1 Input
    output o_led_1,                                            // LED Output
    output o_led_2,                                            // Unused LED Outputs
    output o_led_3,                                            // Unused LED Outputs
    output o_led_4                                             // Unused LED Outputs
);

logic r_switch_state;                                          // Internal signal to register the state of the Switch. In Verilog would use reg instead of logic
logic r_led_state;                                             // Internal signal to register the state of the LED output. In Verilog would use reg instead of logic

always_ff @(posedge i_clk) begin                               // In Verilog would be: always @(posedge i_clk)
    if (i_rst) begin
        r_led_state <= 1'b0;                                   // Initialize to 0
        r_switch_state <= 1'b0;                                // Initialize to 0
    end else begin
        r_switch_state <= i_switch_1;                          // Register state of input switch, Utilize FF

        if ((i_switch_1 == 0) && (r_switch_state == 1)) begin  // Check for falling edge of switch input. Utilizing logical operators to utilize as a true/false scenario, Utilize LUT (AND gate) 
            r_led_state <= ~r_led_state;                       // Toggle state of LED output, Utilize FF and LUT (NOT gate)
        end
    end
end

assign o_led_1 = r_led_state;                                  // Assign state of LED output to the registered LED state
assign o_led_2 = 1'b0;                                         // Unused LED outputs set to 0
assign o_led_3 = 1'b0;                                         // Unused LED outputs set to 0
assign o_led_4 = 1'b0;                                    // Unused LED outputs set to 0

endmodule