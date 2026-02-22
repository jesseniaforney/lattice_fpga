## Design Overview
Design an FPGA that links the 4 physical push buttons (switch inputs) to the corresponding LED outputs on the board using Verilog and VHDL

# Issues Debugged
Did not add pin constraints file when programming and found board did not perform as expected
Looked in .rpt and found pin assignments were incorrect (without constraints pins were randomly assigned)
Added pin constraints with correct pins and worked as will see in video
