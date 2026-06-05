module ctrl_unit_tb ;
reg clk, rst ;  // Clock and Reset
reg state ; // Enable for instruction load
reg load ;  // Instruction load enable
reg [7:0] instr_i ; // Instruction input
wire [7:0] instr ;  // Instruction for the datapath
wire [3:0] bus ;    // Data bus

reg temp_load ; // Temp bus value enable
reg [3:0] temp ;    // Temp bus value

ctrl_unit dut ( .clk(clk), .rst(rst), .state(state), .load(load), .instr_i(instr_i), .instr(instr), .bus(bus) );

initial clk = 0 ;
always #5 clk = ~clk ;

initial
begin

    rst = 1 ; state = 0 ; load = 0 ; instr_i = 0 ; temp_load = 0 ; temp = 0 ;
    @( negedge clk ) ; rst = 0 ; load = 1 ; instr_i = 8'b0_01_0_1001 ; // test sequence(Should be passed directly to Datapath)
    @( negedge clk ) ; instr_i = 8'b0_10_0_0010 ;   // test sequence(Should be passed directly to Datapath)
    @( negedge clk ) ; instr_i = 8'b0_00_0_1100 ;   // test sequence(Should be passed directly to Datapath)
    @( negedge clk ) ; instr_i = 8'b0_00_0_0011 ;   // test sequence(Should be passed directly to Datapath)
    @( negedge clk ) ; instr_i = 8'b0_00_0_1011 ;   // test sequence(Should be passed directly to Datapath)
    @( negedge clk ) ; instr_i = 8'b0_01_1_0011 ;   // JNZ ( jump address 0010 )
    @( negedge clk ) ; instr_i = 8'b0_00_0_1110 ;   // test sequence(Should be passed directly to Datapath)
    @( negedge clk ) ; instr_i = 8'b0_00_0_0010 ;   // test sequence(Should be passed directly to Datapath)
    @( negedge clk ) ; load = 0 ; instr_i = 8'b0_10_0_1111 ;   // test sequence(Should be passed directly to Datapath)
    
    @( negedge clk ) ; state = 1 ;  // Run the code
    @( negedge clk ) ; temp_load = 1 ; temp = 4'b0000 ; // Set zero flag low
    #150 ; 
    @( negedge clk ) ; temp_load = 1 ; temp = 4'b0001 ; // Set zero flag high

    #200 ; $finish ;

end

assign bus = ( temp_load ) ? temp : 4'bZ ;

endmodule