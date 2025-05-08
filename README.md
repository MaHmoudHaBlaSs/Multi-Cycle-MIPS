# Multi-Cycle MIPS Processor

This repository contains the **implementation of a Multi-Cycle MIPS processor** designed using **VHDL**. The project focuses on simulating and understanding the architecture of a Multi-Cycle MIPS CPU, demonstrating the principles of instruction execution in multiple cycles for enhanced performance and efficiency.

## Features

- **Multi-Cycle MIPS Architecture**: Implements the MIPS processor architecture with a multi-cycle approach to instruction execution.
- **VHDL Implementation**: The entire design is developed in VHDL, a hardware description language.
- **Simulation and Testing**: Designed for simulating MIPS instructions to validate functionality and performance.
- **Educational Purpose**: Ideal for students, educators, and enthusiasts in computer architecture and digital design.

## How It Works

The Multi-Cycle MIPS processor divides the execution of each instruction into multiple cycles, allowing efficient use of datapath and control logic. This design reduces the number of hardware components required compared to a single-cycle processor while maintaining performance.

The main phases of instruction execution are as follows:

1. **Instruction Fetch (IF)**: The instruction is fetched from memory.
2. **Instruction Decode (ID)**: The instruction is decoded, and operands are fetched.
3. **Execution (EX)**: The operation is performed (e.g., addition, branching).
4. **Memory Access (MEM)**: Data memory is accessed for load/store instructions.
5. **Write Back (WB)**: Results are written back to the register file.

### [For More Details Visit This Notion Page.](https://walnut-crocus-562.notion.site/MIPS-1ec6ce80c31680a29be3fe7ab0c48c41?pvs=4)

## Acknowledgments

- The MIPS architecture is a widely studied architecture in computer engineering and digital design.
- Thanks to the open-source community for their tools and support.
