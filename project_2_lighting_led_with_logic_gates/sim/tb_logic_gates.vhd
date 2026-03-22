-- Testbench that simulates the logic gates module

library ieee;
use ieee.std_logic_1164.all;
use std.env.finish;

entity tb_logic_gates is
end entity tb_logic_gates;

architecture sim of tb_logic_gates is

    signal r_in1, r_in2, r_in3, r_in4     : std_logic;  -- Test inputs for the switches
    signal w_out1, w_out2, w_out3, w_out4 : std_logic;  -- Signals to capture the LED outputs

begin

    -- Instantiation of Unit Under Test (UUT)
    uut : entity work.logic_gates
    port map (
        i_switch_1 => r_in1,
        i_switch_2 => r_in2,
        i_switch_3 => r_in3,
        i_switch_4 => r_in4,
        o_led_1    => w_out1,
        o_led_2    => w_out2,
        o_led_3    => w_out3,
        o_led_4    => w_out4
    );

    process is
    begin
    
        -- Test case 1: All switches OFF
        r_in1 <= '0'; 
        r_in2 <= '0'; 
        r_in3 <= '0'; 
        r_in4 <= '0';
        wait for 10 ns;

        -- Test case 2: Switch 2 and Switch 4 ON
        r_in1 <= '0'; 
        r_in2 <= '1'; 
        r_in3 <= '0'; 
        r_in4 <= '1';
        wait for 10 ns;
        
        -- Test case 3: Switch 1 and Switch 3 ON
        r_in1 <= '1'; 
        r_in2 <= '0'; 
        r_in3 <= '1'; 
        r_in4 <= '0';
        wait for 10 ns;

        -- Test case 4: All switches ON
        r_in1 <= '1'; 
        r_in2 <= '1'; 
        r_in3 <= '1'; 
        r_in4 <= '1';
        wait for 10 ns;

        -- End of simulation
        wait;

    end process;

end architecture sim;