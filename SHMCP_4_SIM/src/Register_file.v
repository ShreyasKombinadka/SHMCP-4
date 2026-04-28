module Register_file (
    input clk,
    input grst,    // Global reset
    input [3:0] imm,    // Immediate value
    input [3:0] instr,  // Instruction
    inout [3:0] bus // Data bus
);


//-----------------------------------------------------
// Instruction decoding
//-----------------------------------------------------
wire [2:0] rs_dec ; // Decoded read select
wire [1:0] ws_dec ; // Decoded riht select
wire lrst ;  // Local reset
regfile_dec R_decoder ( .instr(instr), .rs(rs_dec), .ws(ws_dec), .rst(lrst) );


//--------------------------------------------------------------------------------
// Register control (by using enable signals of the tristate buffers)
//--------------------------------------------------------------------------------
wire rs1_en, rs2_en, rs3_en, rs4_en, rs5_en ;   // Read buffers enable signals
wire ws1_en, ws2_en, ws3_en ;   // Write buffers enable signals
regfile_ctrl Register_controll ( .rs(rs_dec), .ws(ws_dec),
                 .rs1(rs1_en), .rs2(rs2_en), .rs3(rs3_en), .rs4(rs4_en), .rs5(rs5_en),
                 .ws1(ws1_en), .ws2(ws2_en), .ws3(ws3_en) 
);


//-----------------------------------------------------
// Reister file
//-----------------------------------------------------
regA A ( .clk(clk), .grst(grst), .lrst(lrst), .imm(imm), .rs1(rs1_en), .rs2(rs2_en), .ws1(ws1_en), .bus(bus) );    // Reister A block

regB B ( .clk(clk), .grst(grst), .lrst(lrst), .imm(imm), .rs3(rs3_en), .rs4(rs4_en), .ws2(ws2_en), .bus(bus) );    // Register B block

regOP OP ( .clk(clk), .grst(grst), .lrst(lrst), .imm(imm), .rs5(rs5_en), .ws3(ws3_en), .bus(bus) );    // Register OP block


endmodule