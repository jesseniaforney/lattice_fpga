-- Code your testbench here
-- Testbench that simulates toggle_led.vhd
library ieee;
use ieee.std_logic_1164.all;
use std.env.finish;

entity tb_toggle_led_top is
end entity tb_toggle_led_top;

architecture sim of tb_toggle_led_top is

    signal r_clk, r_in1                       : std_logic  := '0';  -- Test inputs for the clock and switch
    signal r_rst                              : std_logic  := '1';  -- Test input for reset
    signal w_out1, w_out2, w_out3, w_out4     : std_logic;          -- Signals to capture the LED outputs

begin

    -- Create clock
    r_clk <= not r_clk after 2ns;

    -- Instantiate the Unit Under Test (UUT)
    uut : entity work.toggle_led_top
    generic map (
    	DEBOUNCE_MAX => 5
    )
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
        r_rst <= '0';                     -- Deassert reset after one clock cycle

        -- Create bouncing switch input (simulate a noisy button press)
        wait for 6 ns;
        r_in1 <= '1';       -- Simulate a button press
        assert (w_out1 = '0') severity failure;

        wait for 2 ns;
        r_in1 <= '0';       -- Simulate button release
        assert (w_out1 = '0') severity failure;

        wait for 2 ns;
        r_in1 <= '1';       -- Simulate a bounce
        assert (w_out1 = '0') severity failure;

        wait for 24 ns;     -- Wait for debounce counter to complete
		r_in1 <= '0';
        
        wait for 40 ns;
        assert (w_out1 = '1') severity failure;
        
        std.env.stop;               -- End the simulation 
    end process;

end architecture sim;
