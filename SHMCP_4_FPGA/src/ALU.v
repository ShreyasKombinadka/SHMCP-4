module ALU (    // Arithmatic and logic unit
    input [1:0] op_sel,    // Operation(logic or arithmatic) select and arithmatic(add or sub) select
    input [3:0] opA, opB, opcode,   // A operand, B operand and The operation selector for logic operation
    output reg [3:0] res,    // Output of ALU
    output Z, C, O, N // Flags
);

reg cb ;    // Carry or barrow flag

always @( * )
begin

    cb = 0 ;    // Default value for carry flag
    res = 4'b0000 ;

    case ( op_sel )
        2'b01 : begin   // Logic operations
            case ( opcode ) 
                4'h1 : res = ~opA ; // NOT
                4'h2 : res = opA & opB ;    // AND
                4'h3 : res = opA | opB ;    // OR
                4'h4 : res = ~( opA & opB ) ;   // NAND
                4'h5 : res = ~( opA | opB ) ;   // NOR
                4'h6 : res = opA ^ opB ;    // XOR
                4'h7 : res = ~( opA ^ opB ) ;   // XNOR
            endcase
        end

        // Arithmatic operations
        2'b10 : { cb, res } = opA + opB ;  // Addition
        2'b11 : { cb, res } = opA - opB ;  // Subtration

    endcase
    
end

assign Z = ( res == 4'b0000 ) ; // Zero flag
assign C = ( op_sel == 2'b11 ) ? ~cb : cb ; // Carry or barrow flag
assign O = ( op_sel == 2'b10 ) ? ( opA[3] == opB[3] ) && ( opA[3] != res[3] ) : ( op_sel == 2'b11 ) ? ( opA[3] != opB[3] ) && ( opA[3] != res[3] ) : 0 ;   // Overflow flag
assign N = res[3] ; // Negative flag


endmodule