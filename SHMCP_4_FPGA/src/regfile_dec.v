module regfile_dec(
    input [3:0] instr,  // Instruction input
    output [2:0] rs,    // Read select
    output [1:0] ws,    // Write select
    output rst          // Reset ( LRST )
);

reg [5:0] ctrl ;    // Control bits

always @( * )
begin
    ctrl = 0 ;  // Default state
    
    //-----------------------------------------------------
    // Instruction decoding
    //-----------------------------------------------------
    case ( instr )
        4'h0 : ctrl = 6'b000000 ;  // NOP
        4'h1 : ctrl = 6'b000001 ;  // LDI A
        4'h2 : ctrl = 6'b000011 ;  // LDI B
        4'h3 : ctrl = 6'b000101 ;  // LDI OP
        4'h4 : ctrl = 6'b000010 ;  // MOV BUS -> A
        4'h5 : ctrl = 6'b000100 ;  // MOV BUS -> B
        4'h6 : ctrl = 6'b001000 ;  // MOV A -> BUS
        4'h7 : ctrl = 6'b010000 ;  // MOV B -> BUS
        4'h8 : ctrl = 6'b011000 ;  // MOV OP -> BUS
        4'h9 : ctrl = 6'b001100 ;  // MOV A -> B
        4'hA : ctrl = 6'b010010 ;  // MOV B -> A
        4'hB : ctrl = 6'b011010 ;  // MOV OP -> A
        4'hC : ctrl = 6'b011100 ;  // MOV OP -> B
        4'hF : ctrl = 6'b100000 ;  // CLEAR
    endcase
end

//-----------------------------------------------------
// Register control
//-----------------------------------------------------
assign rs = ctrl[2:0] ; // Read select
assign ws = ctrl[4:3] ; // Write select
assign rst = ctrl[5] ;  // LRST

endmodule