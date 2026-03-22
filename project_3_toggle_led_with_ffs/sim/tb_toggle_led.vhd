-- Testbench that simulates toggle_led.vhd
library ieee;
use ieee.std_logic_1164.all;
use std.env.finish;

entity tb_toggle_led is
end entity tb_toggle_led;

architecture sim of tb_toggle_led is

    signal r_clk, r_in1                       : std_logic  := '0';  -- Test inputs for the clock and switch
    signal r_rst                              : std_logic  := '1';  -- Test input for reset
    signal w_out1, w_out2, w_out3, w_out4     : std_logic;          -- Signals to capture the LED outputs

begin

    -- Create clock
    r_clk <= not r_clk after 2ns;

    -- Instantiate the Unit Under Test (UUT)
    uut : entity work.toggle_led
    port map (
        i_clk      => r_clk,
        i_rst      => r_rst,
        i_switch_1 => r_in1,
        o_led_1    => w_out1,
        o_led_2    => w_out2,
        o_led_3    => w_out3,
        o_led_4    => w_out4
    );

    process is
    begin
        -- Set Up Reset
        wait until rising_edge(r_clk);
        wait until falling_edge(r_clk);
        r_rst <= '0';  -- Deassert reset after one clock cycle

        -- Test 1 - Input in between Clock Cycles
        wait for 5 ns;                    -- Turn on switch in between clock cycle
        r_in1 <= '1';
        wait for 6 ns;                    -- Turn off switch in between clock cycle
        r_in1 <= '0';

        -- Test 2 - Input from Rising Edge to Rising Edge
        wait for 7 ns;                    -- Turn on switch at rising edge of clock 
        r_in1 <= '1';
        wait for 4 ns;                    -- Turn off switch at rising edge of clock
        r_in1 <= '0';
        wait for 4 ns;
        
        -- Test 3 - Input from Falling Edge to Falling Edge
        wait for 2 ns;                    -- Turn on switch at falling edge of clock
        r_in1 <= '1';
        wait for 4 ns;                    -- Turn off switch at falling edge of clock
        r_in1 <= '0';
        wait for 10 ns;

        wait;  -- End the simulation 
    end process;

end architecture sim;
