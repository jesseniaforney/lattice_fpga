module tb_logic_gates ();

    logic r_in1, r_in2, r_in3, r_in4;      // Test inputs for the switches
    logic w_out1, w_out2, w_out3, w_out4;  // Wires to capture the LED outputs

    // Instantiation of Unit Under Test (UUT)
    logic_gates uut
    ( .i_switch_1(r_in1 )
    , .i_switch_2(r_in2 )
    , .i_switch_3(r_in3 )
    , .i_switch_4(r_in4 )
    , .o_led_1   (w_out1)
    , .o_led_2   (w_out2)
    , .o_led_3   (w_out3)
    , .o_led_4   (w_out4)
    );

    // Create Tests for all combinations of switch inputs
    initial begin
        $dumpfile("waveforms_logic_gates.vcd"); // Dump waveforms for visualization (using EDA Playground for Sim Environment)
        $dumpvars;
        
        // Test Case 1: ALL Switches OFF
        r_in1 = 0;
        r_in2 = 0;
        r_in3 = 0;
        r_in4 = 0;
        #10;        // Wait for 10 time units
        // Test Case 2: Switch 1 and Switch 4 ON
        r_in1 = 0;
        r_in2 = 1;
        r_in3 = 0;
        r_in4 = 1;
        #10;        // Wait for 10 time units
        // Test Case 3: Switch 1 and Switch 3 ON
        r_in1 = 1;
        r_in2 = 0;
        r_in3 = 1;
        r_in4 = 0;
        #10;        // Wait for 10 time units
        // Test Case 4: ALL Switches ON
        r_in1 = 1;
        r_in2 = 1;
        r_in3 = 1;
        r_in4 = 1;
        #10;        // Wait for 10 time units

        $finish();  // End the simulation
    end

endmodule
   