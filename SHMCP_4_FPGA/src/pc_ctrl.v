module pc_ctrl (
    input [7:0] instr_o,    // Instruction from memory
    output reg [3:0] pc_count,  // Jump address
    output reg [7:0] instr,  // Instruction out for datapath
    inout [3:0] bus // data bus
);

always @( * )
begin
    pc_count = 0 ;
    
    if( ~instr_o[7] & instr_o[4] )  // The instruction for jump statement
    begin
        instr = 8'b0_00_0_1010 ; // FLAG -> BUS

        case ( instr_o[6:5] )
            2'b01 : pc_count = ( ~bus[0] ) ? instr_o[3:0] : 0 ; // JNZ (jump if not equal to zero)
            2'b11 : pc_count = instr[3:0] ; // J (infinite loop)
        endcase
        
    end
    else
    begin
        instr = instr_o ;   // Pass the instruction to datapath
    end
end

endmodule