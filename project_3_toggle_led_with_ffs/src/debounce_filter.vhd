-- Filter to Account for Bouncing State of Switch Input

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity debounce_filter is
    generic (
        DEBOUNCE_MAX          : integer := 250000                            -- 10ms of time to account for any debouncing occuring from switch input. 10ms/40ns (clock period) = 250,000 clock cycles
    );
    port (
        i_clk                 : in  std_logic;                               -- Clock input
        i_rst                 : in  std_logic;                               -- Reset input
        i_switch_1            : in  std_logic;                               -- Switch Input
        o_switch_debounced    : out std_logic                                -- Debounced Switch Output
    );
end entity debounce_filter;

architecture rtl of debounce_filter is

    signal r_debounce_cnt : integer range 0 to DEBOUNCE_MAX;                 -- Internal signal to account for bouncing state of switch input
    signal r_switch_state : std_logic;                                       -- Internal signal to register the state of the switch input

begin

    process (i_clk) is
    begin
        if rising_edge(i_clk) then
            if i_rst = '1' then
                r_debounce_cnt <= '0';                                                                  -- Initialize to 0
                r_switch_state <= '0';                                                                  -- Initialize to 0
            else then
                if ((i_switch_1 /= r_switch_state) and (r_debounce_cnt < (DEBOUNCE_MAX-1))) then          -- If switch input differs from switch state, start incrementing counter until stable enough time
                    r_debounce_cnt <= r_debounce_cnt + 1;  
                elsif (r_debounce_cnt = (DEBOUNCE_MAX-1)) then                                          -- If counter reaches max time, then register switch state
                    r_switch_state <= i_switch_1;
                    r_debounce_cnt <= '0';
                else then                                                                               -- If switch input is the same as switch state, reset counter to 0
                    r_debounce_cnt <= '0';
                end if;
            end if;
        end if;
    end process;

    o_switch_debounced <= r_switch_state;                                    -- Assign debounced switch output to the registered switch state

end architecture rtl;