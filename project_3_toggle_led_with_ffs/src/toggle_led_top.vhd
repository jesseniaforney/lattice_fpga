-- Toggle state of LED output on falling edge of switch input and account for bounching of mechanical switch
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity toggle_led_top is
    generic (
        DEBOUNCE_MAX : integer := 250000
    );
    port (
        i_clk        : in std_logic;                                           -- Clock Input
        i_rst        : in std_logic;                                           -- Reset Input
        i_switch_1   : in std_logic;                                           -- Switch 1 Input
        o_led_1      : out std_logic;                                          -- LED 1 Output
        o_led_2      : out std_logic;                                          -- Unused LED Outputs
        o_led_3      : out std_logic;                                          -- Unused LED Outputs
        o_led_4      : out std_logic                                           -- Unused LED Outputs
    );
end entity toggle_led_top;

architecture rtl of toggle_led_top is
    signal w_switch_debounced : std_logic;
begin
    u_debounce : entity work.debounce_filter
    generic map(
        DEBOUNCE_MAX => 250000
    )
    port map(
        i_clk              => i_clk,
        i_rst              => i_rst,
        i_switch_1         => i_switch_1,
        o_switch_debounced => w_switch_debounced
    );

    u_toggle_led : entity work.toggle_led
    port map(
        i_clk      => i_clk,
        i_rst      => i_rst,
        i_switch_1 => w_switch_debounced,
        o_led_1    => o_led_1,
        o_led_2    => o_led_2,
        o_led_3    => o_led_3,
        o_led_4    => o_led_4
    );
end architecture rtl;
