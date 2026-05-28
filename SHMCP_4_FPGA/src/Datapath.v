module Datapath (
    input clk, rsbt,            // Clock and Reset or Reboot
    input [7:0] instr,          // Instruction
    output reg z_flag,          // Data bus
    output [3:0] regA_disp,     // Regsiter data to show on the display
    output [3:0] regB_disp,     // Regsiter data to show on the display
    output [3:0] regOP_disp,    // Regsiter data to show on the display
    output [3:0] rega_disp,     // Regsiter data to show on the display
    output [3:0] regb_disp,     // Regsiter data to show on the display
    output [3:0] regop_disp,    // Regsiter data to show on the display
    output [3:0] regR_disp,     // Regsiter data to show on the display
    output [3:0] regF_disp      // Regsiter data to show on the display
);

wire [3:0] bus; // Data bus

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
Register_file Registers ( .clk(clk), .grst(rsbt), .imm(imm), .instr(instr_r), .bus(bus),
                        .regA_disp(regA_disp), .regB_disp(regB_disp), .regOP_disp(regOP_disp) );

//-----------------------------------------------------
// ALU
//-----------------------------------------------------
ALU_unit ALU ( .clk(clk), .grst(rsbt), .instr(instr_a), .bus(bus),
                .rega_disp(rega_disp), .regb_disp(regb_disp), .regop_disp(regop_disp), .regR_disp(regR_disp), .regF_disp(regF_disp) );

//-----------------------------------------------------
// RAM
//-----------------------------------------------------
RAM ram ( .clk(clk), .rst(rsbt), .instr(instr), .bus(bus) );

always @(*)
begin
    if(instr == 10) z_flag <= bus[0]; // Zero flag for ctrl unit
    else z_flag <= 0;
end

endmodule