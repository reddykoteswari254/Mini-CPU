module mini_cpu (
    input clk,
    input reset,
    output reg halted
);

    // Registers
    reg [7:0] accumulator;
    reg [7:0] pc;
    reg [7:0] instruction;

    // Memory
    reg [7:0] memory [0:255];

    // Instruction opcodes
    localparam NOP   = 8'h00;
    localparam LDI   = 8'h10; // Load immediate
    localparam ADDI  = 8'h20; // Add immediate
    localparam SUBI  = 8'h30; // Subtract immediate
    localparam ANDI  = 8'h40; // AND immediate
    localparam ORI   = 8'h50; // OR immediate
    localparam LOAD  = 8'h60; // Load from memory
    localparam STORE = 8'h70; // Store to memory
    localparam JMP   = 8'h80; // Jump
    localparam HALT  = 8'hFF;

    // CPU state
    localparam FETCH  = 2'b00;
    localparam DECODE = 2'b01;
    localparam EXECUTE = 2'b10;

    reg [1:0] state;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            accumulator <= 8'h00;
            pc <= 8'h00;
            instruction <= 8'h00;
            halted <= 1'b0;
            state <= FETCH;
        end
        else begin
            if (!halted) begin

                case (state)

                    // -------------------------
                    // FETCH
                    // -------------------------
                    FETCH: begin
                        instruction <= memory[pc];
                        pc <= pc + 1;
                        state <= DECODE;
                    end

                    // -------------------------
                    // DECODE
                    // -------------------------
                    DECODE: begin
                        state <= EXECUTE;
                    end

                    // -------------------------
                    // EXECUTE
                    // -------------------------
                    EXECUTE: begin

                        case (instruction)

                            NOP: begin
                                // Do nothing
                            end

                            LDI: begin
                                accumulator <= memory[pc];
                                pc <= pc + 1;
                            end

                            ADDI: begin
                                accumulator <= accumulator + memory[pc];
                                pc <= pc + 1;
                            end

                            SUBI: begin
                                accumulator <= accumulator - memory[pc];
                                pc <= pc + 1;
                            end

                            ANDI: begin
                                accumulator <= accumulator & memory[pc];
                                pc <= pc + 1;
                            end

                            ORI: begin
                                accumulator <= accumulator | memory[pc];
                                pc <= pc + 1;
                            end

                            LOAD: begin
                                accumulator <= memory[memory[pc]];
                                pc <= pc + 1;
                            end

                            STORE: begin
                                memory[memory[pc]] <= accumulator;
                                pc <= pc + 1;
                            end

                            JMP: begin
                                pc <= memory[pc];
                            end

                            HALT: begin
                                halted <= 1'b1;
                            end

                            default: begin
                                halted <= 1'b1;
                            end

                        endcase

                        state <= FETCH;
                    end

                    default: begin
                        state <= FETCH;
                    end

                endcase
            end
        end
    end

endmodule