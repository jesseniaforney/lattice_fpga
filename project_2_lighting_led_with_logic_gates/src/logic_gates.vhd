-- Design utilizes gate logic to control the LED outputs based on the switch inputs

library ieee;
use ieee.std_logic_1164.all;

entity logic_gates is
  port (
    i_switch_1 : in std_logic;           -- Switch 1 input
    i_switch_2 : in std_logic;           -- Switch 2 input
    i_switch_3 : in std_logic;           -- Switch 3 input
    i_switch_4 : in std_logic;           -- Switch 4 input
    o_led_1    : out std_logic;          -- LED 1 output
    o_led_2    : out std_logic;          -- LED 2 output
    o_led_3    : out std_logic;          -- LED 3 output
    o_led_4    : out std_logic           -- LED 4 output
  );
end entity logic_gates;

architecture rtl of logic_gates is
begin
  o_led_1 <= i_switch_1 and i_switch_2;  -- LED 1 is ON only when both switches are ON
  o_led_2 <= i_switch_3 or i_switch_4;   -- LED 2 is ON if either or both switches are ON
  o_led_3 <= i_switch_3 xor i_switch_4;  -- LED 3 is ON if either switch is ON, but not both
  o_led_4 <= not i_switch_4;             -- LED 4 is always ON unless switch 4 is ON
end architecture rtl;
