module ARrom (
    input [1:0] en, // ROM operation enable
    input [7:0] instr,  // Istruction
    output reg [7:0] ctrl // Control bits
);

always @( * )
begin
    if ( en == 2'b01 )
    begin
        case ( instr[3:0] )

            4'h0 : ctrl = 8'b0000_0000 ; // NOP
            4'h1 : ctrl = 8'b0000_1001 ; // MOV A -> B
            4'h2 : ctrl = 8'b0001_0110 ; // MOV A -> X1
            4'h3 : ctrl = 8'b0000_1010 ; // MOV B -> A
            4'h4 : ctrl = 8'b0010_0111 ; // MOV B -> X2
            4'h5 : ctrl = 8'b0011_1000 ; // MOV OP -> X3
            4'h6 : ctrl = 8'b0111_0100 ; // R -> A
            4'h7 : ctrl = 8'b1001_0000 ; // R -> X1
            4'h8 : ctrl = 8'b0111_0101 ; // R -> B
            4'h9 : ctrl = 8'b1010_0000 ; // R -> X2
            4'hA : ctrl = 8'b1000_0000 ; // FLAG -> BUS
            4'hB : ctrl = 8'b0100_0000 ; // LOGIC
            4'hC : ctrl = 8'b0101_0000 ; // ADD
            4'hD : ctrl = 8'b0110_0000 ; // SUB
            4'hF : ctrl = 8'b0000_0000 ; // CLEAR
            default : ctrl = 0 ;
            
        endcase
    end
    else
    begin
        ctrl = 0 ;
    end
end

endmodule