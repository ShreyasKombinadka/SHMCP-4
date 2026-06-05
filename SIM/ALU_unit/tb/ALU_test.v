module ALU_unit_tb ;
    reg clk ;
    reg grst ;  // Global reset
    reg [3:0] instr ;   // Instruction
    wire [3:0] bus ;    // Data BUS

integer i ;
reg bus_write ;  // Flag to indicate BUS writing
reg [3:0] bus_temp ;    // Temporary variable to hold the value to be loaded to the bus

ALU_unit dut ( .clk(clk), .grst(grst), .instr(instr), .bus(bus) );

always
begin
    #10 ; clk = ~clk ;  // Clock generation
end

initial
begin

    clk = 0 ; grst = 1 ; instr = 4'h0 ; bus_write = 0 ; bus_temp = 4'h0 ;  // Initial condition
    @( negedge clk ) ; grst = 0 ; bus_write = 1 ; bus_temp = 4'h4 ; instr = 4'h1 ; // MOV BUS -> X1
    @( negedge clk ) ; bus_temp = 4'h1 ; instr = 4'h2 ; // MOV BUS -> X2
    for( i = 1 ; i < 8 ; i = i + 1 )    // Loop to step through all the logic operations
    begin
        @( negedge clk ) ; bus_temp = i ; instr = 4'h3 ;    // MOV BUS -> X3
        @( negedge clk ) ; instr = 4'h4 ;   // LOGIC
    end
    @( negedge clk ) ; bus_write = 0 ; instr = 4'h5 ;   // ADD
    @( negedge clk ) ; instr = 4'h6 ;   // SUB
    @( negedge clk ) ; instr = 4'h7 ;   // MOV R -> BUS
    @( negedge clk ) ; instr = 4'h8 ;   // MOV FLAG -> BUS
    @( negedge clk ) ; instr = 4'h9 ;   // MOV R -> X1    
    @( negedge clk ) ; instr = 4'hA ;   // MOV R -> X2    
    @( negedge clk ) ; instr = 4'hF ;   // CLEAR
    @( negedge clk ) ; $finish ;

end

assign bus = ( bus_write ) ? bus_temp : 4'bZ ;   // Write to the bus

endmodule