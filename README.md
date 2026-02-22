## lattice_fpga
Developing with Lattice Semi's iCE40HX1K

# Design Overview
Design an FPGA that links the 4 physical push buttons (switch inputs) to the corresponding LED outputs on the board using Verilog and VHDL

# Programming
Programming a board developed by nandland.com with a Lattice Semi's iCE40HX1K
Utilizing iCEcube2 to perform synthesis, place and route, and generate bitstream
Utilizing USB connected to computer and Diamond Programmer to program board

# Issues Debugged
Did not add pin constraints file when programming and found board did not perform as expected
Looked in .rpt and found pin assignments were incorrect (without constraints pins were randomly assigned)
Added pin constraints with correct pins and worked as will see in video
