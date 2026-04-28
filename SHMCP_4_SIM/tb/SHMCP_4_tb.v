module CPU4_tb ;
reg clk, rst ;  // Clock and Reset
reg state ; // Enable for instruction load
reg load ;  // Instruction load enable
reg [7:0] instr ;   // Instruction input

SHMCP_4 dut ( .clk(clk), .rst(rst), .state(state), .load(load), .instr(instr) );

initial clk = 0 ;
always #5 clk = ~clk ;

initial begin

    rst = 1 ; state = 0 ; load = 0 ; instr = 0 ;
    @( negedge clk ) ; rst = 0 ; instr = 8'h0F ; load = 1 ;
    @( negedge clk ) ; instr = 8'h2A ;  // 10 -> A
    @( negedge clk ) ; instr = 8'h41 ;  // 1 -> B
    @( negedge clk ) ; instr = 8'h0D ;  // ADD ( A - B )
    @( negedge clk ) ; instr = 8'h07 ;  // R -> X1
    @( negedge clk ) ; instr = 8'h34 ;  // JNZ
    @( negedge clk ) ; instr = 8'h06 ;  // R -> A
    @( negedge clk ) ; instr = 8'h00 ;  // NOP
    
    #10
    @( negedge clk ) ; state = 1 ; load = 0 ; // Run the programm
    #400 ; $finish ;

end

endmodule