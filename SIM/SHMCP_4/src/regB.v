module regB (
    input clk,
    input grst, lrst,   // Global and Local reset
    input [3:0] imm,   // Immediate value
    input rs3,rs4,ws2,  // Tristate buffer control signals
    inout [3:0] bus  // Data BUS
);

reg [3:0] dff ;   // Memory element

always @( posedge clk or posedge grst )
begin
    if( lrst | grst )
    begin
        dff <= 4'b0 ;
    end
    else if( rs3 )
    begin
        dff <= imm ;  // Load immediate value to dff
    end
    else if( rs4 )
    begin
        dff <= bus ; // Load BUS value to dff
    end
end

assign bus = ( ws2 ) ? dff : 4'bZ ;    // Write B to bus if ws1 is active or disconnect from BUS

endmodule