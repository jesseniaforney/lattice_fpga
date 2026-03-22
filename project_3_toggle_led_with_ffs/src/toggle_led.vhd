-- Design utilizes FFs to toggle state of LED output on falling edge of switch input

library ieee;
use ieee.std_logic_1164.all;

entity toggle_led is
    port (
        i_clk      : in std_logic;                                           -- Clock input
        i_rst      : in std_logic;                                           -- Reset input
        i_switch_1 : in std_logic;                                           -- Switch 1 Input
        o_led_1    : out std_logic;                                          -- LED Output
        o_led_2    : out std_logic;                                          -- Unused LED outputs
        o_led_3    : out std_logic;                                          -- Unused LED outputs
        o_led_4    : out std_logic                                           -- Unused LED outputs
    );
end entity toggle_led;

architecture rtl of toggle_led is

    signal r_switch_state : std_logic;                                       -- Internal signal to register the state of the Switch
    signal r_led_state    : std_logic;                                       -- Internal signal to register the state of the LED output

begin

    process (i_clk) is
    begin
        if rising_edge(i_clk) then
            if i_rst = '1' then
                r_led_state    <= '0';                                       -- Initialize to 0
                r_switch_state <= '0';                                       -- Initialize to 0
            end if;

            r_switch_state <= i_switch_1;                                    -- Register state of input switch, Utilize FF

            if ((i_switch_1 = '0') and (r_switch_state = '1')) then          -- Check for falling edge of switch input. Utilizing logical operators to utilize as a true/false scenario, Utilize LUT (AND gate)
                r_led_state <= not r_led_state;                              -- Toggle state of LED output, Utilize FF and LUT (NOT gate)
            end if;
        end if;
    end process;

    o_led_1 <= r_led_state;                                                  -- Assign state of LED output to the registered LED state
    o_led_2 <= '0';                                                          -- Unused LED outputs set to 0
    o_led_3 <= '0';                                                          -- Unused LED outputs set to 0
    o_led_4 <= '0';                                                          -- Unused LED outputs set to 0

end architecture rtl;
