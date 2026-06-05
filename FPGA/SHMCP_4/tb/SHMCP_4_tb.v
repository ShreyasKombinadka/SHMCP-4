`timescale 1ns / 1ps

module SHMCP_4_tb;
reg clk, rst;  // Clock and Reset
reg rbt;
reg state; // Enable for instruction load
reg load;  // Instruction load enable
reg [7:0] instr;   // Instruction input
reg [2:0] sel;
wire [3:0] reg_disp;
wire state_o;
wire load_o;
wire trm_f;

localparam clk_freq = 10_000;   // Test clock frequency

SHMCP_4 #(.clk_freq(clk_freq)) dut ( .clk_in(clk), .rst(rst), .rbt(rbt),
        .state(state), .load(load), .instr(instr), .sel(sel),
        .reg_disp(reg_disp), .state_o(state_o), .load_o(load_o), .trm_f(trm_f));

initial clk = 0;
always #1 clk = ~clk;

initial begin

    rst = 1 ; rbt = 0;
    state = 0 ; load = 0 ; instr = 0 ; sel = 7;

    repeat(1000) @( negedge clk ) ; rst = 0 ; 
    @( negedge dut.clk ) ; instr = 8'h0F ; load = 1;  // CLEAR
    @( negedge dut.clk ) ; load = 0;
    @( negedge dut.clk ) ; instr = 8'h2A ; load = 1;  // 10 -> A & a
    @( negedge dut.clk ) ; load = 0;
    @( negedge dut.clk ) ; instr = 8'h41 ; load = 1;  // 1 -> B & a
    @( negedge dut.clk ) ; load = 0;
    @( negedge dut.clk ) ; instr = 8'h0D ; load = 1;  // SUB ( A(a) - B(b) )
    @( negedge dut.clk ) ; load = 0;
    @( negedge dut.clk ) ; instr = 8'h07 ; load = 1;  // R -> X1
    @( negedge dut.clk ) ; load = 0;
    @( negedge dut.clk ) ; instr = 8'h34 ; load = 1;  // JNZ
    @( negedge dut.clk ) ; load = 0;
    @( negedge dut.clk ) ; instr = 8'h06 ; load = 1;  // R -> A
    @( negedge dut.clk ) ; load = 0;
    @( negedge dut.clk ) ; instr = 8'h00 ; load = 1;  // NOP
    @( negedge dut.clk ) ; load = 0;
    
    @(negedge dut.clk) ; state = 1 ; load = 0 ; // Run the programm
    repeat(50000) @( negedge clk ) ; rbt = 1 ;  // Reboot
    repeat(1000) @( negedge clk ) ; rbt = 0;

    @(posedge trm_f) ;  // Let the programm run till Termonation flag is set
    repeat(50000) @( negedge clk ) ; state = 0 ; load = 0 ; instr = 0 ; sel = 0;
    
    repeat(50000) @( negedge clk ) ; rst = 1 ;
    repeat(1000) @( negedge clk ) ; rst = 0; 
    
    repeat(50000) @(negedge clk) ; state = 1;    // Run the programm
    @(posedge trm_f);

    repeat(50000) @(negedge clk) ; $finish;

end

endmodule