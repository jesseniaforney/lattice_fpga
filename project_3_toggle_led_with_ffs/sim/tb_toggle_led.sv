// Testbench for toggle_led.sv

module tb_toggle_led();

    logic  r_clk  = 1'b0;                   // Wire for the clock signal, initialize to 0
    logic  r_rst  = 1'b1;                   // Test input for reset, initialize to 1
    logic  r_in1  = 1'b0;                   // Test input for the switch, initialize to 0
    logic  w_out1, w_out2, w_out3, w_out4;  // Wires to capture the LED outputs

    // Create 4ns/250MHz Clock (faster for simulation purposes)
    always #2 r_clk = !r_clk;             // Logical NOT, Toggle clock every 2 time units (4 time units period = 4ns)

    // Instantiate Unit Under Test (UUT)
    toggle_led uut
    ( .i_clk     (r_clk )                 // Clock Input
    , .i_rst     (r_rst )                 // Reset Input
    , .i_switch_1(r_in1 )                 // Switch 1 Input
    , .o_led_1   (w_out1)                 // LED Output
    , .o_led_2   (w_out2)                 // Unused LED Outputs
    , .o_led_3   (w_out3)                 // Unused LED Outputs
    , .o_led_4   (w_out4)                 // Unused LED Outputs
    );

    initial begin
        $dumpfile("waveforms_logic_gates.vcd");
        $dumpvars;

        // Set up Reset
        @(posedge r_clk);
        @(negedge r_clk);
        r_rst = 0;                     // Deassert reset
        
        // Test 1 - Input in between Clock Cycles
        #5;                            // Turn on switch in between clock cycle
        r_in1 = 1;
        #6;                            // Turn off switch in between clock cycle
        r_in1 = 0;

        // Test 2 - Input from Rising Edge to Rising Edge
        #7;                            // Turn on switch at rising edge of clock 
        r_in1 = 1;
        #4;                            // Turn off switch at rising edge of clock                
        r_in1 = 0;
        #4;

        // Test 3 - Input from Falling Edge to Falling Edge
        #2;                            // Turn on switch at falling edge of clock
        r_in1 = 1;
        #4;                            // Turn off switch at falling edge of clock
        r_in1 = 0;
        #10;

        $finish();  // End the simulation
    end

endmodule