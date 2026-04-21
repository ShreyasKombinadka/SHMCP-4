module ALU_unit (
    input clk,
    input grst, // Global reset
    input [3:0] instr,  // Instruction
    inout [3:0] bus // Data bus
);


//-----------------------------------------------------
// Instruction decoding
//-----------------------------------------------------
wire [1:0] rs_dec ; // Decoded read select
wire [1:0] ws_dec ; // Decoded write select
wire [1:0] op_sel_dec ; // Decoded alu operation selector
wire rst_dec ;  // Local reset
alu_dec ALU_decoder ( .instr(instr), .rs(rs_dec), .ws(ws_dec), .op_sel(op_sel_dec), .rst(rst_dec) );


//--------------------------------------------------------------------------------
// Register control (by using enable signals of the tristate buffers)
//--------------------------------------------------------------------------------
wire rs1_en, rs2_en, rs3_en ;   // Read enable signals
wire ws1_en, ws2_en ;   // Write enable signals
alu_ctrl ALU_reg_ctrl ( .rs(rs_dec), .ws(ws_dec), .rs1(rs1_en), .rs2(rs2_en), .rs3(rs3_en), .ws1(ws1_en), .ws2(ws2_en) );


//-----------------------------------------------------
// ALU input register
//-----------------------------------------------------
wire [3:0] a ;    // A operand
wire [3:0] b ;    // B operand
wire [3:0] op ;    // OP operand
regX X ( .clk(clk), .grst(grst), .lrst(rst_dec), .rs1(rs1_en), .rs2(rs2_en), .rs3(rs3_en), .bus(bus), .opA(a), .opB(b), .opcode(op) );    // X1, X2 & X3 registers


//-----------------------------------------------------
// Arithmatic and logic unit
//-----------------------------------------------------
wire [3:0] result ; // Result of ALU opewration
wire z, c, o, n ;   // Flags
ALU alu ( .op_sel(op_sel_dec), .opA(a), .opB(b), .opcode(op), .res(result), .Z(z), .C(c), .O(o), .N(n) );    // ALU


//-----------------------------------------------------
// ALU output registers
//-----------------------------------------------------
regR R ( .clk(clk), .grst(grst), .lrst(rst_dec), .op_sel(op_sel_dec), .ws1(ws1_en), .ws2(ws2_en), .Z(z), .C(c), .O(o), .N(n), .res(result), .bus(bus) );    // Result and Flag registers


endmodule