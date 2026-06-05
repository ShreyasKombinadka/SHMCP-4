`timescale 1ns/1ps

module Datapath_tb ;
reg clk, grst ; // Clock and Reset
reg [7:0] instr ;   // Instruction
wire [3:0] bus ;    // Databus


Datapath dut ( .clk(clk), .grst(grst), .instr(instr), .bus(bus) );

initial clk = 0 ;
always #5  clk = ~clk ; 

initial
begin

    instr = 8'b0 ; grst = 1 ;
    @( negedge clk ) ; grst = 0 ; instr = 8'b0_01_0_0010 ; // 2 -> A
    @( negedge clk ) ; instr = 8'b0_10_0_0101 ; // 5 -> B
    @( negedge clk ) ; instr = 8'b0_00_0_1011 ; // ADD
    @( negedge clk ) ; instr = 8'b1_11_1_0000 ; // R -> ROM[0]
    @( negedge clk ) ; instr = 8'b0_01_0_0111 ; // 7 -> A
    @( negedge clk ) ; instr = 8'b0_10_0_0110 ; // 6 -> B
    @( negedge clk ) ; instr = 8'b0_00_0_1100 ; // SUB
    @( negedge clk ) ; instr = 8'b0_00_0_0111 ; // R -> X1
    @( negedge clk ) ; instr = 8'b1_10_0_0000 ; // ROM[0] -> B
    @( negedge clk ) ; instr = 8'b0_00_0_0100 ; // B -> X2
    @( negedge clk ) ; instr = 8'b0_00_0_1011 ; // ADD
    @( negedge clk ) ; instr = 8'b1_11_1_0001 ; // R -> ROM[1]
    
    @( negedge clk ) ; $finish ;

end

endmodule