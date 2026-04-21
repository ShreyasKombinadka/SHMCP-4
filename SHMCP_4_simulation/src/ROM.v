module ROM (
    input [7:0] instr,  // Instruction
    inout [3:0] bus,    // Data bus
    output [3:0] instr_r,  // Instruction for Register file block
    output [3:0] instr_a,   // Instruction for ALU rom
    output [3:0] imm    // Immediate value
);

//-----------------------------------------------------
// ROM control
//-----------------------------------------------------
wire [1:0] en ;   // Enable signals for different rom
rom_ctrl Control ( .instr(instr), .en(en) );

//-----------------------------------------------------
// AR rom ( ALU and Register rom control )
//-----------------------------------------------------
wire [7:0] ctrl_ar ;   // Control bits produced by AR rom
ARrom ROM1 ( .en(en), .instr(instr), .ctrl(ctrl_ar) );

//-----------------------------------------------------
// Immediate rom ( For loading immiediate value )
//-----------------------------------------------------
wire [7:0] ctrl_imm ;    // Control bits produced by IMM rom
IMMrom ROM2 ( .en(en), .instr(instr), .bus(bus), .ctrl(ctrl_imm), .imm(imm) );

//-----------------------------------------------------
// RAM rom ( For ram operation )
//-----------------------------------------------------
wire [7:0] ctrl_mem ;    // Control bits produced by IMM rom
MEMrom ROM3 ( .en(en), .instr(instr), .ctrl(ctrl_mem) );

//-----------------------------------------------------
// ROM instruction routing for different operations
//-----------------------------------------------------
instr_switch switch ( .en(en), .ctrl_ar(ctrl_ar), .ctrl_imm(ctrl_imm), .ctrl_mem(ctrl_mem), .instr_r(instr_r), .instr_a(instr_a) );


endmodule