module SHMCP_4  // SHMCP - Simple Hierarchical MicroCode Processor
(
    input clk, rst,     // Clock and Reset
    input state,        // State of the CPU
    input load,         // Enable for instruction load
    input [7:0] instr  // Instruction input
);

//-----------------------------------------------------
// Control unit
//-----------------------------------------------------
wire [7:0] instr_o ;    // Instruction for data unit
wire [3:0] bus ;        // Data bus
ctrl_unit control ( .clk(clk), .rst(rst), .state(state), .load(load), .instr_i(instr), .instr(instr_o), .bus(bus) );

//-----------------------------------------------------
// Regsiter data to show on the display
//-----------------------------------------------------
wire [3:0] regA_disp ;
wire [3:0] regB_disp ;
wire [3:0] regOP_disp ;
wire [3:0] rega_disp ;
wire [3:0] regb_disp ;
wire [3:0] regop_disp ;
wire [3:0] regR_disp ;
wire [3:0] regF_disp ;

//-----------------------------------------------------
// Data unit
//-----------------------------------------------------
Datapath Data ( .clk(clk), .grst(rst), .instr(instr_o), .bus(bus),
                .regA_disp(regA_disp), .regB_disp(regB_disp), .regOP_disp(regOP_disp),
                .rega_disp(rega_disp), .regb_disp(regb_disp), .regop_disp(regop_disp), .regR_disp(regR_disp), .regF_disp(regF_disp) );


endmodule