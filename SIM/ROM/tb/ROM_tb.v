module ROM_tb ;
reg [7:0] instr ;   // Instruction
wire [3:0] bus ;    // Data bus
wire [3:0] instr_r ;    // Instruction for Register file
wire [3:0] instr_a ;    // Instruction for ALU
wire [3:0] imm ;    // Immediate value

reg tb_clk ;    // Clock for testbench
ROM dut ( .instr(instr), .bus(bus), .instr_r(instr_r), .instr_a(instr_a), .imm(imm) );

initial tb_clk = 0 ;
always #5 tb_clk = ~tb_clk ;

initial
begin

    instr = 0 ;
    @( negedge tb_clk ) ; instr = 8'h02 ;   // MOV A, X1 ; AR ROM operation
    @( negedge tb_clk ) ; instr = 8'h0C ;   // ADD ; AR ROM operation
    @( negedge tb_clk ) ; instr = 8'h23 ;   // LDI A, 3 ; IMM ROM operation
    @( negedge tb_clk ) ; instr = 8'h48 ;   // LDI B, 8 ; IMM ROM operation
    @( negedge tb_clk ) ; instr = 8'h66 ;   // LDI OP, 6 ; IMM ROM operation
    @( negedge tb_clk ) ; instr = 8'hBA ;   // MOV A, MEM[10] ; MEM ROM operation
    @( negedge tb_clk ) ; instr = 8'hF5 ;   // MOV R, MEM[5] ; MEM ROM operation
    @( negedge tb_clk ) ; instr = 8'h38 ;   // JNZ instrmem[8] ; PC control operation should be ignored by the ROM
    @( negedge tb_clk ) ; instr = 8'h76 ;   // J instrmem[6] ; PC control operation should be ignored by the ROM
    @( negedge tb_clk ) ; $finish ;

end
endmodule