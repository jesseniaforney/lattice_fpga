# Design Overview
Design an FPGA that links a physical push button (switch input) to corresponding LED output on the board using Verilog, SystemVerilog, and VHDL. Toggle the state of the LED each time the push button is released. If LED was off before the switch is released, it should turn on, and if the LED was on, it should turn off
- Utilize FFs to hold state of input and output
- Utilize falling edge of switch to toggle
- Make sure LED only changes when push button is released and holds state
- Will assign LEDs not being used to 0 since found they will be dimly lit if not assigned to anything. 

Utilizing pin constraints file from Project 1 + adding Clk Pin (runs at 25MHz or 40ns).
Adding clock constraints file.

See diagram.png for more details.

## Issues Debugged
- Did see warnings printed in place and route logs stating switch pins (2-4) were declared in pin constraints but not used in design. Decided to leave as is since it was not needed in the design.
- Found the LED does not always change state each time the push button is pressed due to physical workings of the switch itself. Will be adding logic to debounce the switch. 
- Found in waveforms differences between Verilog vs VHDL
    In Verilog: when i_switch_1 went high on posedge of clock, r_switch went high on same posedge of clock (incorrect)
    In VHDL: when i_switch_1 went high on posedge of clock, r_switch went high on the next posedge of clock (correct behavior of FF)