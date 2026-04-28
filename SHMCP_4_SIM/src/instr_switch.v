module instr_switch (
    input [1:0] en, // ROM control enable over ALU unit and register file
    input [7:0] ctrl_ar,   // Output of the AR rom
    input [7:0] ctrl_imm,  // Output of the IMM rom
    input [7:0] ctrl_mem,  // Output of the MEM rom
    output [3:0] instr_r,   // Selected register file instruction
    output [3:0] instr_a    // Selected ALU unit instruction
);

reg [7:0] en_instr ;    // Instruction from the enabled rom

always @( * )
begin
    en_instr = 0 ;

    case ( en )

        2'b01 : en_instr = ctrl_ar ;   //  Select AR rom instruction
        2'b10 : en_instr = ctrl_imm ;   // Select IMM rom instruction
        2'b11 : en_instr = ctrl_mem ;   // Select MEM rom instruction
    
    endcase

end

assign instr_r = en_instr [3:0] ;   // Register rom input
assign instr_a = en_instr [7:4] ;   // ALU rom input

endmodule