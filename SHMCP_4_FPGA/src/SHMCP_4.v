module SHMCP_4  // SHMCP - Simple Hierarchical MicroCode Processor
#(
    parameter clk_freq = 100_000_000
)(
    input clk_in, rst,      // Clock and Reset
    input state,            // State of the CPU
    input load,             // Enable for instruction load
    input [7:0] instr,      // Instruction input
    input [2:0] sel,
    output [3:0] reg_disp,
    output state_o,
    output load_o,
    output trm_f
);

//-----------------------------------------------------
// Clock generation
//-----------------------------------------------------
wire trm;   // Termination flag
wire clk;   // Clock
clk_2stage #(.clk_freq(clk_freq)) Clock( .clk_i(clk_in), .rst(rst), .state(state), .trm(trm), .clk_o(clk) );

//-----------------------------------------------------
// Control unit
//-----------------------------------------------------
wire [7:0] instr_o;    // Instruction for data unit
wire z_flag;           // Zero flag
wire [3:0] pc_o;
ctrl_unit control ( .clk(clk), .rst(rst), .state(state), .load(load), .instr_i(instr), .z_flag(z_flag), .instr(instr_o), .pc_o(pc_o), .trm(trm));

//-----------------------------------------------------
// Data unit
//-----------------------------------------------------
wire [3:0] regA_disp ;
wire [3:0] regB_disp ;
wire [3:0] regOP_disp ;
wire [3:0] rega_disp ;
wire [3:0] regb_disp ;
wire [3:0] regop_disp ;
wire [3:0] regR_disp ;
wire [3:0] regF_disp ;
Datapath Data ( .clk(clk), .grst(rst), .instr(instr_o), .z_flag(z_flag),
                .regA_disp(regA_disp), .regB_disp(regB_disp), .regOP_disp(regOP_disp),
                .rega_disp(rega_disp), .regb_disp(regb_disp), .regop_disp(regop_disp), .regR_disp(regR_disp), .regF_disp(regF_disp));

//-----------------------------------------------------
// Data to display
//-----------------------------------------------------
wire [31:0] data_i = {regF_disp, regR_disp, regop_disp, regb_disp, rega_disp, regB_disp, regA_disp, pc_o};
out_mux #(.data_l(4), .data_c(8), .sel_l(3)) disp_outputs(.data_i(data_i), .sel(sel), .data_o(reg_disp));

assign state_o = state;
assign load_o = load;
assign trm_f = trm;

endmodule