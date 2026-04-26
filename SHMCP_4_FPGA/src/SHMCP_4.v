module SHMCP_4  // SHMCP - Simple Hierarchical MicroCode Processor
(
    input clk_in, rst,      // Clock and Reset
    input state,            // State of the CPU
    input load,             // Enable for instruction load
    input [7:0] instr,      // Instruction input
    output [3:0] regA_disp,
    output [3:0] regB_disp,
    output [3:0] regOP_disp,
    output [3:0] rega_disp,
    output [3:0] regb_disp,
    output [3:0] regop_disp,
    output [3:0] regR_disp,
    output [3:0] regF_disp
);

//-----------------------------------------------------
// Clock generation
//-----------------------------------------------------
wire clk ;  // Clock
clk_100MHz_1Hz Clock_1Hz( .clk_in(clk_in), .rst(rst), .clk_out(clk_out) );

//-----------------------------------------------------
// Control unit
//-----------------------------------------------------
wire [7:0] instr_o ;    // Instruction for data unit
wire [3:0] bus ;        // Data bus
ctrl_unit control ( .clk(clk_out), .rst(rst), .state(state), .load(load), .instr_i(instr), .instr(instr_o), .bus(bus) );

//-----------------------------------------------------
// Data unit
//-----------------------------------------------------
Datapath Data ( .clk(clk_out), .grst(rst), .instr(instr_o), .bus(bus),
                .regA_disp(regA_disp), .regB_disp(regB_disp), .regOP_disp(regOP_disp),
                .rega_disp(rega_disp), .regb_disp(regb_disp), .regop_disp(regop_disp), .regR_disp(regR_disp), .regF_disp(regF_disp) );


endmodule