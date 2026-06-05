module regR (   // The result register
    input clk,
    input grst, lrst,   // Global and Local reset
    input [1:0] op_sel,  // Operation enable for ALU
    input ws1, ws2,  // Enable for writing to the BUS
    input Z, C, O, N,   // Flags from ALU
    input [3:0] res,    // Result from ALU
    inout [3:0] bus    // Data bus
);

reg [3:0] dff ; // Result register
reg [3:0] flags ;  // Flag register

always @( posedge clk or posedge grst )
begin
    if ( lrst | grst )
    begin
        dff <= 4'b0000 ;
        flags <= 4'b0000 ;
    end
    else if ( op_sel != 2'b00 )    // Update when either registers are not writing to the bus
    begin
        dff <= res ;    // Store result
        flags [0] <= Z ;    // Zero flag
        flags [1] <= C ;    // Carry flag
        flags [2] <= O ;    // Overflow flag
        flags [3] <= N ;    // Negative flag
    end
end

assign bus = ( ws1 ) ? dff : ( ws2 ) ? flags : 4'bZ ; // Write to bus if respective write enable is active otherwise disconnect BUS

endmodule