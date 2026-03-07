// Design utilizes gate logic to control the LED outputs based on the switch inputs

module logic_gates 
(
  input  i_switch_1,                        // Switch 1 Input
  input  i_switch_2,                        // Switch 2 Input
  input  i_switch_3,                        // Switch 3 Input
  input  i_switch_4,                        // Switch 4 Input
  output o_led_1,                           // LED 1 Output
  output o_led_2,                           // LED 2 Output
  output o_led_3,                           // LED 3 Output
  output o_led_4                            // LED 4 Output
);

  assign o_led_1 = i_switch_1 & i_switch_2; // LED is ON only when both switches are ON
  assign o_led_2 = i_switch_3 | i_switch_4; // LED 2 is ON if either or both switches are ON
  assign o_led_3 = i_switch_3 ^ i_switch_4; // LED 3 is ON if either switch is ON, but not both
  assign o_led_4 = ~i_switch_4;             // LED 4 is always ON unless switch 4 is ON

endmodule
