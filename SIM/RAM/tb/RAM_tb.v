module RAM_tb ;
reg clk,rst ;   // Clock and Reset
reg [7:0] instr ;   // Instruction
wire [3:0] bus ;    // Data bus

reg bus_en ;    // Bus enable for testing
reg [3:0] temp ;    // Temporary bus value

RAM dut ( .clk(clk), .rst(rst), .instr(instr), .bus(bus) );

initial clk = 0 ;
always #5 clk = ~clk ;

initial
begin

    rst = 1 ; temp = 0 ; bus_en = 0 ; instr = 0 ;

    @( negedge clk ) ; rst = 0 ; instr = 8'b0_00_0_1111 ;   // instruction not ment for memory operation should be ignored by the memory
    @( negedge clk ) ; bus_en = 1 ; temp = 4'b0100 ; instr = 8'b1_00_1_0001 ;   // Write to mem[1]
    @( negedge clk ) ; temp = 4'b0110 ; instr = 8'b1_00_1_0011 ;    // Write to mem[3]
    @( negedge clk ) ; temp = 4'b1100 ; instr = 8'b1_00_1_0100 ;    // Write to mem[4]
    @( negedge clk ) ; temp = 4'b0101 ; instr = 8'b1_00_1_0101 ;    // Write to mem[5]
    @( negedge clk ) ; temp = 4'b0111 ; instr = 8'b1_00_1_0110 ;    // Write to mem[6]
    @( negedge clk ) ; temp = 4'b1110 ; instr = 8'b1_00_1_1110 ;    // Write to mem[12]
    @( negedge clk ) ; bus_en = 0 ; temp = 4'b0000 ; instr = 8'b1_00_0_0001 ;   // Read from mem[1]
    @( negedge clk ) ; instr = 8'b1_00_0_0011 ; // // Read from mem[3]
    @( negedge clk ) ; $finish ;

end

assign bus = ( en ) ? temp : 4'bZ ; // Bus simulation

endmodule