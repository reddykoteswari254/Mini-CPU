# 8-bit Mini CPU

## Overview

This project implements a simple 8-bit Central Processing Unit (CPU) using Verilog HDL.

The purpose of this project is to understand the basic operation of a processor, including:

- Program Counter
- Accumulator
- Instruction Fetch
- Instruction Decode
- Instruction Execute
- Arithmetic and Logic Operations
- Memory Read and Write
- Jump Instructions
- CPU Halt
- Simulation and Testing

## Architecture

The CPU contains:

- 8-bit accumulator
- 8-bit program counter
- 8-bit instruction register
- 256 bytes of memory
- Control unit
- ALU
- Instruction decoder

## Instruction Set

| Opcode | Instruction | Description |
|--------|-------------|-------------|
| 00 | NOP | No operation |
| 10 | LDI | Load immediate value |
| 20 | ADDI | Add immediate value |
| 30 | SUBI | Subtract immediate value |
| 40 | ANDI | AND immediate value |
| 50 | ORI | OR immediate value |
| 60 | LOAD | Load value from memory |
| 70 | STORE | Store accumulator to memory |
| 80 | JMP | Jump to address |
| FF | HALT | Stop CPU |

## Example Program

The testbench loads the following program:

    LDI 5
    ADDI 3
    STORE F0
    HALT

The CPU performs:

    5 + 3 = 8

The result is stored at memory address `F0`.

## Simulation

Icarus Verilog can be used to compile and simulate the project.

Compile:

    iverilog -o mini_cpu_sim rtl/mini_cpu.v rtl/alu.v tb/mini_cpu_tb.v

Run:

    vvp mini_cpu_sim

Expected output:

    Accumulator = 08
    Memory F0   = 08
    CPU Halted  = 1
    TEST PASSED!

A VCD waveform file named `mini_cpu.vcd` is generated.

The waveform can be viewed using GTKWave:

    gtkwave mini_cpu.vcd

## Project Files

    mini-cpu/
    ├── README.md
    ├── rtl/
    │   ├── mini_cpu.v
    │   └── alu.v
    ├── tb/
    │   └── mini_cpu_tb.v
    ├── program/
    │   └── program.mem
    └── simulation/
        └── run_sim.sh

## Technologies

- Verilog HDL
- Icarus Verilog
- GTKWave
- GitHub

## Learning Objectives

This project demonstrates how a basic CPU executes instructions through the fetch, decode, and execute cycle.

It also demonstrates RTL design, digital logic, memory operations, testbench development, and waveform-based simulation.

## Future Improvements

Possible improvements include:

- More registers
- Stack support
- CALL and RETURN instructions
- Conditional branches
- More ALU operations
- Larger memory
- UART interface
- Seven-segment display output
- FPGA implementation