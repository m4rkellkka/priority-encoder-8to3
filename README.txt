How to Run the Simulation:

To compile the code and view the digital waveforms, you need Icarus Verilog and GtkWave installed on your system.

In Visual Studio Code, open the folder containing the code by going to File -> Open folder.

After saving the code, open a new terminal in the project and follow the next steps.

1. Compile the source code:

iverilog -o sim_executable design.v testbench.v

2. Run the testbench (Generates waveform.vcd):

vvp sim_executable

3. View the generated waveform:

gtkwave waveform.vcd