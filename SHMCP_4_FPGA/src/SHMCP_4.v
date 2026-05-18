module SHMCP_4  // SHMCP - Simple Hierarchical MicroCode Processor
#(
    parameter clk_freq = 100_000_000
)(
    input clk_in, rst,      // Clock and Reset
    input state,            // State of the CPU
    input load,             // Enable for instruction load
    input [7:0] instr,      // Instruction input
    output [3:0] regR_disp,
    output state_o,
    output load_o
);

//-----------------------------------------------------
// Clock generation
//-----------------------------------------------------
wire clk ;  // Clock
clk_2stage #(.clk_freq(clk_freq)) Clock( .clk_in(clk_in), .rst(rst), .state(state), .clk_out(clk) );

//-----------------------------------------------------
// Control unit
//-----------------------------------------------------
wire [7:0] instr_o ;    // Instruction for data unit
wire z_flag ;           // Zero flag
ctrl_unit control ( .clk(clk), .rst(rst), .state(state), .load(load), .instr_i(instr), .instr(instr_o), .z_flag(z_flag) );

//-----------------------------------------------------
// Data unit
//-----------------------------------------------------
Datapath Data ( .clk(clk), .grst(rst), .instr(instr_o), .z_flag(z_flag),
                .regR_disp(regR_disp) );

assign state_o = state;
assign load_o = load;

endmodule