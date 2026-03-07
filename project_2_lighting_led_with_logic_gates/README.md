# Design Overview
Design an FPGA that links the physical push buttons (switch inputs) to corresponding LED output on the board using Verilog and VHDL. Combos wanting:
- When push buttons 1 & 2 are pressed, LED 1 turns on
- When either push buttons 3 & 4 or both pressed, LED 2 turns on
- When either push buttons 3 & 4, LED 3 turns on
- LED 4 is always on unless push button 4 pressed

Utilizes 4 LUTs in FPGA to create the following logic.

AND gate w/ 2 Inputs:
| SW1 | SW2 | LED1 |
|-----|-----|------|
| 0   | 0   | 0    |
| 0   | 1   | 0    |
| 1   | 0   | 0    |
| 1   | 1   | 1    |


OR gate w/ 2 Inputs:
| SW3 | SW4 | LED2 |
|-----|-----|------|
| 0   | 0   | 0    |
| 0   | 1   | 1    |
| 1   | 0   | 1    |
| 1   | 1   | 1    |

XOR gate w/ 2 Inputs:
| SW3 | SW4 | LED3 |
|-----|-----|------|
| 0   | 0   | 0    |
| 0   | 1   | 1    |
| 1   | 0   | 1    |
| 1   | 1   | 0    |

NOT gate w/ 1 Input: 
| SW4 | LED4 |
|-----|------|
| 0   | 1    |
| 1   | 0    |

Utilizing pin constraints file from Project 1.

## Issues Debugged
Found when LEDs were not set in logic it defaulted to being dimly lit. Can adjust code if needed to keep off at all times if not being used. In this case we are utilizing all LEDs so not an issue.