module Datapath (
    input clk, grst,            // Clock and Reset
    input [7:0] instr,          // Instruction
    inout [3:0] bus,            // Data bus
    output [3:0] regA_disp,     // Regsiter data to show on the display
    output [3:0] regB_disp,     // Regsiter data to show on the display
    output [3:0] regOP_disp,    // Regsiter data to show on the display
    output [3:0] rega_disp,     // Regsiter data to show on the display
    output [3:0] regb_disp,     // Regsiter data to show on the display
    output [3:0] regop_disp,    // Regsiter data to show on the display
    output [3:0] regR_disp,     // Regsiter data to show on the display
    output [3:0] regF_disp      // Regsiter data to show on the display
);

//-----------------------------------------------------
// ROM
//-----------------------------------------------------
wire [3:0] instr_r ;    // Instruction for Register file
wire [3:0] instr_a ;    // Instruction for ALU
wire [3:0] imm ;        // Immediate value
ROM rom ( .instr(instr), .bus(bus), .instr_r(instr_r), .instr_a(instr_a), .imm(imm) );

//-----------------------------------------------------
// Register file
//-----------------------------------------------------
Register_file Registers ( .clk(clk), .grst(grst), .imm(imm), .instr(instr_r), .bus(bus),
                        .regA_disp(regA_disp), .regB_disp(regB_disp), .regOP_disp(regOP_disp) );

//-----------------------------------------------------
// ALU
//-----------------------------------------------------
ALU_unit ALU ( .clk(clk), .grst(grst), .instr(instr_a), .bus(bus),
                .rega_disp(rega_disp), .regb_disp(regb_disp), .regop_disp(regop_disp), .regR_disp(regR_disp), .regF_disp(regF_disp) );

//-----------------------------------------------------
// RAM
//-----------------------------------------------------
RAM ram ( .clk(clk), .rst(grst), .instr(instr), .bus(bus) );

endmodule