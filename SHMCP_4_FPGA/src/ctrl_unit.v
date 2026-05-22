module ctrl_unit (
    input clk, rst,
    input state,            // State of the processor
    input load,             // Enable for instruction load
    input z_flag,           // Zero flag
    input [7:0] instr_i,    // Instruction input
    output [7:0] instr,     // Instruction for the datapath
    output [3:0] pc_o,
    output trm
);

//-----------------------------------------------------
// Program memory
//-----------------------------------------------------
wire [3:0] pc_out ; // Program counter
wire [7:0] instr_o ;    // Instruction out from the mem
instr_mem memory ( .clk(clk), .rst(rst), .state(state), .load(load), .pc(pc_out), .instr_i(instr_i), .instr_o(instr_o) );

//-----------------------------------------------------
// Program counter
//-----------------------------------------------------
wire [3:0] pc_jmp ;   // Jump address
prog_count pc ( .clk(clk), .rst(rst), .state(state), .load(load), .instr(instr_o), .pc_count(pc_jmp), .pc(pc_out), .trm(trm));

//-----------------------------------------------------
// Jump statement handler
//-----------------------------------------------------
pc_ctrl ctrl ( .instr_o(instr_o), .pc_count(pc_jmp), .instr(instr), .z_flag(z_flag) );

assign pc_o = pc_out;

endmodule