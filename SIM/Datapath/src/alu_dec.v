module alu_dec( // ALU instruction decoder
    input [3:0] instr,  // Instruction input
    output [1:0] rs,    // Read select
    output [1:0] ws,    // Write select
    output [1:0] op_sel, // ALU operation selector
    output rst          // Reset
);

reg [6:0] ctrl ;    // Control signals

always @( * )
begin
    ctrl = 0 ;  // Default state
    
    //-----------------------------------------------------
    // Instruction decoding
    //-----------------------------------------------------
    case ( instr )
        4'h0 : ctrl = 7'b0000000 ;  // NOP
        4'h1 : ctrl = 7'b0000001 ;  // MOV BUS -> X1
        4'h2 : ctrl = 7'b0000010 ;  // MOV BUS -> X2
        4'h3 : ctrl = 7'b0000011 ;  // MOV BUS -> X3
        4'h4 : ctrl = 7'b0010000 ;  // LOGIC
        4'h5 : ctrl = 7'b0100000 ;  // ADD
        4'h6 : ctrl = 7'b0110000 ;  // SUB
        4'h7 : ctrl = 7'b0000100 ;  // MOV R -> BUS
        4'h8 : ctrl = 7'b0001000 ;  // MOV FLAG -> BUS
        4'h9 : ctrl = 7'b0000101 ;  // MOV R -> X1
        4'hA : ctrl = 7'b0000110 ;  // MOV R -> X2
        4'hF : ctrl = 7'b1000000 ;  // CLEAR
    endcase
end

//-----------------------------------------------------
// Register and ALU control
//-----------------------------------------------------
assign rs = ctrl [1:0] ;
assign ws = ctrl [3:2] ;
assign op_sel = ctrl [5:4] ;
assign rst = ctrl [6] ;

endmodule