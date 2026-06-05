`timescale 1ns / 1ps

module Register_file_tb ;
reg clk ;   // Clock
reg grst ;  // Global reset
reg [3:0] imm ; // Immediate value
reg [3:0] instr ;   // Instruction
wire [3:0] bus ;    // Data bus

reg bus_read ;  // Enable bus read
reg [3:0] bus_temp ;    // Temporary bus value

Register_file dut ( .clk(clk), .grst(grst), .imm(imm), .instr(instr), .bus(bus) );

initial clk = 0 ;
always #5 clk = ~clk ;

initial
begin
    grst = 1 ;
    imm = 4'h0 ; bus_read = 0 ; bus_temp = 4'h0 ; instr = 4'h0 ;    // NOP

    @( negedge clk ) ; grst = 0 ; imm = 4'hA ; instr = 4'h1 ;   // LDI A
    @( negedge clk ) ; imm = 4'h7 ; instr = 4'h2 ;  // LDI B
    @( negedge clk ) ; imm = 4'h5 ; instr = 4'h3 ;  // LDI OP
    @( negedge clk ) ; bus_read = 1 ; bus_temp = 4'h2 ; instr = 4'h4 ;  // MOV BUS, A
    @( negedge clk ) ; bus_read = 1 ; bus_temp = 4'h8 ; instr = 4'h5 ;  // MOV BUS, B
    @( negedge clk ) ; bus_read = 0 ; bus_temp = 4'h0 ; instr = 4'h6 ;  // MOV A, BUS
    @( negedge clk ) ; instr = 4'h7 ;   // MOV B, BUS
    @( negedge clk ) ; instr = 4'h8 ;   // MOV OP, BUS
    @( negedge clk ) ; instr = 4'h9 ;   // MOV A, B
    @( negedge clk ) ; instr = 4'h2 ;
    @( negedge clk ) ; instr = 4'hA ;   // MOV B, A
    @( negedge clk ) ; instr = 4'hB ;   // MOV OP, A
    @( negedge clk ) ; instr = 4'hC ;   // MOV OP, B
    @( negedge clk ) ; instr = 4'hF ;   // CLEAR
    @( negedge clk ) ; $finish ;
end

assign bus = ( bus_read ) ? bus_temp : 4'bZ ;

endmodule