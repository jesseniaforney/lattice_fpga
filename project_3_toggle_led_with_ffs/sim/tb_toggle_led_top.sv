// Code your testbench here
// or browse Examples
// Testbench for toggle_led.sv

module tb_toggle_led();

    reg  r_clk  = 1'b0;                   // Wire for the clock signal, initialize to 0
    reg  r_rst  = 1'b1;                   // Test input for reset, initialize to 1
    reg  r_in1  = 1'b0;                   // Test input for the switch, initialize to 0
    wire w_out1, w_out2, w_out3, w_out4;  // Wires to capture the LED outputs

    // Create 4ns/250MHz Clock (faster for simulation purposes)
    always #2 r_clk = !r_clk;             // Logical NOT, Toggle clock every 2 time units (4 time units period = 4ns)

    // Instantiate Unit Under Test (UUT)
    toggle_led_top #(.DEBOUNCE_MAX(5)
    )
    uut
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
        
        // Create bouncing switch input (simulate a noisy button press)
        repeat(3) @(posedge r_clk);    // Wait for a few clock cycles
        r_in1 = 1;                     // Simulate a button press
        assert(w_out1 == 1'b0) else $error("LED should be OFF");

        @(posedge r_clk);
        r_in1 = 0;                     // Simulate button release
        assert(w_out1 == 1'b0) else $error("LED should still be OFF");

        @(posedge r_clk);
        r_in1 = 1;                     // Simulate a bounce
        assert(w_out1 == 1'b0) else $error("LED should still be OFF");

        repeat(7) @(posedge r_clk);    // Wait for debounce counter to complete
        r_in1 = 0;
      
      	repeat(10) @(posedge r_clk);
        assert(w_out1 == 1'b1) else $error("LED should be ON");
        
      	$finish();  // End the simulation
    end

endmodule