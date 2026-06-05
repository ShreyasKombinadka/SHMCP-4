module SHMCP_4 (  // SHMCP - Simple Hierarchical MicroCode Processor
    input clk, rst, // Clock and Reset
    input state,    // State of the CPU
    input load, // Enable for instruction load
    input [7:0] instr    // Instruction input
);

//-----------------------------------------------------
// Control unit
//-----------------------------------------------------
wire [7:0] instr_o ;    // Instruction for data unit
wire [3:0] bus ;    // Data bus
ctrl_unit control ( .clk(clk), .rst(rst), .state(state), .load(load), .instr_i(instr), .instr(instr_o), .bus(bus) );

//-----------------------------------------------------
// Data unit
//-----------------------------------------------------
Datapath Data ( .clk(clk), .grst(rst), .instr(instr_o), .bus(bus) );

endmodule