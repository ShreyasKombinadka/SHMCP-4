module MEMrom (
    input [1:0] en, // ROM operation enable
    input [7:0] instr,  // Istruction
    output reg [7:0] ctrl // Control bits
);

always @( * )
begin
    if ( en == 2'b11 )  // MEM rom enable
    begin
        if( ~instr[4] )  // Read from ROM
        begin
            case ( instr[6:5] )

                2'b00 : ctrl = 8'b0000_0000 ; // NOP
                2'b01 : ctrl = 8'b0000_0100 ; // MOV BUS -> A
                2'b10 : ctrl = 8'b0000_0101 ; // MOV BUS -> B
                2'b11 : ctrl = 8'b0000_1111 ; // CLEAR
                default : ctrl = 0 ;
                
            endcase
        end
        else if ( instr[4] ) // Write to RAM
        begin
            case ( instr[6:5] )

                2'b00 : ctrl = 8'b0000_0000 ; // NOP
                2'b01 : ctrl = 8'b0000_0110 ; // MOV A -> BUS
                2'b10 : ctrl = 8'b0000_0111 ; // MOV B -> BUS
                2'b11 : ctrl = 8'b0111_0000 ; // MOV R -> BUS
                default : ctrl = 0 ;
                    
            endcase
        end
    end
    else
    begin
        ctrl = 0 ;
    end
end

endmodule