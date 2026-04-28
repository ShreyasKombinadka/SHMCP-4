`timescale 1ns / 1ps

module SHMCP_4_tb ;
reg clk, rst ;  // Clock and Reset
reg state ; // Enable for instruction load
reg load ;  // Instruction load enable
reg [7:0] instr ;   // Instruction input
wire [3:0] regA_disp ;
wire [3:0] regB_disp ;
wire [3:0] regOP_disp ;
wire [3:0] rega_disp ;
wire [3:0] regb_disp ;
wire [3:0] regop_disp ;
wire [3:0] regR_disp ;
wire [3:0] regF_disp ;

localparam clk_freq = 10_000;

SHMCP_4 #(.clk_freq(clk_freq)) dut ( .clk_in(clk), .rst(rst), .state(state), .load(load), .instr(instr),
                .regA_disp(regA_disp), .regB_disp(regB_disp), .regOP_disp(regOP_disp),
                .rega_disp(rega_disp), .regb_disp(regb_disp), .regop_disp(regop_disp), .regR_disp(regR_disp), .regF_disp(regF_disp));

initial clk = 0 ;
always #1 clk = ~clk ;

initial begin

    rst = 1 ; state = 0 ; load = 0 ; instr = 0 ;
    @( negedge dut.clk ) ; rst = 0 ; 
    @( negedge dut.clk ) ; instr = 8'h0F ; load = 1 ;
    @( negedge dut.clk ) ; instr = 8'h2A ;  // 10 -> A
    @( negedge dut.clk ) ; instr = 8'h41 ;  // 1 -> B
    @( negedge dut.clk ) ; instr = 8'h0D ;  // SUB ( A - B )
    @( negedge dut.clk ) ; instr = 8'h07 ;  // R -> X1
    @( negedge dut.clk ) ; instr = 8'h34 ;  // JNZ
    @( negedge dut.clk ) ; instr = 8'h06 ;  // R -> A
    @( negedge dut.clk ) ; instr = 8'h00 ;  // NOP
    
    @(negedge dut.clk) ; state = 1 ; load = 0 ; // Run the programm
    repeat(40) @(negedge dut.clk) ; $finish ;

end

endmodule