module Datapath (
    input clk, grst,    // Clock and Reset
    input [7:0] instr,  // Instruction
    inout [3:0] bus // Data bus
);

//-----------------------------------------------------
// ROM
//-----------------------------------------------------
wire [3:0] instr_r ;  // Instruction for Register file
wire [3:0] instr_a ;  // Instruction for ALU
wire [3:0] imm ;  // Immediate value
ROM rom ( .instr(instr), .bus(bus), .instr_r(instr_r), .instr_a(instr_a), .imm(imm) );

//-----------------------------------------------------
// Register file
//-----------------------------------------------------
Register_file Registers ( .clk(clk), .grst(grst), .imm(imm), .instr(instr_r), .bus(bus) );

//-----------------------------------------------------
// ALU
//-----------------------------------------------------
ALU_unit ALU ( .clk(clk), .grst(grst), .instr(instr_a), .bus(bus) );

//-----------------------------------------------------
// RAM
//-----------------------------------------------------
RAM ram ( .clk(clk), .rst(grst), .instr(instr), .bus(bus) );

endmodule