# ⚡ 8-to-3 Priority Encoder with Valid Signal

![Hardware Language](https://img.shields.io/badge/Language-Verilog-blue.svg)
![Simulation](https://img.shields.io/badge/Simulation-Icarus_Verilog-green.svg)
![Waveform](https://img.shields.io/badge/Waveform-GtkWave-orange.svg)

## 📌 Project Overview
This repository contains the digital hardware design and testing suite for an **8-to-3 Priority Encoder**, developed for the *Computer Architecture and Organization* course. 

The primary goal of this project is to implement a robust combinational circuit that compresses 8 independent inputs into a 3-bit binary output, resolving input conflicts using strict priority logic.

## ⚙️ Core Hardware Logic
Unlike a standard encoder, this priority encoder elegantly handles multiple simultaneous active inputs:
* **Priority Handling:** The inputs are ranked from `D[7]` (Highest Priority) down to `D[0]` (Lowest Priority). If multiple signals arrive at the same time, the circuit exclusively encodes the bit with the highest index.
* **The Valid Signal (`V`):** A critical 1-bit output indicator. It outputs `1` if *any* input is active. It outputs `0` when all inputs are completely dormant. This prevents the system from confusing a legitimate `D[0]` input (which encodes to `000`) with a "no input" idle state.

## 📁 File Structure
* 📜 `design.v` — The core hardware implementation using Verilog combinational logic (`always @(*)` and bitwise reduction operators).
* 🧪 `testbench.v` — The QA verification environment. It simulates multiple edge cases: idle state, single bits, and simultaneous active signals to guarantee logical accuracy.

## 🚀 How to Run the Simulation

To compile the code and view the digital waveforms, you need **Icarus Verilog** and **GtkWave** installed on your system.

**1. Compile the source code:**
```bash
iverilog -o sim_executable design.v testbench.v
```

**2. Run the testbench (Generates waveform.vcd):**
```bash
vvp sim_executable
```

**3. View the generated waveform:**
```bash
gtkwave waveform.vcd
```   

## 🎯 Verification Strategy

The testbench (`testbench.v`) systematically verifies the design's functionality across critical scenarios:

| Test Case | Input (`D`) | Expected Output (`Y`, `V`) | Rationale |
| :--- | :--- | :--- | :--- |
| **Idle State** | `0000_0000` | `000`, `0` | Ensures the encoder correctly identifies the absence of any active input. |
| **Single Input** | `0000_0001` | `000`, `1` | Verifies the lowest priority input is detected and encoded. |
| **Mid-Range Input** | `0000_0100` | `010`, `1` | Checks an intermediate priority level. |
| **Max Priority** | `1000_0000` | `111`, `1` | Ensures the highest priority input is correctly encoded. |
| **Conflict Resolution** | `0000_0101` | `010`, `1` | Tests priority: `D[2]` (active) must override `D[0]` (active). |
| **Complex Conflict** | `0001_1010` | `100`, `1` | Tests priority: `D[4]` must override `D[3]` and `D[1]`. |
| **Full Saturation** | `1111_1111` | `111`, `1` | Ensures the highest priority input wins even when all are active. |
