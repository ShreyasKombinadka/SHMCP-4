module IMMrom (
    input [1:0] en, // ROM operation enable
    input [7:0] instr,  // Istruction
    inout [3:0] bus, // Data bus
    output reg [7:0] ctrl,  // Control bits
    output [3:0] imm    // Immediate value
);

always @( * )
begin
    if ( en == 2'b10 )
    begin
        case ( instr[6:5] )

            2'b00 : ctrl = 8'b0000_0000 ; // NOP
            2'b01 : ctrl = 8'b0001_0001 ; // LDI A & X1
            2'b10 : ctrl = 8'b0010_0010 ; // LDI B & X2
            2'b11 : ctrl = 8'b0011_0011 ; // LDI OP & X3
            default : ctrl = 0 ;
            
        endcase
    end
    else
    begin
        ctrl = 0 ;
    end
end

assign bus = ( en == 2'b10 ) ? instr[3:0] : 4'bZ ;  // Load immidiate value to bus for X registers load
assign imm = ( en == 2'b10 ) ? instr[3:0] : 0 ; // Load immediate value to imm for regfile registers load

endmodule