`timescale 1ns/1ps

module mini_cpu_tb;

    reg clk;
    reg reset;

    wire halted;

    // Instantiate CPU
    mini_cpu cpu (
        .clk(clk),
        .reset(reset),
        .halted(halted)
    );

    // Clock generation
    always #5 clk = ~clk;

    initial begin

        // Initialize clock
        clk = 0;

        // Reset CPU
        reset = 1;

        #10;

        reset = 0;

        // Program:
        // LDI 5
        // ADDI 3
        // STORE F0
        // HALT

        cpu.memory[0] = 8'h10;
        cpu.memory[1] = 8'h05;

        cpu.memory[2] = 8'h20;
        cpu.memory[3] = 8'h03;

        cpu.memory[4] = 8'h70;
        cpu.memory[5] = 8'hF0;

        cpu.memory[6] = 8'hFF;

        // Wait until CPU halts
        wait(halted);

        #10;

        $display("--------------------------------");
        $display("       MINI CPU SIMULATION");
        $display("--------------------------------");

        $display("Accumulator = %h", cpu.accumulator);
        $display("Memory F0   = %h", cpu.memory[8'hF0]);
        $display("CPU Halted  = %b", halted);

        if (cpu.memory[8'hF0] == 8'h08) begin
            $display("TEST PASSED!");
        end
        else begin
            $display("TEST FAILED!");
        end

        $display("--------------------------------");

        $finish;
    end

    // Generate waveform
    initial begin
        $dumpfile("mini_cpu.vcd");
        $dumpvars(0, mini_cpu_tb);
    end

endmodule