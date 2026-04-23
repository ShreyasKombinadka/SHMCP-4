module rom_ctrl (
    input [7:0] instr,  // Instruction
    output reg [1:0] en // Enable for roms
);

always @( * )
begin
    en = 0 ;
    if ( ~( instr[7] | instr[6] | instr[5] | instr[4] ) )   // Enamble AR rom (ALU and register file)
    begin
        en = 2'b01 ;
    end
    else if ( ( instr[6] | instr[5] ) & ~( instr[7] | instr[4] ) )  // Enable IMM rom (immediate)
    begin
        en = 2'b10 ;
    end
    else if ( instr[7] )    // Enable MEM rom (memory)
    begin
        en = 2'b11 ;
    end
end

endmodule