module RAM (
    input clk,rst,  // Clock and Reset
    input [7:0] instr,  // Instruction
    inout [3:0] bus // Data bus
);

reg [3:0] mem [15:0] ;  // Memory element
integer i ;

always @( posedge clk or posedge rst )
begin

    if ( rst )
    begin
        for ( i = 0 ; i <= 15 ; i = i + 1 )
        begin
            mem[i] <= 0 ;   // initializing
        end
    end

    else if ( instr[7] & instr[4] )
    begin
        mem[instr[3:0]] <= bus ;    // Load bus value to the specified memory location
    end

end

assign bus = ( instr[7] && ~instr[4] ) ? mem[instr[3:0]] : 4'bZ ;   // Reading from the specified memory locations

endmodule