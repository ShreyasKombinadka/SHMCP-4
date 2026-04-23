module alu_ctrl(    // Register control block
    input [1:0] rs, // Read select
    input [1:0] ws,   // Write select
    output reg rs1, rs2, rs3,   // Read enable
    output reg ws1, ws2  // Write enable
);

always @( * )
begin
    rs1 = 0 ; rs2 = 0 ; rs3 = 0 ; // Default states
    ws1 = 0 ; ws2 = 0 ;

    case ( rs )
        2'b01 : rs1 = 1 ;   // BUS -> X1
        2'b10 : rs2 = 1 ;   // BUS -> X2
        2'b11 : rs3 = 1 ;   // BUS -> X3
    endcase

    case ( ws )
        2'b01 : ws1 = 1 ;   // Result -> BUS
        2'b10 : ws2 = 1 ;   // Flags -> BUS
    endcase

end

endmodule