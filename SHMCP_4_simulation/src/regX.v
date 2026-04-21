module regX (   // ALU input handling registers
    input clk,
    input grst, lrst,   // Global and Local reset
    input rs1, rs2, rs3,
    inout [3:0] bus,    // Data bus
    output [3:0] opA,   // A operand
    output [3:0] opB,   // B operand
    output [3:0] opcode // Logic operation selector
);

reg [3:0] X1 ;   // X1 register for storing operand A
reg [3:0] X2 ;   // X2 register for storing operand B
reg [3:0] X3 ;   // X3 register for storing operand OP


always @( posedge clk or posedge grst )
begin
    if ( lrst | grst )
    begin
        X1 <= 0 ;
        X2 <= 0 ;
        X3 <= 0 ;
    end

    else if ( rs1 | rs2 | rs3 )
    begin
        if ( rs1 )
        begin
            X1 <= bus ;  // Read from the bus
        end
        else if ( rs2 )
        begin
            X2 <= bus ;  // Read from the bus
        end
        else if ( rs3 )
        begin
            X3 <= bus ;  // Read from the bus
        end
    end
    
end

assign opA = X1 ; // Output A operand
assign opB = X2 ; // Output B operand
assign opcode = X3 ; // Output OP operand


endmodule